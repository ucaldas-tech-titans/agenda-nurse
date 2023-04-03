import 'package:app/colores/colores.dart';
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

    return Column(
      children: [
        Card(
          child: Container(
            width: double.infinity,
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Hora inicio"),
              onChanged: (val) {
                value = val;
              },
            ),
          ),
        ),
        Card(
          child: Container(
            width: double.infinity,
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Hora fin"),
              onChanged: (val) {
                value = val;
              },
            ),
          ),
        ),
        Card(
          child: Container(
            width: double.infinity,
            child: TextField(
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(labelText: "Comentario"),
              onChanged: (val) {
                value = val;
              },
            ),
          ),
        ),
        Container(
          child: OutlinedButton(
            child: Text("Ingrese fecha"),
            onPressed: mostrarFecha,
          ),
        ),
        Container(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: colores["verde"]),
            child: Text("Aceptar"),
            onPressed: (){},
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
