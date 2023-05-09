import 'package:agendanurse/models/nurse.dart';
import 'package:agendanurse/models/shift_calendar_data_source.dart';
import 'package:agendanurse/services/shifts.dart';
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
  Shift? _originalShift;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      List<Shift> displayShifts = widget.shifts;

      displayShifts = displayShifts.where((shift) {
        return shift.nurseID == widget.nurse.id;
      }).toList();

      // Agrupa los shifts que se superponen
      List<List<Shift>> overlappingShiftGroups = [];
      for (var shift in widget.shifts) {
        bool shiftAdded = false;
        DateTime shiftStartDate = shift.startDate;
        DateTime shiftFinishDate = shift.finishDate;

        for (List<Shift> shiftGroup in overlappingShiftGroups) {
          Shift firstShiftInGroup = shiftGroup.first;
          DateTime groupStartDate = firstShiftInGroup.startDate;
          DateTime groupFinishDate = firstShiftInGroup.finishDate;

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
      List<Shift> busyShifts = [];

      for (var shiftGroup in overlappingShiftGroups) {
        if (shiftGroup.length < 6) {
          continue;
        }

        DateTime startDate = shiftGroup.first.startDate;
        DateTime finishDate = shiftGroup.first.finishDate;

        busyShifts.add(Shift(
          id: '',
          startDate: startDate,
          finishDate: finishDate,
          nurseID: widget.nurse.id,
        ));
      }

      displayShifts.addAll(busyShifts);

      return _buildCalendar(displayShifts);
    });
  }

  SfCalendar _buildCalendar(List<Shift> shifts) {
    return SfCalendar(
      view: CalendarView.week,
      dataSource: ShiftDataSource(shifts, widget.nurse),
      allowAppointmentResize: true,
      onTap: _tap,
      onAppointmentResizeEnd: _appointmentResizeEnd,
      onAppointmentResizeStart: _appointmentResizeStart,
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
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showEditDialog(shift);
              },
              child: const Text('Edit'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _editShift(Shift newShift) async {
    return updateShift(newShift);
  }

  Future<void> _addShift(Shift shift) async {
    if (_shiftOverlaps(shift)) {
      return;
    }

    try {
      await createShift(shift);
    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Error'),
            content: Text('Error adding shift'),
          );
        },
      );
    }
  }

  Future<void> _deleteShift(String shiftID) async {
    try {
      await deleteShift(shiftID);
    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Error'),
            content: Text('Error deleting shift'),
          );
        },
      );
    }
  }

  void _showDeleteShiftDialog(Shift shift) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure you want to delete this shift?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('From: ${shift.startDate}'),
              Text('To: ${shift.finishDate}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteShift(shift.id);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(Shift shift) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit shift'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('From: ${shift.startDate}'),
              Text('To: ${shift.finishDate}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showDeleteShiftDialog(shift);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _tap(CalendarTapDetails details) {
    if (details.targetElement != CalendarElement.appointment) {
      _addShift(Shift(
        id: '',
        startDate: details.date!,
        finishDate: details.date!.add(const Duration(hours: 1)),
        nurseID: widget.nurse.id,
      ));

      return;
    }

    dynamic appointment = details.appointments!.first;
    if (appointment is! Shift) {
      return;
    }

    _showShiftDetails(context, appointment);
  }

  void _appointmentResizeStart(
      AppointmentResizeStartDetails appointmentResizeStartDetails) {
    dynamic appointment = appointmentResizeStartDetails.appointment;
    if (appointment is! Shift) {
      return;
    }

    _originalShift = appointment;
  }

  Future<void> _appointmentResizeEnd(
      AppointmentResizeEndDetails appointmentResizeEndDetails) async {
    dynamic appointment = appointmentResizeEndDetails.appointment;
    if (appointment is! Shift) {
      return;
    }

    Shift shift = appointment;

    if (appointment.type == ShiftType.BUSY) {
      setState(() {
        appointment.startDate = _originalShift!.startDate;
        appointment.finishDate = _originalShift!.finishDate;
      });

      _originalShift = null;

      return;
    }

    if (_shiftOverlaps(shift)) {
      setState(() {
        appointment.startDate = _originalShift!.startDate;
        appointment.finishDate = _originalShift!.finishDate;
      });

      _originalShift = null;

      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Error'),
            content: Text('Shift overlaps with another shift'),
          );
        },
      );

      return;
    }

    // Set nearest hour as start time
    DateTime startTime = shift.startDate;
    startTime = DateTime(
      startTime.year,
      startTime.month,
      startTime.day,
      startTime.hour + (startTime.minute >= 30 ? 1 : 0),
    );

    // Set nearest hour as finish time
    DateTime finishTime = shift.finishDate;
    finishTime = DateTime(
      finishTime.year,
      finishTime.month,
      finishTime.day,
      finishTime.hour + (finishTime.minute >= 30 ? 1 : 0),
    );

    try {
      await _editShift(
        Shift(
            id: appointment.id,
            startDate: startTime,
            finishDate: finishTime,
            nurseID: widget.nurse.id),
      );
    } catch (e) {
      setState(() {
        appointment.startDate = _originalShift!.startDate;
        appointment.finishDate = _originalShift!.finishDate;
      });

      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Error'),
              content: Text('Error editing shift'),
            );
          });
    } finally {
      setState(() {
        _originalShift = null;
      });
    }
  }

  bool _shiftOverlaps(Shift shift) {
    return widget.shifts
        .where((s) => s.nurseID == shift.nurseID)
        .any((s) => shift.overlaps(s));
  }
}
