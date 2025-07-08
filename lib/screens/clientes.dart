import 'package:flutter/material.dart';
import '../widgets/lista_clientes.dart';
import '../widgets/lista_proveedores.dart';
import '../widgets/historial_eventos_clientes.dart';

class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  State<Screen3> createState() => _Screen3State();
}

class Evento {
  String nombre;
  String estado;

  Evento({required this.nombre, this.estado = 'Pendiente'});
}
class Cliente {
  String nombre;
  String email;
  String contacto;
  String direccion;
  String infoAdicional;
  List<Evento> eventos;

  Cliente({
    required this.nombre,
    required this.email,
    required this.contacto,
    required this.direccion,
    required this.infoAdicional,
    this.eventos = const [],
  });
}

class _Screen3State extends State<Screen3> {
  bool mostrarFormulario = false;
  bool mostrarLista = false;
  bool mostrarHistorial = false;
  bool mostrarListaClientes = false;
  bool mostrarListaProveedores = false;
  bool mostrarFormularioProveedor = false;
  bool mostrarHistorialEventos = false;
  int? clienteEditandoIndex;
  int? clienteSeleccionadoIndex;

  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactoController = TextEditingController();
  final _direccionController = TextEditingController();
  final _infoAdicionalController = TextEditingController();

  final List<Cliente> _clientes = [];

  @override
  Widget build(BuildContext context) {
    String titulo;
    if (mostrarFormulario) {
      titulo = clienteEditandoIndex != null
          ? 'Editar Cliente'
          : 'Formulario de Cliente';
    } else if (mostrarFormularioProveedor) {
      titulo = 'Registrar Proveedor';
    } else if (mostrarLista) {
      titulo = 'Lista de Clientes';
    } else if (mostrarHistorial) {
      titulo = 'Historial de Cliente';
    } else {
      titulo = 'Clientes';
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
                if (mostrarFormulario || mostrarLista || mostrarHistorial || mostrarFormularioProveedor)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          mostrarFormulario = false;
                          mostrarLista = false;
                          mostrarHistorial = false;
                          mostrarFormularioProveedor = false;
                          clienteEditandoIndex = null;
                          clienteSeleccionadoIndex = null;
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
                  : mostrarFormularioProveedor
                      ? _buildFormularioProveedor()
                      : mostrarLista
                          ? _buildListaClientes()
                          : mostrarHistorial
                              ? _buildHistorialClientes()
                              : _buildVistaBotonesBonitos(),
            ),
          ),
        ],
      ),
    );
  }

  void _abrirFormulario({int? index}) {
    if (index != null) {
      final cliente = _clientes[index];
      _nombreController.text = cliente.nombre;
      _emailController.text = cliente.email;
      _contactoController.text = cliente.contacto;
      _direccionController.text = cliente.direccion;
      _infoAdicionalController.text = cliente.infoAdicional;
      clienteEditandoIndex = index;
    } else {
      _limpiarFormulario();
      clienteEditandoIndex = null;
    }

    setState(() {
      mostrarFormulario = true;
      mostrarLista = false;
      mostrarHistorial = false;
    });
  }

  void _limpiarFormulario() {
    _nombreController.clear();
    _emailController.clear();
    _contactoController.clear();
    _direccionController.clear();
    _infoAdicionalController.clear();
  }

  void _guardarCliente() {
    final cliente = Cliente(
      nombre: _nombreController.text,
      email: _emailController.text,
      contacto: _contactoController.text,
      direccion: _direccionController.text,
      infoAdicional: _infoAdicionalController.text,
      eventos: [],
    );

    setState(() {
      if (clienteEditandoIndex != null) {
        _clientes[clienteEditandoIndex!] = cliente;
      } else {
        _clientes.add(cliente);
      }
      _limpiarFormulario();
      mostrarFormulario = false;
      clienteEditandoIndex = null;
    });
  }

  void _eliminarCliente(int index) {
    setState(() {
      _clientes.removeAt(index);
    });
  }

  Widget _buildVistaBotonesBonitos() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 10),
      children: [
        _buildBoton(
          const Color(0xFFA8D5BA),
          Icons.person_add,
          'Registrar Nuevo Cliente',
          '',
          () => _abrirFormulario(),
        ),
        _buildBoton(
          const Color(0xFF69B4A1),
          Icons.business_center,
          'Registrar Proveedor',
          '',
          () => setState(() => mostrarFormularioProveedor = true),
        ),
        _buildBoton(
          const Color(0xFFA4D679),
          Icons.people,
          'Ver Lista de Clientes',
          '',
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ListaClientes()),
          ),
        ),
        _buildBoton(
          const Color(0xFF3A7F54),
          Icons.business,
          'Ver Lista de Proveedores',
          '',
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ListaProveedores()),
          ),
        ),
        _buildBoton(
          const Color(0xFF2E5D47),
          Icons.history,
          'Historial de Evento por Cliente',
          '',
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HistorialEventosClientes()),
          ),
        ),
      ],
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
    return Column(
      children: [
        TextField(
            controller: _nombreController,
            decoration: const InputDecoration(labelText: 'Nombre')),
        TextField(
            controller: _contactoController,
            decoration: const InputDecoration(labelText: 'Contacto')),
        TextField(
            controller: _direccionController,
            decoration: const InputDecoration(labelText: 'Dirección')),
        TextField(
            controller: _infoAdicionalController,
            decoration: const InputDecoration(labelText: 'Info adicional')),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () => setState(() {
                mostrarFormulario = false;
                clienteEditandoIndex = null;
                _limpiarFormulario();
              }),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF69B4A1),
                foregroundColor: Colors.white,
              ),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: _guardarCliente,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3A7F54),
                foregroundColor: Colors.white,
              ),
              child:
                  Text(clienteEditandoIndex != null ? 'Actualizar' : 'Guardar'),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildFormularioProveedor() {
    return Column(
      children: [
        TextField(
            controller: _nombreController,
            decoration: const InputDecoration(labelText: 'Nombre del Proveedor')),
        TextField(
            controller: _contactoController,
            decoration: const InputDecoration(labelText: 'Teléfono')),
        TextField(
            controller: _direccionController,
            decoration: const InputDecoration(labelText: 'Dirección')),
        TextField(
            controller: _infoAdicionalController,
            decoration: const InputDecoration(labelText: 'Productos/Servicios')),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () => setState(() {
                mostrarFormularioProveedor = false;
                _limpiarFormulario();
              }),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF69B4A1),
                foregroundColor: Colors.white,
              ),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                // Aquí podrías guardar el proveedor si tuvieras una lista
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Proveedor registrado exitosamente')),
                );
                setState(() {
                  mostrarFormularioProveedor = false;
                  _limpiarFormulario();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3A7F54),
                foregroundColor: Colors.white,
              ),
              child: const Text('Guardar'),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildListaClientes() {
    if (_clientes.isEmpty) {
      return const Center(child: Text('No hay clientes registrados.'));
    }
    return ListView.builder(
      itemCount: _clientes.length,
      itemBuilder: (context, index) {
        final cliente = _clientes[index];
        return ListTile(
          title: Text(cliente.nombre),
          subtitle: Text(cliente.email),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () => _abrirFormulario(index: index),
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () => _eliminarCliente(index),
                  icon: const Icon(Icons.delete)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHistorialClientes() {
    if (clienteSeleccionadoIndex == null) {
      return ListView.builder(
        itemCount: _clientes.length,
        itemBuilder: (context, index) {
          final cliente = _clientes[index];
          return ListTile(
            title: Text(cliente.nombre),
            onTap: () {
              setState(() {
                clienteSeleccionadoIndex = index;
              });
            },
          );
        },
      );
    } else {
      final cliente = _clientes[clienteSeleccionadoIndex!];
      return Column(
        children: [
          Text('Historial de eventos de ${cliente.nombre}'),
          Expanded(
            child: cliente.eventos.isEmpty
                ? const Text('No hay eventos.')
                : ListView(
                    children: cliente.eventos
                        .map((e) => ListTile(title: Text(e.nombre)))
                        .toList(),
                  ),
          ),
          ElevatedButton(
            onPressed: () => setState(() => clienteSeleccionadoIndex = null),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3A7F54),
              foregroundColor: Colors.white,
            ),
            child: const Text('Volver'),
          ),
        ],
      );
    }
  }
}


