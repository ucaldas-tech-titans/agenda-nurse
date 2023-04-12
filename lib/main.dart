import 'package:app/colores/colores.dart';
import 'package:app/widgets/horario-editable.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Agenda Nurse",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      title: "Agenda Nurse",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HorarioEditable(),
      debugShowCheckedModeBanner: false,
    );
  }
}
