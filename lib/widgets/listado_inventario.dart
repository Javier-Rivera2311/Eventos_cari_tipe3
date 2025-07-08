import 'package:flutter/material.dart';

class ListadoInventario extends StatefulWidget {
  const ListadoInventario({super.key});

  @override
  State<ListadoInventario> createState() => _ListadoInventarioState();
}

class _ListadoInventarioState extends State<ListadoInventario> {
  List<Map<String, String>> inventario = [
    {
      'id': '1',
      'material_name': 'Mesa Redonda 8 Personas',
      'lot_id': 'MR-001',
      'frequent_use': 'Muy Frecuente',
      'state': 'Excelente',
      'description': 'Mesa redonda de madera para 8 personas, color caoba'
    },
    {
      'id': '2',
      'material_name': 'Sillas Chiavari Doradas',
      'lot_id': 'SCH-025',
      'frequent_use': 'Muy Frecuente',
      'state': 'Bueno',
      'description': 'Set de 50 sillas chiavari color dorado con cojines beige'
    },
    {
      'id': '3',
      'material_name': 'Globos de Látex Multicolores',
      'lot_id': 'GL-100',
      'frequent_use': 'Muy Frecuente',
      'state': 'Excelente',
      'description': 'Pack de 500 globos de látex en colores variados para decoración'
    },
    {
      'id': '4',
      'material_name': 'Candy Bar Completo',
      'lot_id': 'CB-035',
      'frequent_use': 'Frecuente',
      'state': 'Bueno',
      'description': 'Estructura de madera para candy bar con estantes y decoración'
    },
    {
      'id': '5',
      'material_name': 'Globos Metálicos Números',
      'lot_id': 'GMN-020',
      'frequent_use': 'Frecuente',
      'state': 'Excelente',
      'description': 'Set completo de números 0-9 en globos metálicos dorados y plateados'
    },
    {
      'id': '6',
      'material_name': 'Dulces y Golosinas Variadas',
      'lot_id': 'DG-150',
      'frequent_use': 'Muy Frecuente',
      'state': 'Bueno',
      'description': 'Surtido de dulces, chocolates y golosinas para candy bar'
    },
    {
      'id': '7',
      'material_name': 'Globos Gigantes 90cm',
      'lot_id': 'GG-012',
      'frequent_use': 'Poco Frecuente',
      'state': 'Excelente',
      'description': 'Globos de látex gigantes de 90cm en colores pastel'
    },
    {
      'id': '8',
      'material_name': 'Mantel Blanco 3x3m',
      'lot_id': 'MB-033',
      'frequent_use': 'Frecuente',
      'state': 'Bueno',
      'description': 'Manteles blancos de tela premium, resistentes a manchas'
    },
    {
      'id': '9',
      'material_name': 'Recipientes para Candy Bar',
      'lot_id': 'RCB-080',
      'frequent_use': 'Frecuente',
      'state': 'Bueno',
      'description': 'Set de recipientes de vidrio y acrílico para dulces y golosinas'
    },
    {
      'id': '10',
      'material_name': 'Globos con Helio Kit',
      'lot_id': 'GH-045',
      'frequent_use': 'Muy Frecuente',
      'state': 'Regular',
      'description': 'Kit completo con globos y tanque de helio portátil'
    },
    {
      'id': '11',
      'material_name': 'Sistema de Sonido Profesional',
      'lot_id': 'SS-007',
      'frequent_use': 'Frecuente',
      'state': 'Regular',
      'description': 'Equipo de sonido con micrófonos inalámbricos y mezcladora'
    },
    {
      'id': '12',
      'material_name': 'Arco de Globos Base',
      'lot_id': 'AGB-018',
      'frequent_use': 'Poco Frecuente',
      'state': 'Excelente',
      'description': 'Estructura metálica para crear arcos de globos decorativos'
    },
    {
      'id': '13',
      'material_name': 'Vajilla Porcelana Blanca',
      'lot_id': 'VP-042',
      'frequent_use': 'Muy Frecuente',
      'state': 'Malo',
      'description': 'Set de vajilla de porcelana para 100 personas'
    }
  ];
  
  List<Map<String, String>> filteredInventario = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredInventario = inventario;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredInventario = inventario.where((item) {
        final materialName = (item['material_name'] ?? '').toLowerCase();
        final lotId = (item['lot_id'] ?? '').toLowerCase();
        return materialName.contains(query) || lotId.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFA8D5BA),
                    Color(0xFF69B4A1),
                    Color(0xFFA4D679),
                    Color(0xFF3A7F54),
                  ],
                ),
              ),
              child: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                title: const Text(
                  'Inventario',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar por material o ID de lote',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 0, horizontal: 16),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12.0),
                itemCount: filteredInventario.length,
                itemBuilder: (context, index) {
                  final item = filteredInventario[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: _getStateColor(item['state'] ?? ''),
                        child: Icon(Icons.inventory_2, color: Colors.white),
                      ),
                      title: Text(
                        item['material_name'] ?? 'Sin nombre',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.qr_code,
                                  size: 16, color: Colors.blueGrey),
                              const SizedBox(width: 4),
                              Text(
                                'ID: ${item['lot_id'] ?? 'No disponible'}',
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Icon(Icons.trending_up,
                                  size: 16, color: Colors.blueGrey),
                              const SizedBox(width: 4),
                              Text(
                                'Uso: ${item['frequent_use'] ?? 'No especificado'}',
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getStateColor(item['state'] ?? ''),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              item['state'] ?? 'Sin estado',
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                          if (item['description']?.isNotEmpty ?? false) ...[
                            const SizedBox(height: 4),
                            Text(
                              item['description']!,
                              style: const TextStyle(fontSize: 13, color: Colors.grey),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                      isThreeLine: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStateColor(String state) {
    switch (state.toLowerCase()) {
      case 'excelente':
        return Colors.green;
      case 'bueno':
        return Colors.lightGreen;
      case 'regular':
        return Colors.orange;
      case 'malo':
        return Colors.red;
      case 'fuera de servicio':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}
