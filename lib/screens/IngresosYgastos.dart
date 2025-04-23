import 'package:flutter/material.dart';

class IngresosYGastosScreen extends StatelessWidget {
  const IngresosYGastosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingresos y Gastos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navegar a la vista de Comparativas
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ComparativasScreen()), // Elimina 'const'
                );
              },
              child: const Text('Comparativas'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navegar a la vista de Formulario de Registros
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FormularioDeRegistrosScreen()), // Elimina 'const'
                );
              },
              child: const Text('Formulario de Registros'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navegar a la vista de Reporte Financiero
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ReporteFinancieroScreen()), // Elimina 'const'
                );
              },
              child: const Text('Reporte Financiero'),
            ),
          ],
        ),
      ),
    );
  }
}

// Vistas para cada uno de los botones
class ComparativasScreen extends StatelessWidget {
  const ComparativasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comparativas'),
      ),
      body: const Center(
        child: Text('Pantalla de Comparativas', style: TextStyle(fontSize: 25)),
      ),
    );
  }
}

class FormularioDeRegistrosScreen extends StatelessWidget {
  const FormularioDeRegistrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de Registros'),
      ),
      body: const Center(
        child: Text('Formulario de Registros', style: TextStyle(fontSize: 25)),
      ),
    );
  }
}

class ReporteFinancieroScreen extends StatelessWidget {
  const ReporteFinancieroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reporte Financiero'),
      ),
      body: const Center(
        child: Text('Reporte Financiero', style: TextStyle(fontSize: 25)),
      ),
    );
  }
}
