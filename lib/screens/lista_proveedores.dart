import 'package:flutter/material.dart';
import 'transacciones_proveedor.dart';

class ListaProveedores extends StatelessWidget {
  const ListaProveedores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> proveedores = [
      'Proveedor A',
      'Proveedor B',
      'Proveedor C'
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Proveedores')),
      body: ListView.builder(
        itemCount: proveedores.length,
        itemBuilder: (context, index) {
          final proveedor = proveedores[index];
          return ListTile(
            leading: const Icon(Icons.business),
            title: Text(proveedor),
            trailing: IconButton(
              icon: const Icon(Icons.history),
              tooltip: 'Ver historial de transacciones',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        TransaccionesProveedor(nombreProveedor: proveedor),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
