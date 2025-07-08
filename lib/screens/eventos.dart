import 'package:flutter/material.dart';
import '../widgets/eventos_formulario.dart';
import '../widgets/listado_eventos.dart';

class EventosScreen extends StatefulWidget {
  const EventosScreen({super.key});

  @override
  State<EventosScreen> createState() => _EventosScreenState();
}

class _EventosScreenState extends State<EventosScreen> {
  @override
  Widget build(BuildContext context) {
    // Eliminar las condiciones que devolvían widgets directamente
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const Center(
                  child: Text(
                    'Eventos',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                _buildStyledButton(
                  icon: Icons.add_circle,
                  label: 'Crear Evento',
                  color: const Color(0xFFA8D5BA),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EventosFormulario()),
                  ),
                ),
                _buildStyledButton(
                  icon: Icons.list,
                  label: 'Lista de Eventos',
                  color: const Color(0xFF3A7F54),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ListadoEventos()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStyledButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: 160,
      height: 60,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(label, textAlign: TextAlign.center),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
        ),
      ),
    );
  }
}


  Widget _buildStyledButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: 160,
      height: 60,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(label, textAlign: TextAlign.center),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
        ),
      ),
    );
  }


class CrearEditarEventoScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onGuardar;

  const CrearEditarEventoScreen({super.key, required this.onGuardar});

  @override
  State<CrearEditarEventoScreen> createState() =>
      _CrearEditarEventoScreenState();
}

class _CrearEditarEventoScreenState extends State<CrearEditarEventoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _ubicacionController = TextEditingController();
  DateTime? _fechaSeleccionada;

  void _guardarEvento() {
    if (_formKey.currentState!.validate() && _fechaSeleccionada != null) {
      widget.onGuardar({
        'nombre': _nombreController.text,
        'descripcion': _descripcionController.text,
        'ubicacion': _ubicacionController.text,
        'fecha': _fechaSeleccionada,
      });
      Navigator.pop(context);
    }
  }

  Future<void> _seleccionarFecha() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _fechaSeleccionada = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear / Editar Evento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration:
                    const InputDecoration(labelText: 'Nombre del evento'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _ubicacionController,
                decoration: const InputDecoration(labelText: 'Ubicación'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: _seleccionarFecha,
                child: Text(
                  _fechaSeleccionada == null
                      ? 'Seleccionar Fecha'
                      : 'Fecha: ${_fechaSeleccionada!.toLocal()}'.split(' ')[0],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _guardarEvento,
                child: const Text('Guardar Evento'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ListaEventosScreen extends StatelessWidget {
  final List<Map<String, dynamic>> eventos;
  const ListaEventosScreen({super.key, required this.eventos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Eventos')),
      body: ListView.builder(
        itemCount: eventos.length,
        itemBuilder: (context, index) {
          final evento = eventos[index];
          return ListTile(
            leading: const Icon(Icons.event),
            title: Text(evento['nombre'] ?? 'Sin nombre'),
            subtitle: Text(
                'Fecha: ${evento['fecha'].toString().split(' ')[0]}\nUbicación: ${evento['ubicacion']}'),
          );
        },
      ),
    );
  }
}

class EstadoEventosScreen extends StatelessWidget {
  final List<Map<String, dynamic>> eventos;
  final Function(int, String) onActualizarEstado;

  const EstadoEventosScreen({
    super.key,
    required this.eventos,
    required this.onActualizarEstado,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estado de los Eventos')),
      body: ListView.builder(
        itemCount: eventos.length,
        itemBuilder: (context, index) {
          final evento = eventos[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    evento['nombre'] ?? 'Sin nombre',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Fecha: ${evento['fecha'].toString().split(' ')[0]}'),
                  Text(
                      'Ubicación: ${evento['ubicacion'] ?? 'No especificada'}'),
                  const SizedBox(height: 12),
                  DropdownButton<String>(
                    value: evento['estado'] ?? 'Pendiente',
                    onChanged: (String? nuevoEstado) {
                      if (nuevoEstado != null) {
                        onActualizarEstado(index, nuevoEstado);
                      }
                    },
                    items: [
                      'Pendiente',
                      'En progreso',
                      'Completado',
                      'Cancelado'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
