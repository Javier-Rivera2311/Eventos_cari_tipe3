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
      appBar: AppBar(
        title: Text(titulo),
        leading: (mostrarFormulario || mostrarLista || mostrarHistorial)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
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
              )
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: mostrarFormulario
            ? _buildFormulario()
            : mostrarLista
                ? _buildListaClientes()
                : mostrarHistorial
                    ? _buildHistorialClientes()
                    : _buildMenuPrincipal(),
      ),
    );
  }

  Widget _buildFormulario() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            clienteEditandoIndex != null
                ? 'Edita los datos del cliente:'
                : 'Por favor ingrese los siguientes datos del nuevo cliente:',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text('Nombre completo:'),
          TextFormField(
            controller: _nombreController,
            decoration: const InputDecoration(
              labelText: 'Nombre',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Email:'),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          const Text('Contacto:'),
          TextFormField(
            controller: _contactoController,
            decoration: const InputDecoration(
              labelText: 'Número telefónico',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),
          const Text('Dirección:'),
          TextFormField(
            controller: _direccionController,
            decoration: const InputDecoration(
              labelText: 'Dirección',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Información adicional:'),
          TextFormField(
            controller: _infoAdicionalController,
            decoration: const InputDecoration(
              labelText: '...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    mostrarFormulario = false;
                    clienteEditandoIndex = null;
                    _limpiarFormulario();
                  });
                },
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: _guardarCliente,
                child: Text(
                    clienteEditandoIndex != null ? 'Actualizar' : 'Guardar'),
              ),
            ],
          ),
        ],
      ),
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
        return Card(
          child: ListTile(
            title: Text(cliente.nombre),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email: ${cliente.email}'),
                Text('Teléfono: ${cliente.contacto}'),
                Text('Dirección: ${cliente.direccion}'),
                Text('Info adicional: ${cliente.infoAdicional}'),
              ],
            ),
            trailing: Wrap(
              spacing: 8,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _abrirFormulario(index: index),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _eliminarCliente(index),
                ),
              ],
            ),
            isThreeLine: true,
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
            subtitle: Text('Ver historial de eventos'),
            trailing: const Icon(Icons.arrow_forward_ios),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Historial de ${cliente.nombre}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: cliente.eventos.isEmpty
                ? const Center(child: Text('No hay eventos registrados.'))
                : ListView.builder(
                    itemCount: cliente.eventos.length,
                    itemBuilder: (context, i) {
                      final evento = cliente.eventos[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      evento.nombre,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    value: evento.estado,
                                    onChanged: (String? nuevoEstado) {
                                      if (nuevoEstado != null) {
                                        setState(() {
                                          evento.estado = nuevoEstado;
                                        });
                                      }
                                    },
                                    items: [
                                      'Pendiente',
                                      'En progreso',
                                      'Completado',
                                      'Cancelado'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              setState(() {
                clienteSeleccionadoIndex = null;
              });
            },
            child: const Text('Volver a selección'),
          ),
        ],
      );
    }
  }

  Widget _buildMenuPrincipal() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => _abrirFormulario(),
          child: const Text('Registrar Nuevo Cliente'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              mostrarLista = true;
            });
          },
          child: const Text('Lista de Clientes'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              mostrarHistorial = true;
            });
          },
          child: const Text('Historial de Evento por Cliente'),
        ),
      ],
    );
  }
}
