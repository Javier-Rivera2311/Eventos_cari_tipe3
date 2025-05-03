import 'package:flutter/material.dart';
import '../widgets/admission_form.dart';
import '../widgets/withdrawal_form.dart';
import '../widgets/inventory_history.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  // Lista de ejemplo para el inventario
  final List<Map<String, String>> inventory = [
    {'nombre': 'Papel', 'cantidad': '10', 'descripcion': 'Hojas A4'},
    {'nombre': 'Tinta', 'cantidad': '5', 'descripcion': 'Cartuchos de tinta negra'},
    {'nombre': 'Carpetas', 'cantidad': '20', 'descripcion': 'Carpetas plásticas'},
  ];

  // Lista filtrada
  List<Map<String, String>> filteredInventory = [];

  // Controlador para la barra de búsqueda
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredInventory = inventory; // Inicialmente muestra todo el inventario
  }

  // Método para filtrar el inventario
  void _filterInventory(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredInventory = inventory;
      } else {
        filteredInventory = inventory
            .where((item) =>
                item['nombre']!.toLowerCase().contains(query.toLowerCase()) ||
                item['descripcion']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Ver Historial',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InventoryHistory()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Buscar en el inventario',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: _filterInventory,
            ),
          ),
          // Lista del inventario
          Expanded(
            child: ListView.builder(
              itemCount: filteredInventory.length,
              itemBuilder: (context, index) {
                final item = filteredInventory[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(item['nombre']!),
                    subtitle: Text('Cantidad: ${item['cantidad']} \n${item['descripcion']}'),
                    leading: const Icon(Icons.inventory, color: Colors.green),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'add',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AdmissionForm()),
              );
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.add),
            tooltip: 'Agregar Material',
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'remove',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WithdrawalForm()),
              );
            },
            backgroundColor: Colors.red,
            child: const Icon(Icons.remove),
            tooltip: 'Retirar Material',
          ),
        ],
      ),
    );
  }
}