import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<void> inicializarBaseDeDatos() async {
  final path = await _getEditablePath();
  final file = File(path);

  if (!file.existsSync()) {
    final jsonString = await rootBundle.loadString('lib/servicios/proveedores.json');
    await file.writeAsString(jsonString);
  }
}

Future<String> _getEditablePath() async {
  final dir = await getApplicationDocumentsDirectory();
  return '${dir.path}/proveedores.json';
}

Future<List<Map<String, dynamic>>> readProviders() async {
  final path = await _getEditablePath();
  final file = File(path);

  if (!file.existsSync()) return [];

  final contents = await file.readAsString();
  return List<Map<String, dynamic>>.from(jsonDecode(contents));
}


Future<void> writeProviders(List<Map<String, dynamic>> providers) async {
  final path = await _getEditablePath();
  final file = File(path);
  await file.writeAsString(jsonEncode(providers));
}
