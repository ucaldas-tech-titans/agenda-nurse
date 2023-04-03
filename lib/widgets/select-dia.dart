import 'package:app/colores/colores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SelectDia extends StatefulWidget {
  @override
  State<SelectDia> createState() => _SelectDiaState();
}

class _SelectDiaState extends State<SelectDia> {
  String dropdownvalue = "Lunes";

  // List of items in our dropdown menu
  var items = [
    "Lunes",
    "Martes",
    "Miércoles",
    "Jueves",
    "Viernes",
    "Sábado",
    "Domingo",

  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text("Filtrar por día",style: TextStyle(color: colores["azul"]),),
          DropdownButton(
            // Initial Value
            value: dropdownvalue,
    
            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),
    
            // Array list of items
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items,style: TextStyle(color: colores["azul"]),),
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
