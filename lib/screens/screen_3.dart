import 'package:flutter/material.dart';

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
  int? clienteEditandoIndex;
  int? clienteSeleccionadoIndex;

  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactoController = TextEditingController();
  final _direccionController = TextEditingController();
  final _infoAdicionalController = TextEditingController();

  final List<Cliente> _clientes = [];

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

  @override
  Widget build(BuildContext context) {
    String titulo;
    if (mostrarFormulario) {
      titulo = clienteEditandoIndex != null
          ? 'Editar Cliente'
          : 'Formulario de Cliente';
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
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (mostrarFormulario || mostrarLista || mostrarHistorial)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          mostrarFormulario = false;
                          mostrarLista = false;
                          mostrarHistorial = false;
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

  Widget _buildVistaBotonesBonitos() {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 10),
      children: [
        _buildBoton(
          Colors.blue.shade600,
          Icons.person_add,
          'Registrar Nuevo Cliente',
          '',
          () => _abrirFormulario(),
        ),
        _buildBoton(
          Colors.blue.shade800,
          Icons.list,
          'Lista de Clientes',
          '',
          () => setState(() => mostrarLista = true),
        ),
        _buildBoton(
          Colors.blue.shade900,
          Icons.history,
          'Historial de Evento por Cliente',
          '',
          () => setState(() => mostrarHistorial = true),
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
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email')),
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
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: _guardarCliente,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
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
                        .map((e) => ListTile(title: Text(e)))
                        .toList(),

                  ),
          ),
          ElevatedButton(

            onPressed: () => setState(() => clienteSeleccionadoIndex = null),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: const Text('Volver'),

          ),
        ],
      );
    }
  }
}
