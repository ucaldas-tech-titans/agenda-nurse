import 'package:agendanurse/widgets/horario-editable.dart';
import 'package:agendanurse/widgets/horario.dart';
import 'package:agendanurse/widgets/list-turnos.dart';
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
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Agenda Nurse"),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.calendar_today)),
                Tab(icon: Icon(Icons.calendar_today)),
                Tab(icon: Icon(Icons.calendar_today)),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              HorarioEditable(),
              Horario(),
              TurnosList(),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
