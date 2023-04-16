import 'package:agendanurse/models/enfermera.dart';
import 'package:agendanurse/models/turno.dart';
import 'package:flutter/material.dart';

class HorarioEditable extends StatefulWidget {
  const HorarioEditable({super.key});

  @override
  _HorarioEnfermerasState createState() => _HorarioEnfermerasState();
}

class _HorarioEnfermerasState extends State<HorarioEditable> {
  // Lista de enfermeras y sus horarios semanales
  // Esta lista debe ser actualizada según las reglas de negocio
  List<Enfermera> enfermeras = [
    Enfermera(nombre: "Pepita", turnos: [
      Turno(
          id: "id",
          name: "Pepita",
          startDate: DateTime(2023, 4, 12, 8),
          endDate: DateTime(2023, 4, 12, 16)),
    ]),
  ];

  // Lista de días de la semana
  List<DateTime> dias = List.generate(
      7,
      (i) => DateTime.now()
          .subtract(Duration(days: DateTime.now().weekday - 1))
          .add(Duration(days: i)));

  // Horas del día
  List<int> horas = List.generate(24, (i) => i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horario Semanal de Enfermeras'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Table(
              children: [
                TableRow(
                  children: [
                    const TableCell(
                      child: Text(''),
                    ),
                    for (var dia in dias)
                      TableCell(
                        child: Text('${dia.day} ${_nombreDia(dia.weekday)}'),
                      ),
                  ],
                ),
                for (var hora in horas)
                  TableRow(
                    children: [
                      TableCell(
                        child: Text('$hora:00'),
                      ),
                      for (var dia in dias)
                        TableCell(
                          child: GestureDetector(
                            onTap: () {
                              if (!_celdaDisponible(hora, dia)) {
                                // Si la celda no está disponible, no hagas nada
                                return;
                              }
                              Enfermera? enfermera =
                                  _buscarEnfermeraEnCelda(hora, dia);
                              if (enfermera == null) {
                                // Si no hay una enfermera asignada a la celda, asigna un turno
                                if (_turnoValido(hora, dia)) {
                                  _asignarTurno(hora, dia);
                                  setState(
                                      () {}); // Actualiza el estado del componente para reflejar el cambio
                                } else {
                                  // Muestra una advertencia si el turno no es válido
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'No se puede asignar un turno inválido.'),
                                    ),
                                  );
                                }
                              } else {
                                _desasignarTurno(hora, dia);
                                setState(
                                    () {}); // Actualiza el estado del componente para reflejar el cambio
                              }
                            },
                            child: Container(
                              color: _colorCelda(hora, dia),
                              width: 20,
                              height: 20,
                              child: _enfermeraEnCelda(hora, dia),
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _nombreDia(int weekday) {
    switch (weekday) {
      case 1:
        return 'Lunes';
      case 2:
        return 'Martes';
      case 3:
        return 'Miércoles';
      case 4:
        return 'Jueves';
      case 5:
        return 'Viernes';
      case 6:
        return 'Sábado';
      case 7:
        return 'Domingo';
      default:
        return '';
    }
  }

  Color _colorCelda(int hora, DateTime dia) {
    if (!_celdaDisponible(hora, dia)) {
      return Colors.red;
    }
    return Colors.white;
  }

  Widget _enfermeraEnCelda(int hora, DateTime dia) {
    Enfermera? enfermera = _buscarEnfermeraEnCelda(hora, dia);
    if (enfermera != null) {
      return Text(enfermera.nombre);
    }
    return Container();
  }

  bool _celdaDisponible(int hora, DateTime dia) {
    // Aquí puedes agregar la lógica para verificar si la celda está disponible
    // según las reglas de negocio, como la cantidad de personas asignadas.
    return true; // Retornar 'true' o 'false' según la disponibilidad de la celda.
  }

  Enfermera? _buscarEnfermeraEnCelda(int hora, DateTime dia) {
    for (var enfermera in enfermeras) {
      for (var turno in enfermera.turnos) {
        if (turno.startDate.hour == hora &&
            turno.startDate.year == dia.year &&
            turno.startDate.month == dia.month &&
            turno.startDate.day == dia.day) {
          return enfermera;
        }
      }
    }
    return null;
  }

  void _asignarTurno(int hora, DateTime dia) {}

  void _desasignarTurno(int hora, DateTime dia) {
    // Aquí puedes agregar la lógica para desasignar un turno a una enfermera
    // según las reglas de negocio
  }

  bool _turnoValido(int hora, DateTime dia) {
    // Aquí puedes agregar la lógica para validar si un turno es válido
    // según las reglas de negocio
    return true; // Retornar 'true' o 'false' según la validez del turno.
  }

// Puedes agregar funciones adicionales para manejar la lógica
// específica de las reglas de negocio y actualizar el estado del
// componente según sea necesario.
}
