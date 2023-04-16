import 'package:agendanurse/colores/colores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class InputWindow extends StatelessWidget {
  String value = "";
  // final Function addThis;

  // InputWindow(this.addThis);
  // InputWindow();

  // void editTurno(BuildContext ctx) {
  //   showModalBottomSheet(
  //     context: ctx,
  //     builder: (ctx2) {
  //       return InputWindow(addThis);
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    void mostrarFecha() {
      showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2026));
    }

    void mostrarHora() {
      showTimePicker(context: context, initialTime: TimeOfDay.now());
    }

    return Column(
      children: [
        Container(padding: EdgeInsets.all(10), child: Text("Editar horario")),
        Card(
          child: Container(
            width: double.infinity,
            child: OutlinedButton(
              child: Text("Hora inicio"),
              onPressed: () {
                mostrarHora();
              },
            ),
          ),
        ),
        Card(
          child: Container(
            width: double.infinity,
            child: OutlinedButton(
              child: Text("Hora fin"),
              onPressed: () {
                mostrarHora();
              },
            ),
          ),
        ),
        Card(
          child: Container(
            width: double.infinity,
            child: OutlinedButton(
              child: Text("Ingrese fecha"),
              onPressed: () {
                mostrarFecha();
              },
            ),
          ),
        ),
        Card(
          child: Container(
            width: double.infinity,
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: "Comentario"),
              onChanged: (val) {
                value = val;
              },
            ),
          ),
        ),
        Container(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: colores["verde"]),
            child: Text("Aceptar"),
            onPressed: () {},
          ),
        )
        // Container(
        //   child: TextButton(
        //     onPressed: () {
        //       print("value " + value);
        //       addThis();
        //       editTurno(context);
        //     },
        //     child: Text("Agregar turno"),
        //   ),
        // ),
      ],
    );
  }
}
