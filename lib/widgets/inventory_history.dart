import 'package:flutter/material.dart';

class InventoryHistory extends StatefulWidget {
  const InventoryHistory({super.key});

  @override
  State<InventoryHistory> createState() => _InventoryHistoryState();
}

class _InventoryHistoryState extends State<InventoryHistory> {
  // Datos de ejemplo para el historial
  List<Map<String, String>> history = [
    {'fecha': '2025-05-01', 'acción': 'Ingreso', 'detalle': '10 unidades de papel'},
    {'fecha': '2025-05-02', 'acción': 'Retiro', 'detalle': '5 unidades de tinta'},
    {'fecha': '2025-05-03', 'acción': 'Ingreso', 'detalle': '20 unidades de carpetas'},
  ];

  // Filtro actual (por defecto muestra ambos)
  String filtroActual = 'Ambos';

  // Método para filtrar los datos según el filtro seleccionado
  List<Map<String, String>> _filtrarHistorial() {
    if (filtroActual == 'Ingreso') {
      return history.where((item) => item['acción'] == 'Ingreso').toList();
    } else if (filtroActual == 'Retiro') {
      return history.where((item) => item['acción'] == 'Retiro').toList();
    }
    return history; // Por defecto muestra ambos
  }

  // Método para ordenar por fecha (más reciente primero)
  void _ordenarPorFechaReciente() {
    setState(() {
      history.sort((a, b) => b['fecha']!.compareTo(a['fecha']!));
    });
  }

  // Método para ordenar por fecha (más viejo primero)
  void _ordenarPorFechaVieja() {
    setState(() {
      history.sort((a, b) => a['fecha']!.compareTo(b['fecha']!));
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> historialFiltrado = _filtrarHistorial();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial del Inventario'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Más reciente') {
                _ordenarPorFechaReciente();
              } else if (value == 'Más viejo') {
                _ordenarPorFechaVieja();
              } else {
                setState(() {
                  filtroActual = value;
                });
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'Más reciente',
                child: Text('Ordenar por más reciente'),
              ),
              const PopupMenuItem(
                value: 'Más viejo',
                child: Text('Ordenar por más viejo'),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'Ambos',
                child: Text('Mostrar ambos'),
              ),
              const PopupMenuItem(
                value: 'Ingreso',
                child: Text('Mostrar solo ingresos'),
              ),
              const PopupMenuItem(
                value: 'Retiro',
                child: Text('Mostrar solo retiros'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: historialFiltrado.length,
          itemBuilder: (context, index) {
            final item = historialFiltrado[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: Icon(
                  item['acción'] == 'Ingreso' ? Icons.add : Icons.remove,
                  color: item['acción'] == 'Ingreso' ? Colors.green : Colors.red,
                ),
                title: Text(item['detalle']!),
                subtitle: Text('Fecha: ${item['fecha']}'),
                trailing: Text(
                  item['acción']!,
                  style: TextStyle(
                    color: item['acción'] == 'Ingreso' ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}