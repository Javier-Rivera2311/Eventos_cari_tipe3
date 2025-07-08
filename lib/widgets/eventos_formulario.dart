import 'package:flutter/material.dart';

class EventosFormulario extends StatefulWidget {
  const EventosFormulario({super.key});

  @override
  State<EventosFormulario> createState() => _EventosFormularioState();
}

class _EventosFormularioState extends State<EventosFormulario> {
  final _formKey = GlobalKey<FormState>();
  
  final _eventNameController = TextEditingController();
  final _eventTimeController = TextEditingController();
  final _totalAmountController = TextEditingController();
  final _observationsController = TextEditingController();
  final _eventLocationController = TextEditingController();
  final _districtController = TextEditingController();
  final _depositController = TextEditingController();
  final _outstandingBalanceController = TextEditingController();

  String? _selectedEventType;
  String? _selectedStatus;
  String? _selectedClientId;

  final List<String> _eventTypes = [
    'Boda',
    'Cumpleaños',
    'Aniversario',
    'Graduación',
    'Bautizo',
    'Quinceañero',
    'Corporativo',
    'Otro'
  ];

  final List<String> _statusOptions = [
    'Pendiente',
    'Confirmado',
    'En Proceso',
    'Completado',
    'Cancelado'
  ];

  final List<Map<String, String>> _clientes = [
    {'id': '1', 'name': 'Carmen Rodríguez'},
    {'id': '2', 'name': 'Miguel Hernández'},
    {'id': '3', 'name': 'Lucía Morales'},
    {'id': '4', 'name': 'Roberto Silva'},
    {'id': '5', 'name': 'Isabella Torres'},
  ];

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventTimeController.dispose();
    _totalAmountController.dispose();
    _observationsController.dispose();
    _eventLocationController.dispose();
    _districtController.dispose();
    _depositController.dispose();
    _outstandingBalanceController.dispose();
    super.dispose();
  }

  void _limpiarFormulario() {
    _eventNameController.clear();
    _eventTimeController.clear();
    _totalAmountController.clear();
    _observationsController.clear();
    _eventLocationController.clear();
    _districtController.clear();
    _depositController.clear();
    _outstandingBalanceController.clear();
    
    setState(() {
      _selectedEventType = null;
      _selectedStatus = null;
      _selectedClientId = null;
    });
  }

  void _guardarEvento() {
    if (_formKey.currentState!.validate()) {
      // Aquí guardarías el evento
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Evento guardado exitosamente')),
      );
      _limpiarFormulario();
    }
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
                  'Formulario de Evento',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Nombre del Evento
                TextFormField(
                  controller: _eventNameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre del Evento',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.event),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre del evento';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Cliente
                DropdownButtonFormField<String>(
                  value: _selectedClientId,
                  decoration: const InputDecoration(
                    labelText: 'Cliente',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  items: _clientes.map((cliente) {
                    return DropdownMenuItem<String>(
                      value: cliente['id'],
                      child: Text(cliente['name']!),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedClientId = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor seleccione un cliente';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Fecha y Hora del Evento
                TextFormField(
                  controller: _eventTimeController,
                  decoration: const InputDecoration(
                    labelText: 'Fecha y Hora (DD/MM/YYYY - HH:MM)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.access_time),
                    hintText: '15/12/2024 - 18:00',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la fecha y hora';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Ubicación del Evento
                TextFormField(
                  controller: _eventLocationController,
                  decoration: const InputDecoration(
                    labelText: 'Ubicación del Evento',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la ubicación';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Distrito
                TextFormField(
                  controller: _districtController,
                  decoration: const InputDecoration(
                    labelText: 'Distrito/Ciudad',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_city),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el distrito';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Tipo de Evento
                DropdownButtonFormField<String>(
                  value: _selectedEventType,
                  decoration: const InputDecoration(
                    labelText: 'Tipo de Evento',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.category),
                  ),
                  items: _eventTypes.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedEventType = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor seleccione el tipo de evento';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Estado
                DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  decoration: const InputDecoration(
                    labelText: 'Estado',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.info),
                  ),
                  items: _statusOptions.map((status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor seleccione el estado';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Monto Total
                TextFormField(
                  controller: _totalAmountController,
                  decoration: const InputDecoration(
                    labelText: 'Monto Total (\$)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                    hintText: '1.500.000',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el monto total';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Depósito
                TextFormField(
                  controller: _depositController,
                  decoration: const InputDecoration(
                    labelText: 'Depósito (\$)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.payment),
                    hintText: '750.000',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),

                // Saldo Pendiente
                TextFormField(
                  controller: _outstandingBalanceController,
                  decoration: const InputDecoration(
                    labelText: 'Saldo Pendiente (\$)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.money_off),
                    hintText: '750.000',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),

                // Observaciones
                TextFormField(
                  controller: _observationsController,
                  decoration: const InputDecoration(
                    labelText: 'Observaciones',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.note),
                    hintText: 'Detalles adicionales del evento...',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),

                // Botones
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _limpiarFormulario,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF69B4A1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text('Limpiar'),
                    ),
                    ElevatedButton(
                      onPressed: _guardarEvento,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3A7F54),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text('Guardar Evento'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
