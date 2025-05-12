import 'package:flutter/material.dart';

class Trabajador {
  String nombre;
  String email;
  String contacto;
  String direccion;
  String infoAdicional;
  String tareaAsignada;

  Trabajador({
    required this.nombre,
    required this.email,
    required this.contacto,
    required this.direccion,
    required this.infoAdicional,
    this.tareaAsignada = 'Libre',
  });
}

class Screen4 extends StatefulWidget {
  const Screen4({super.key});

  @override
  State<Screen4> createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  bool mostrarLista = false;
  bool mostrarAsignacion = false;
  bool mostrarFormulario = false;

  final List<Trabajador> _personal = [];

  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactoController = TextEditingController();
  final _direccionController = TextEditingController();
  final _infoAdicionalController = TextEditingController();

  int? trabajadorEditandoIndex;
  String? _trabajadorSeleccionado;
  String? _tareaSeleccionada;
  String? _eventoSeleccionado;
  final List<String> _eventos = ['Evento A', 'Evento B', 'Evento C'];

  void _limpiarFormulario() {
    _nombreController.clear();
    _emailController.clear();
    _contactoController.clear();
    _direccionController.clear();
    _infoAdicionalController.clear();
  }

  void _guardarTrabajador() {
    final nuevo = Trabajador(
      nombre: _nombreController.text,
      email: _emailController.text,
      contacto: _contactoController.text,
      direccion: _direccionController.text,
      infoAdicional: _infoAdicionalController.text,
    );

    setState(() {
      if (trabajadorEditandoIndex != null) {
        _personal[trabajadorEditandoIndex!] = nuevo;
      } else {
        _personal.add(nuevo);
      }
      trabajadorEditandoIndex = null;
      mostrarFormulario = false;
      _limpiarFormulario();
    });
  }

  @override
  Widget build(BuildContext context) {
    String titulo;
    if (mostrarFormulario) {
      titulo = 'Formulario de Personal';
    } else if (mostrarLista) {
      titulo = 'Lista de Personal';
    } else if (mostrarAsignacion) {
      titulo = 'Asignación de Tareas';
    } else {
      titulo = 'Personal';
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (mostrarLista || mostrarAsignacion || mostrarFormulario)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          mostrarLista = false;
                          mostrarAsignacion = false;
                          mostrarFormulario = false;
                          trabajadorEditandoIndex = null;
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
                      ? _buildListaPersonal()
                      : mostrarAsignacion
                          ? _buildAsignacionTareas()
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
          Colors.purple.shade600,
          Icons.person_add,
          'Registrar Nuevo Personal',
          '',
          () => setState(() => mostrarFormulario = true),
        ),
        _buildBoton(
          Colors.purple.shade800,
          Icons.list,
          'Lista de Personal',
          '',
          () => setState(() => mostrarLista = true),
        ),
        _buildBoton(
          Colors.purple.shade900,
          Icons.assignment_ind,
          'Asignar Tareas',
          '',
          () => setState(() => mostrarAsignacion = true),
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
    return ListView(
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
                trabajadorEditandoIndex = null;
                _limpiarFormulario();
              }),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: _guardarTrabajador,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
              child: Text(
                  trabajadorEditandoIndex != null ? 'Actualizar' : 'Guardar'),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildListaPersonal() {
    if (_personal.isEmpty) {
      return const Center(child: Text('No hay trabajadores registrados.'));
    }

    return ListView.builder(
      itemCount: _personal.length,
      itemBuilder: (context, index) {
        final t = _personal[index];
        return ListTile(
          leading: const Icon(Icons.person),
          title: Text(t.nombre),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email: ${t.email}'),
              Text('Teléfono: ${t.contacto}'),
              Text('Dirección: ${t.direccion}'),
              Text('Info adicional: ${t.infoAdicional}'),
              Text('Tarea asignada: ${t.tareaAsignada}'),
            ],
          ),
          isThreeLine: true,
          trailing: Wrap(
            spacing: 8,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  setState(() {
                    trabajadorEditandoIndex = index;
                    _nombreController.text = t.nombre;
                    _emailController.text = t.email;
                    _contactoController.text = t.contacto;
                    _direccionController.text = t.direccion;
                    _infoAdicionalController.text = t.infoAdicional;
                    mostrarFormulario = true;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    _personal.removeAt(index);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAsignacionTareas() {
    final trabajadores = _personal.map((t) => t.nombre).toList();
    final tareas = ['Limpiar', 'Ordenar', 'Otro', 'Libre'];

    return ListView(
      children: [
        const Text('Seleccione un trabajador:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _trabajadorSeleccionado,
          items: trabajadores
              .map((nombre) =>
                  DropdownMenuItem(value: nombre, child: Text(nombre)))
              .toList(),
          onChanged: (value) {
            setState(() {
              _trabajadorSeleccionado = value;
            });
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Seleccione trabajador',
          ),
        ),
        const SizedBox(height: 16),
        const Text('Seleccione un evento:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _eventoSeleccionado,
          items: _eventos
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (value) {
            setState(() {
              _eventoSeleccionado = value;
            });
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Seleccione evento',
          ),
        ),
        const SizedBox(height: 16),
        const Text('Seleccione una tarea:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _tareaSeleccionada,
          items: tareas
              .map((t) => DropdownMenuItem(value: t, child: Text(t)))
              .toList(),
          onChanged: (value) {
            setState(() {
              _tareaSeleccionada = value;
            });
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Seleccione tarea',
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: ElevatedButton(
            onPressed: () {
              if (_trabajadorSeleccionado != null &&
                  _tareaSeleccionada != null &&
                  _eventoSeleccionado != null) {
                final index = _personal
                    .indexWhere((t) => t.nombre == _trabajadorSeleccionado);
                if (index != -1) {
                  setState(() {
                    _personal[index].tareaAsignada =
                        '$_tareaSeleccionada (Evento: $_eventoSeleccionado)';
                    _trabajadorSeleccionado = null;
                    _tareaSeleccionada = null;
                    _eventoSeleccionado = null;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Tarea asignada exitosamente')),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
            ),
            child: const Text('Asignar'),
          ),
        )
      ],
    );
  }
}
