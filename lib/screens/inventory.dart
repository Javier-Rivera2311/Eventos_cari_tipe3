import 'package:flutter/material.dart';
import '../widgets/listado_inventario.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  bool mostrarFormulario = false;
  bool mostrarLista = false;
  bool mostrarListadoInventario = false;
  int? itemEditandoIndex;

  final _materialNameController = TextEditingController();
  final _lotIdController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String? _selectedFrequentUse;
  String? _selectedState;

  final List<String> _frequentUseOptions = [
    'Muy Frecuente',
    'Frecuente',
    'Poco Frecuente',
    'Raro'
  ];

  final List<String> _stateOptions = [
    'Excelente',
    'Bueno',
    'Regular',
    'Malo',
    'Fuera de Servicio'
  ];

  final List<Map<String, String>> _inventario = [];

  void _limpiarFormulario() {
    _materialNameController.clear();
    _lotIdController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedFrequentUse = null;
      _selectedState = null;
    });
  }

  void _abrirFormulario({int? index}) {
    if (index != null) {
      final item = _inventario[index];
      _materialNameController.text = item['material_name'] ?? '';
      _lotIdController.text = item['lot_id'] ?? '';
      _descriptionController.text = item['description'] ?? '';
      _selectedFrequentUse = item['frequent_use'];
      _selectedState = item['state'];
      itemEditandoIndex = index;
    } else {
      _limpiarFormulario();
      itemEditandoIndex = null;
    }

    setState(() {
      mostrarFormulario = true;
      mostrarLista = false;
      mostrarListadoInventario = false;
    });
  }

  void _guardarItem() {
    if (_materialNameController.text.isNotEmpty &&
        _lotIdController.text.isNotEmpty &&
        _selectedFrequentUse != null &&
        _selectedState != null) {
      
      final item = {
        'material_name': _materialNameController.text,
        'lot_id': _lotIdController.text,
        'frequent_use': _selectedFrequentUse!,
        'state': _selectedState!,
        'description': _descriptionController.text,
      };

      setState(() {
        if (itemEditandoIndex != null) {
          _inventario[itemEditandoIndex!] = item;
        } else {
          _inventario.add(item);
        }
        _limpiarFormulario();
        mostrarFormulario = false;
        itemEditandoIndex = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(itemEditandoIndex != null 
              ? 'Item actualizado exitosamente' 
              : 'Item agregado exitosamente'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor complete todos los campos requeridos')),
      );
    }
  }

  void _eliminarItem(int index) {
    setState(() {
      _inventario.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Item eliminado del inventario')),
    );
  }

  Widget _buildVistaBotonesBonitos() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 10),
      children: [
        _buildBoton(
          const Color(0xFFA8D5BA),
          Icons.add_box,
          'Agregar Nuevo Item',
          '',
          () => _abrirFormulario(),
        ),
        _buildBoton(
          const Color(0xFF69B4A1),
          Icons.inventory_2,
          'Ver Inventario',
          '${_inventario.length} items registrados',
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ListadoInventario()),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String titulo;
    if (mostrarFormulario) {
      titulo = itemEditandoIndex != null ? 'Editar Item' : 'Agregar Item';
    } else if (mostrarLista) {
      titulo = 'Lista de Inventario';
    } else if (mostrarListadoInventario) {
      titulo = 'Listado de Inventario';
    } else {
      titulo = 'Inventario';
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
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
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (mostrarFormulario || mostrarLista)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          mostrarFormulario = false;
                          mostrarLista = false;
                          itemEditandoIndex = null;
                          _limpiarFormulario();
                        });
                      },
                    ),
                  ),
                Center(
                  child: Text(
                    titulo,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: mostrarFormulario
                  ? _buildFormulario()
                  : mostrarLista
                      ? _buildListaInventario()
                      : _buildVistaBotonesBonitos(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBoton(Color color, IconData icon, String titulo,
      String subtitulo, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titulo,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                if (subtitulo.isNotEmpty)
                  Text(subtitulo,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormulario() {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            controller: _materialNameController,
            decoration: const InputDecoration(
              labelText: 'Nombre del Material *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.build),
            ),
          ),
          const SizedBox(height: 16),
          
          TextFormField(
            controller: _lotIdController,
            decoration: const InputDecoration(
              labelText: 'ID del Lote *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.qr_code),
            ),
          ),
          const SizedBox(height: 16),

          DropdownButtonFormField<String>(
            value: _selectedFrequentUse,
            decoration: const InputDecoration(
              labelText: 'Frecuencia de Uso *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.trending_up),
            ),
            items: _frequentUseOptions.map((option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedFrequentUse = value;
              });
            },
          ),
          const SizedBox(height: 16),

          DropdownButtonFormField<String>(
            value: _selectedState,
            decoration: const InputDecoration(
              labelText: 'Estado *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.info),
            ),
            items: _stateOptions.map((option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedState = value;
              });
            },
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Descripción',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.description),
              hintText: 'Descripción detallada del item...',
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => setState(() {
                  mostrarFormulario = false;
                  itemEditandoIndex = null;
                  _limpiarFormulario();
                }),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF69B4A1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: _guardarItem,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3A7F54),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text(itemEditandoIndex != null ? 'Actualizar' : 'Guardar'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListaInventario() {
    if (_inventario.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No hay items en el inventario',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _inventario.length,
      itemBuilder: (context, index) {
        final item = _inventario[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getStateColor(item['state'] ?? ''),
              child: const Icon(Icons.build, color: Colors.white),
            ),
            title: Text(
              item['material_name'] ?? 'Sin nombre',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text('ID Lote: ${item['lot_id'] ?? 'No disponible'}'),
                Text('Uso: ${item['frequent_use'] ?? 'No especificado'}'),
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
                if (item['description']?.isNotEmpty ?? false)
                  Text(
                    item['description']!,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => _abrirFormulario(index: index),
                  icon: const Icon(Icons.edit, color: Color(0xFF69B4A1)),
                ),
                IconButton(
                  onPressed: () => _eliminarItem(index),
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
            isThreeLine: true,
            contentPadding: const EdgeInsets.symmetric(
                vertical: 12, horizontal: 16),
          ),
        );
      },
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

  @override
  void dispose() {
    _materialNameController.dispose();
    _lotIdController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

