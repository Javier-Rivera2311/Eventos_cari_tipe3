import 'package:flutter/material.dart';
import '../servicios/json_bd_temp.dart';
import 'formulario_proveedores.dart';
import 'historial_compras.dart';

class ListaProveedoresScreen extends StatefulWidget {
  const ListaProveedoresScreen({super.key});

  @override
  State<ListaProveedoresScreen> createState() => _ListaProveedoresScreenState();
}

class _ListaProveedoresScreenState extends State<ListaProveedoresScreen> {
  List<Map<String, dynamic>> proveedores = [];

  @override
  void initState() {
    super.initState();
    _cargarProveedores();
  }

  Future<void> _cargarProveedores() async {
    final data = await readProviders();
    setState(() {
      proveedores = data;
    });
  }

  Future<void> _editarProveedor(Map<String, dynamic> proveedor) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormularioProveedores(existingProvider: proveedor),
      ),
    );

    if (result != null) {
      await _cargarProveedores();
    }
  }

  void _verHistorial(Map<String, dynamic> proveedor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistorialComprasScreen(proveedor: proveedor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Proveedores")),
      body: proveedores.isEmpty
          ? const Center(child: Text("No hay proveedores registrados"))
          : ListView.builder(
              itemCount: proveedores.length,
              itemBuilder: (context, index) {
                final p = proveedores[index];
                return Dismissible(
                  key: Key(p['Nombre Proveedor']),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.horizontal,
                  onDismissed: (direction) async {
                    setState(() {
                      proveedores.removeAt(index);
                    });
                    await writeProviders(proveedores);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Proveedor eliminado")),
                    );
                  },
                  child: ListTile(
                    title: Text(p['Nombre Proveedor']),
                    subtitle: Text(p['Correo']),
                    trailing: Wrap(
                      spacing: 10,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.history),
                          tooltip: 'Ver historial',
                          onPressed: () => _verHistorial(p),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          tooltip: 'Editar proveedor',
                          onPressed: () => _editarProveedor(p),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'init',
            backgroundColor: Colors.orange,
            child: const Icon(Icons.refresh),
            tooltip: 'Inicializar base de datos',
            onPressed: () async {
              await inicializarBaseDeDatos();
              await _cargarProveedores();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Base de datos inicializada")),
              );
            },
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'add',
            child: const Icon(Icons.add),
            tooltip: 'Agregar proveedor',
            onPressed: () async {
              final nuevoProveedor = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FormularioProveedores()),
              );
              if (nuevoProveedor != null) {
                await _cargarProveedores();
              }
            },
          ),
        ],
      ),
    );
  }
}
