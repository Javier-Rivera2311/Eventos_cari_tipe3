import 'package:flutter/material.dart';
import 'formulario_compra.dart';
import '../servicios/json_bd_temp.dart';

class HistorialComprasScreen extends StatelessWidget {
  final Map<String, dynamic> proveedor;

  const HistorialComprasScreen({super.key, required this.proveedor});

  @override
  Widget build(BuildContext context) {
    final historial = List<Map<String, dynamic>>.from(proveedor['HistorialCompras'] ?? []);

    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de ${proveedor['Nombre Proveedor']}'),
      ),
      body: historial.isEmpty
          ? const Center(child: Text('No hay compras registradas'))
          : ListView.builder(
              itemCount: historial.length,
              itemBuilder: (context, index) {
                final compra = historial[index];
                return ListTile(
                  leading: const Icon(Icons.shopping_cart),
                  title: Text(compra['detalle']),
                  subtitle: Text('Fecha: ${compra['fecha']} - Monto: \$${compra['monto']}'),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () async {
                final nuevaCompra = await Navigator.push(
                 context,
                  MaterialPageRoute(builder: (context) => const FormularioCompra()),
                );

                if (nuevaCompra != null) {
                  final historial = List<Map<String, dynamic>>.from(proveedor['HistorialCompras'] ?? []);
                  historial.add(nuevaCompra);
                  proveedor['HistorialCompras'] = historial;

                  final todos = await readProviders();
                  final index = todos.indexWhere((p) => p['Nombre Proveedor'] == proveedor['Nombre Proveedor']);
                  if (index != -1) {
                   todos[index] = proveedor;
                    await writeProviders(todos);
                  }

      
                  Navigator.pop(context); 
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistorialComprasScreen(proveedor: proveedor)),
                  );
                }
              },
            ),

    );
  }
}
