import 'package:app/colores/colores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Horario extends StatelessWidget {
  const Horario({super.key});

  final double marginRow = 3;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(5),
      child: Table(
        border:
            TableBorder.all(color: Color.fromARGB(28, 35, 35, 35), width: 1),
        
        children: [
          TableRow(
            children: [
              Text("", textAlign: TextAlign.center),
              Container(padding: EdgeInsets.all(5),child: Text("Lun", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"],fontWeight: FontWeight.bold),)),
              Container(padding: EdgeInsets.all(5),child: Text("Mar", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"],fontWeight: FontWeight.bold),)),
              Container(padding: EdgeInsets.all(5),child: Text("Mié", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"],fontWeight: FontWeight.bold),)),
              Container(padding: EdgeInsets.all(5),child: Text("Jue", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"],fontWeight: FontWeight.bold),)),
              Container(padding: EdgeInsets.all(5),child: Text("Vie", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"],fontWeight: FontWeight.bold),)),
              Container(padding: EdgeInsets.all(5),child: Text("Sáb", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"],fontWeight: FontWeight.bold),)),
              Container(padding: EdgeInsets.all(5),child: Text("Dom", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"],fontWeight: FontWeight.bold),)),
            ],
          ),
          TableRow(
            children: [
              Text("0", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"]),),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
            ],
          ),
          TableRow(
            children: [
              Text("1", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"]),),
              Container(
                  child: Text(""), color:colores["verde"]),
              Text(""),
              Container(child: Text(""), color: colores["verde"]),
              Text(""),
              Text(""),
              Container(child: Text(""), color:colores["verde"]),
              Container(child: Text(""), color:colores["verde"]),
            ],
          ),
          TableRow(
            children: [
              Text("2", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"]),),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
            ],
          ),
          TableRow(
            children: [
              Text("3", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"]),),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
            ],
          ),
          TableRow(
            children: [
              Text("4", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"]),),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
            ],
          ),
          TableRow(
            children: [
              Text("5", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"]),),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
            ],
          ),
          TableRow(
            children: [
              Text("6", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"]),),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
            ],
          ),
          TableRow(
            children: [
              Text("7", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"]),),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
            ],
          ),
          TableRow(
            children: [
              Text("8", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"]),),
              Text(""),
              Text(""),
              Text(""),
              Container(
                  child: Text(""), color:colores["verde"]),
              Text(""),
              Container(
                  child: Text(""), color:colores["verde"]),
              Text(""),
            ],
          ),
          TableRow(
            children: [
              Text("9", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"]),),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
            ],
          ),
          TableRow(
            children: [
              Text("10", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"]),),
              Text(""),
              Text(""),
              Text(""),
              Container(
                  child: Text(""), color:colores["verde"]),
              Text(""),
              Text(""),
              Text(""),
            ],
          ),
          TableRow(
            children: [
              Text("11", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"]),),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
            ],
          ),
          TableRow(
            children: [
              Text("12", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"]),),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
            ],
          ),
          TableRow(
            children: [
              Text("13", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"]),),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
            ],
          ),
          TableRow(
            children: [
              Text("14", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"]),),
              Text(""),
              Text(""),
              Text(""),
              Container(
                  child: Text(""), color:colores["verde"]),
              Text(""),
              Text(""),
              Text(""),
            ],
          ),
          TableRow(
            children: [
              Text("15", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"]),),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
            ],
          ),
          TableRow(
            children: [
              Text("16", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"]),),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
            ],
          ),
          TableRow(
            children: [
              Text("17", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"]),),
              Text(""),
              Text(""),
              Container(
                  child: Text(""), color:colores["verde"]),
              Text(""),
              Container(
                  child: Text(""), color:colores["verde"]),
              Container(
                  child: Text(""), color:colores["verde"]),
              Text(""),
            ],
          ),
          TableRow(
            children: [
              Text("18", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"]),),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
            ],
          ),
          TableRow(
            children: [
              Text("19", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"]),),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
            ],
          ),
          TableRow(
            children: [
              Text("20", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"]),),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
            ],
          ),
          TableRow(
            children: [
              Text("21", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"]),),
              Text(""),
              Container(
                  child: Text(""), color:colores["verde"]),
              Text(""),
              Container(
                  child: Text(""), color:colores["verde"]),
              Text(""),
              Container(
                  child: Text(""), color:colores["verde"]),
              Text(""),
            ],
          ),
          TableRow(
            children: [
              Text("22", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"]),),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
            ],
          ),
          TableRow(
            children: [
              Text("23", textAlign: TextAlign.center,style: TextStyle(color: colores["azul"]),),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
              Text(""),
            ],
          ),
        ],
      ),
    );
  }
}
