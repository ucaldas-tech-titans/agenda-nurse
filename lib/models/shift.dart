import 'package:cloud_firestore/cloud_firestore.dart';

class Shift {
  final String id;
  String? nurseID;
  DateTime startDate;
  DateTime finishDate;

  Shift(
      {required this.id,
      required this.startDate,
      required this.finishDate,
      required this.nurseID});

  factory Shift.fromFirestoreSnapshot(QueryDocumentSnapshot snapshot) {
    if (!snapshot.exists) {
      throw ArgumentError.value(
          snapshot, 'snapshot', 'The given snapshot must exist');
    }

    if (snapshot.id.isEmpty) {
      throw ArgumentError.value(
        snapshot,
        'snapshot',
        'The given snapshot must contain the key "id"',
      );
    }

    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;

    Timestamp? startDateTimestamp = map['start_date'];
    Timestamp? finishDateTimestamp = map['finish_date'];

    if (startDateTimestamp == null) {
      throw ArgumentError.value(
        snapshot,
        'snapshot',
        'The given snapshot must contain the key "start_date"',
      );
    }

    if (finishDateTimestamp == null) {
      throw ArgumentError.value(
        snapshot,
        'snapshot',
        'The given snapshot must contain the key "finish_date"',
      );
    }

    DateTime startDate = startDateTimestamp.toDate();
    DateTime finishDate = finishDateTimestamp.toDate();

    return Shift(
        id: snapshot.id,
        startDate: startDate,
        finishDate: finishDate,
        nurseID: map['nurse_id']);
  }

  Duration get duration {
    return finishDate.difference(startDate);
  }

  String get subject {
    return '${startDate.day}/${startDate.month}/${startDate.year} - ${startDate.hour}:${startDate.minute} - ${finishDate.hour}:${finishDate.minute}';
  }
}
