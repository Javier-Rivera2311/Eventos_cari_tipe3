import 'package:flutter/material.dart';
import 'package:my_app/screens/navigate.dart';
import 'package:my_app/screens/home.dart';
import 'package:my_app/screens/inventory.dart';
import 'package:my_app/screens/IngresosYGastos.dart';
import 'package:my_app/screens/clientes.dart';
import 'package:my_app/screens/personal.dart';
import 'package:my_app/screens/eventos.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      // Agregar manejo de rutas para evitar errores
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      },
    );
  }
}