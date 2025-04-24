import 'package:flutter/material.dart';

class FormularioCompra extends StatefulWidget {
  const FormularioCompra({super.key});

  @override
  State<FormularioCompra> createState() => _FormularioCompraState();
}

class _FormularioCompraState extends State<FormularioCompra> {
  final _formKey = GlobalKey<FormState>();
  final _fechaController = TextEditingController();
  final _montoController = TextEditingController();
  final _detalleController = TextEditingController();

  @override
  void dispose() {
    _fechaController.dispose();
    _montoController.dispose();
    _detalleController.dispose();
    super.dispose();
  }

  void _guardar() {
    if (_formKey.currentState!.validate()) {
      final nuevaCompra = {
        'fecha': _fechaController.text.trim(),
        'monto': int.tryParse(_montoController.text.trim()) ?? 0,
        'detalle': _detalleController.text.trim(),
      };
      Navigator.pop(context, nuevaCompra);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Compra')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _fechaController,
                decoration: const InputDecoration(labelText: 'Fecha (YYYY-MM-DD)'),
                validator: (v) => v!.isEmpty ? 'Ingrese la fecha' : null,
              ),
              TextFormField(
                controller: _montoController,
                decoration: const InputDecoration(labelText: 'Monto'),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Ingrese un monto válido' : null,
              ),
              TextFormField(
                controller: _detalleController,
                decoration: const InputDecoration(labelText: 'Detalle'),
                validator: (v) => v!.isEmpty ? 'Ingrese un detalle' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _guardar, child: const Text('Guardar')),
            ],
          ),
        ),
      ),
    );
  }
}
