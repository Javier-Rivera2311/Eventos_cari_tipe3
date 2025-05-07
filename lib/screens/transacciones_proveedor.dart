import 'package:flutter/material.dart';

class TransaccionesProveedor extends StatelessWidget {
  final String nombreProveedor;

  const TransaccionesProveedor({Key? key, required this.nombreProveedor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Simulamos algunas transacciones
    final transacciones = [
      {
        'fecha': '2025-05-01',
        'detalle': 'Compra de insumos',
        'monto': '\$250.000'
      },
      {
        'fecha': '2025-04-15',
        'detalle': 'Pago de servicios',
        'monto': '\$120.000'
      },
      {
        'fecha': '2025-03-30',
        'detalle': 'Entrega de materiales',
        'monto': '\$500.000'
      },
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Historial - $nombreProveedor')),
      body: ListView.builder(
        itemCount: transacciones.length,
        itemBuilder: (context, index) {
          final t = transacciones[index];
          return ListTile(
            leading: const Icon(Icons.monetization_on),
            title: Text(t['detalle']!),
            subtitle: Text('Fecha: ${t['fecha']}'),
            trailing: Text(t['monto']!,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          );
        },
      ),
    );
  }
}
