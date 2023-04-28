import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> listNursesByHours() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Calcula la fecha y hora del inicio de la semana actual
  DateTime now = DateTime.now();
  DateTime startOfWeek = now.subtract(Duration(
      days: now.weekday - 1,
      hours: now.hour,
      minutes: now.minute,
      seconds: now.second));

  // Realiza la consulta para obtener las horas trabajadas de cada enfermera en la semana actual
  QuerySnapshot snapshot = await firestore
      .collection('shifts')
      .where('start_date', isGreaterThanOrEqualTo: startOfWeek)
      .get();

  // Calcula las horas trabajadas por cada enfermera
  Map<String, double> nurseHours = {};
  for (var shift in snapshot.docs) {
    String nurseId = shift['nurse_id'];
    DateTime startDate = shift['start_date'].toDate();
    DateTime finishDate = shift['finish_date'].toDate();
    double hoursWorked = finishDate.difference(startDate).inHours.toDouble();

    if (nurseHours.containsKey(nurseId)) {
      nurseHours[nurseId] = (nurseHours[nurseId] ?? 0) + hoursWorked;
    } else {
      nurseHours[nurseId] = hoursWorked;
    }
  }

  // Filtra las enfermeras que no han cumplido 44 horas en la semana
  List<String> filteredNurseIds =
      nurseHours.keys.where((nurseId) => nurseHours[nurseId]! < 44).toList();

  // Consulta las enfermeras filtradas y las ordena por horas trabajadas
  List<QueryDocumentSnapshot> nurses = [];
  for (String nurseId in filteredNurseIds) {
    DocumentSnapshot nurseSnapshot =
        await firestore.collection('nurses').doc(nurseId).get();
    nurses.add(nurseSnapshot as QueryDocumentSnapshot);
  }
  nurses.sort((a, b) => nurseHours[a.id]!.compareTo(nurseHours[b.id]!));

  // Imprime las enfermeras ordenadas por horas trabajadas
  for (var nurse in nurses) {
    print(
        'Enfermera: ${nurse['full_name']}, DNI: ${nurse['dni']}, Horas trabajadas: ${nurseHours[nurse.id]!}');
  }
}
