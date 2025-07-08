import 'package:flutter/material.dart';

class ListaProveedores extends StatefulWidget {
  const ListaProveedores({super.key});

  @override
  State<ListaProveedores> createState() => _ListaProveedoresState();
}

class _ListaProveedoresState extends State<ListaProveedores> {
  List<Map<String, String>> proveedores = [
    {
      'id': '1',
      'name': 'Decoraciones Elegantes S.A.',
      'phone': '+58 212-5551234',
      'address': 'Av. Principal, Centro Comercial Plaza, Local 15, Caracas',
      'productos': 'Flores, Centros de mesa, Telas decorativas, Iluminación LED'
    },
    {
      'id': '2',
      'name': 'Catering Gourmet Express',
      'phone': '+58 414-9876543',
      'address': 'Calle Los Mangos 45, Zona Industrial, Valencia',
      'productos': 'Banquetes, Bebidas, Postres, Servicios de meseros'
    },
    {
      'id': '3',
      'name': 'Sonido y Luces Pro',
      'phone': '+58 426-1112233',
      'address': 'Av. Bolívar 123, Sector Norte, Maracaibo',
      'productos': 'Equipos de sonido, Luces disco, Micrófonos, DJ profesional'
    },
    {
      'id': '4',
      'name': 'Mobiliario Para Eventos',
      'phone': '+58 416-4445566',
      'address': 'Zona Industrial Sur, Galpón 8, Barquisimeto',
      'productos': 'Mesas, Sillas, Carpas, Tarimas, Manteles'
    }
  ];
  
  List<Map<String, String>> filteredProveedores = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredProveedores = proveedores;
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
      filteredProveedores = proveedores.where((proveedor) {
        final name = (proveedor['name'] ?? '').toLowerCase();
        return name.contains(query);
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
                  'Proveedores',
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
                  hintText: 'Buscar por nombre',
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
                itemCount: filteredProveedores.length,
                itemBuilder: (context, index) {
                  final proveedor = filteredProveedores[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFF69B4A1),
                        child: Icon(Icons.business, color: Colors.white),
                      ),
                      title: Text(
                        proveedor['name'] ?? 'Sin nombre',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.phone,
                                  size: 16, color: Colors.blueGrey),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  proveedor['phone'] ?? 'No disponible',
                                  style: const TextStyle(fontSize: 15),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  size: 16, color: Colors.blueGrey),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  proveedor['address'] ?? 'No disponible',
                                  style: const TextStyle(fontSize: 15),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Icon(Icons.inventory,
                                  size: 16, color: Colors.blueGrey),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  proveedor['productos'] ?? 'No disponible',
                                  style: const TextStyle(fontSize: 15),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
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
}
