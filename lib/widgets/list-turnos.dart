import 'package:app/colores/colores.dart';
import 'package:app/models/turno.dart';
import 'package:app/widgets/input-window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import "package:intl/intl.dart";

class TurnosList extends StatefulWidget {
  const TurnosList({super.key});

  @override
  State<TurnosList> createState() => _TurnosListState();
}

class _TurnosListState extends State<TurnosList> {
  List<Turno> turnos = [
    Turno(
        id: "id",
        name: "Juan Rivas",
        startDate: DateTime(2023, 2, 3),
        endDate: DateTime(2023, 2, 3)),
    Turno(
        id: "id",
        name: "Mónica Rodríguez",
        startDate: DateTime(2022, 5, 3),
        endDate: DateTime(2022, 5, 3)),
  ];

  void addTurno() {
    setState(() {
      turnos.add(Turno(
          id: "id",
          name: "abc",
          startDate: DateTime.now(),
          endDate: DateTime.now().add(Duration(hours: 8))));
    });
  }

  void window(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return InputWindow();
        });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Turnos asignados para esta semana",
              style: TextStyle(color: colores["azul"]),
            ),
            Column(
              children: turnos.map((turno) {
                return Card(
                  color: colores["blanco"],
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              turno.name,
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: colores["azul"]),
                            ),
                            Text(
                                style: TextStyle(color: colores["negro"]),
                                DateFormat.yMMMMEEEEd()
                                    .format(turno.startDate)),
                            Text(
                              style: TextStyle(color: colores["negro"]),
                              DateFormat.jm().format(turno.startDate),
                            ),
                            Container(
                              child: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  window(context);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
