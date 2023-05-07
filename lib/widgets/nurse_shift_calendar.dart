import 'package:agendanurse/models/nurse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:agendanurse/models/shift.dart';

class NurseShiftCalendar extends StatefulWidget {
  final Nurse nurse;
  final List<Shift> shifts;

  const NurseShiftCalendar(
      {super.key, required this.nurse, required this.shifts});

  @override
  _NurseShiftCalendarState createState() => _NurseShiftCalendarState();
}

class _NurseShiftCalendarState extends State<NurseShiftCalendar> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>> selectedNurseShiftsStream =
        FirebaseFirestore.instance
            .collection('shifts')
            .where('nurse_id', isEqualTo: widget.nurse.id)
            .snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: selectedNurseShiftsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          QuerySnapshot selectedNurseShiftsQuerySnapshot = snapshot.data!;

          if (selectedNurseShiftsQuerySnapshot.docs.isEmpty) {
            return const Text('No shifts found');
          }

          List<Shift> selectedNurseShifts = [];

          for (var shiftDoc in selectedNurseShiftsQuerySnapshot.docs) {
            try {
              selectedNurseShifts.add(Shift.fromFirestoreSnapshot(shiftDoc));
            } catch (e) {
              print(
                  "Error loading shift: ${shiftDoc.id} - ${shiftDoc.data()} - $e");
            }
          }

          return _buildCalendar(selectedNurseShifts);
        });
  }

  SfCalendar _buildCalendar(List<Shift> shifts) {
    return SfCalendar(
      view: CalendarView.week,
      dataSource: ShiftDataSource(shifts),
      allowAppointmentResize: true,
      onTap: _tap,
      onLongPress: _longPress,
      onAppointmentResizeEnd: _appointmentResizeEnd,
    );
  }

  void _showShiftDetails(BuildContext context, dynamic appointment) {
    final Shift shift = appointment as Shift;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(widget.nurse.name),
          content: Text(
            'From: ${shift.startDate}\nTo: ${shift.finishDate}',
          ),
        );
      },
    );
  }

  void _editShift(Shift newShift) {
    // Add the implementation to edit the appointment.
    print("Edit Shift: $newShift");
  }

  void _addShift(Shift shift) {
    // Add the implementation to add a new appointment.
    print("Add Shift: $shift");
  }

  void _showEditModal(Shift shift) {
    // Add the implementation to show the appointment editor based on the shift.
    print("Show Edit Modal: $shift");
  }

  void _longPress(CalendarLongPressDetails details) {
    if (details.targetElement != CalendarElement.appointment) {
      return;
    }

    _showShiftDetails(context, details.appointments![0]);
  }

  void _tap(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment) {
      _showEditModal(details.targetElement as Shift);
      return;
    }

    _addShift(Shift(
      id: '',
      startDate: details.date!,
      finishDate: details.date!.add(const Duration(hours: 1)),
      nurseID: widget.nurse.id,
    ));
  }

  void _appointmentResizeEnd(
      AppointmentResizeEndDetails appointmentResizeEndDetails) {
    dynamic appointment = appointmentResizeEndDetails.appointment;
    DateTime? startTime = appointmentResizeEndDetails.startTime;
    DateTime? endTime = appointmentResizeEndDetails.endTime;
    CalendarResource? resourceDetails = appointmentResizeEndDetails.resource;

    _editShift(
      Shift(
        id: appointment.id,
        startDate: startTime!,
        finishDate: endTime!,
        nurseID: widget.nurse.id,
      ),
    );
  }

  List<Shift> _getDataSource() {
    return widget.shifts;
  }
}

class ShiftDataSource extends CalendarDataSource<Shift> {
  ShiftDataSource(List<Shift> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getShiftData(index).startDate;
  }

  @override
  DateTime getEndTime(int index) {
    return _getShiftData(index).finishDate;
  }

  @override
  String getSubject(int index) {
    return _getShiftData(index).subject;
  }

  @override
  Color getColor(int index) {
    return index % 2 == 0 ? Colors.green : Colors.red;
  }

  @override
  Shift convertAppointmentToObject(Shift customData, Appointment appointment) {
    return Shift(
      id: customData.id,
      startDate: appointment.startTime,
      finishDate: appointment.endTime,
      nurseID: customData.nurseID,
    );
  }

  Shift _getShiftData(int index) {
    final dynamic shift = appointments![index];
    late final Shift shiftData;
    if (shift is Shift) {
      shiftData = shift;
    }

    return shiftData;
  }
}
