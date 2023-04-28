import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> listAvailableSchedules() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Realiza la consulta para obtener todos los turnos
  QuerySnapshot snapshot = await firestore.collection('shifts').get();

  // Agrupa los turnos que se superponen
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

  // Filtra los grupos de turnos que tienen menos de 6 personas asignadas
  List<String> availableSchedules = [];
  for (var shiftGroup in overlappingShiftGroups) {
    if (shiftGroup.length < 6) {
      DateTime startDate = shiftGroup.first['start_date'].toDate();
      DateTime finishDate = shiftGroup.first['finish_date'].toDate();
      availableSchedules
          .add('${startDate.toString()} - ${finishDate.toString()}');
    }
  }

  // Imprime los horarios disponibles en la consola
  print('Horarios disponibles:');
  for (var schedule in availableSchedules) {
    print(schedule);
  }
}
