import 'package:agendanurse/colores/colores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SelectAuxiliar extends StatefulWidget {
  @override
  State<SelectAuxiliar> createState() => _SelectAuxiliarState();
}

class _SelectAuxiliarState extends State<SelectAuxiliar> {
  String dropdownvalue = "Laura López";

  // List of items in our dropdown menu
  var items = [
    "Laura López",
    "Juan Rivas",
    "Mónica Rodríguez",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            "Seleccione auxiliar",
            style: TextStyle(color: colores["azul"]),
          ),
          DropdownButton(
            // Initial Value
            value: dropdownvalue,

            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),

            // Array list of items
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items, style: TextStyle(color: colores["azul"])),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
              });
            },
          ),
        ],
      ),
    );
  }
}
