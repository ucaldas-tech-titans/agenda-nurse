import 'package:agendanurse/models/nurse.dart';
import 'package:agendanurse/models/shift.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<List<DateTime>>> listUnavailableSchedules() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Realiza la consulta para obtener todos los shifts
  QuerySnapshot snapshot = await firestore.collection('shifts').get();

  // Agrupa los shifts que se superponen
  List<List<QueryDocumentSnapshot>> overlappingShiftGroups = [];
  for (var shift in snapshot.docs) {
    bool shiftAdded = false;
    DateTime shiftStartDate = shift['start_date'].toDate();
    DateTime shiftFinishDate = shift['finish_date'].toDate();

    for (List<QueryDocumentSnapshot> shiftGroup in overlappingShiftGroups) {
      QueryDocumentSnapshot firstShiftInGroup = shiftGroup.first;
      DateTime groupStartDate = firstShiftInGroup['start_date'].toDate();
      DateTime groupFinishDate = firstShiftInGroup['finish_date'].toDate();

      bool shiftsOverlap = shiftStartDate.isBefore(groupFinishDate) &&
          shiftFinishDate.isAfter(groupStartDate);

      if (shiftsOverlap) {
        shiftGroup.add(shift);
        shiftAdded = true;
        break;
      }
    }

    if (!shiftAdded) {
      overlappingShiftGroups.add([shift]);
    }
  }

  // Filtra los grupos de shifts que tienen menos de 6 personas asignadas
  List<List<DateTime>> unavailableSchedules = [];

  for (var shiftGroup in overlappingShiftGroups) {
    if (shiftGroup.length < 6) {
      continue;
    }

    DateTime startDate = shiftGroup.first['start_date'].toDate();
    DateTime finishDate = shiftGroup.first['finish_date'].toDate();

    unavailableSchedules.add([startDate, finishDate]);
  }

  return unavailableSchedules;
}

Future<List<Shift>> listNurseShifts(Nurse nurse) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Realiza la consulta para obtener todos los shifts
  QuerySnapshot snapshot = await firestore
      .collection('shifts')
      .where('nurse_id', isEqualTo: nurse.id)
      .get();

  List<Shift> shifts =
      snapshot.docs.map((doc) => Shift.fromFirestoreSnapshot(doc)).toList();

  return shifts;
}

Future<QuerySnapshot> listWeekShifts() async {
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

  return snapshot;
}
