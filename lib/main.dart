import 'package:app/colores/colores.dart';
import 'package:app/widgets/horario.dart';
import 'package:app/widgets/list-turnos.dart';
import 'package:app/widgets/select-auxiliar.dart';
import 'package:app/widgets/select-dia.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Agenda Nurse",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Agenda Nurse"),
          backgroundColor: colores["azul"],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SelectAuxiliar(),
              Horario(),
              SelectDia(),
              TurnosList(),
            ],
          ),
        ));
  }
}
