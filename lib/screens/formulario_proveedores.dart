import 'package:flutter/material.dart';
import 'lista_proveedores.dart';

class FormularioProveedores extends StatefulWidget {
  const FormularioProveedores({Key? key}) : super(key: key);

  @override
  State<FormularioProveedores> createState() => _FormularioProveedoresState();
}

class _FormularioProveedoresState extends State<FormularioProveedores> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController rutController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController rubroController = TextEditingController();

  String? _validateRut(String? value) {
    final rutRegex = RegExp(r'^\d{7,8}-[0-9kK]$');
    if (value == null || value.isEmpty) return 'Campo obligatorio';
    if (!rutRegex.hasMatch(value)) return 'Formato de RUT inválido';
    return null;
  }

  String? _validateCorreo(String? value) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (value == null || value.isEmpty) return 'Campo obligatorio';
    if (!emailRegex.hasMatch(value)) return 'Correo inválido';
    return null;
  }

  String? _validateNoEmpty(String? value) {
    return (value == null || value.isEmpty) ? 'Campo obligatorio' : null;
  }

  void _guardarFormulario() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Formulario enviado con éxito')),
      );
    }
  }

  void _irALista() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ListaProveedores()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulario de Proveedores')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    TextFormField(
                      controller: nombreController,
                      decoration:
                          const InputDecoration(labelText: 'Nombre completo'),
                      validator: _validateNoEmpty,
                    ),
                    TextFormField(
                      controller: rutController,
                      decoration: const InputDecoration(labelText: 'RUT'),
                      validator: _validateRut,
                    ),
                    TextFormField(
                      controller: correoController,
                      decoration: const InputDecoration(
                          labelText: 'Correo electrónico'),
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateCorreo,
                    ),
                    TextFormField(
                      controller: telefonoController,
                      decoration: const InputDecoration(labelText: 'Teléfono'),
                      keyboardType: TextInputType.phone,
                      validator: _validateNoEmpty,
                    ),
                    TextFormField(
                      controller: rubroController,
                      decoration: const InputDecoration(
                          labelText: 'Rubro o especialidad'),
                      validator: _validateNoEmpty,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _guardarFormulario,
                      child: const Text('Guardar proveedor'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _irALista,
                      child: const Text('Ver lista'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
