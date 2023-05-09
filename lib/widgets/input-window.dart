import 'package:agendanurse/colores/colores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class InputWindow extends StatelessWidget {
  String value = "";

  InputWindow({super.key});
  // final Function addThis;

  // InputWindow(this.addThis);
  // InputWindow();

  // void editShift(BuildContext ctx) {
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
        Container(
            padding: const EdgeInsets.all(10),
            child: const Text("Editar horario")),
        Card(
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              child: const Text("Hora inicio"),
              onPressed: () {
                mostrarHora();
              },
            ),
          ),
        ),
        Card(
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              child: const Text("Hora fin"),
              onPressed: () {
                mostrarHora();
              },
            ),
          ),
        ),
        Card(
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              child: const Text("Ingrese fecha"),
              onPressed: () {
                mostrarFecha();
              },
            ),
          ),
        ),
        Card(
          child: SizedBox(
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
            child: const Text("Aceptar"),
            onPressed: () {},
          ),
        )
        // Container(
        //   child: TextButton(
        //     onPressed: () {
        //       print("value " + value);
        //       addThis();
        //       editShift(context);
        //     },
        //     child: Text("Agregar shift"),
        //   ),
        // ),
      ],
    );
  }
}
