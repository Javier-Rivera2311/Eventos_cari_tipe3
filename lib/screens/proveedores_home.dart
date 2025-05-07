import 'package:flutter/material.dart';
import 'formulario_proveedores.dart';
import 'lista_proveedores.dart';

class ProveedoresHome extends StatelessWidget {
  const ProveedoresHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestión de Proveedores')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const FormularioProveedores()),
                );
              },
              icon: const Icon(Icons.person_add),
              label: const Text('Registrar nuevo proveedor'),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ListaProveedores()),
                );
              },
              icon: const Icon(Icons.list_alt),
              label: const Text('Ver lista de proveedores'),
            ),
          ],
        ),
      ),
    );
  }
}
