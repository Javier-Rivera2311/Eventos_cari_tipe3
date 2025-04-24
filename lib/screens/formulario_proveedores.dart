import 'package:flutter/material.dart';
import 'package:my_app/servicios/json_bd_temp.dart';



class FormularioProveedores extends StatefulWidget {
  final Map<String, dynamic>? existingProvider; // si es null, estamos creando

  const FormularioProveedores({super.key, this.existingProvider});

  @override
  State<FormularioProveedores> createState() => _FormularioProveedoresState();
}

class _FormularioProveedoresState extends State<FormularioProveedores> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _primeController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
        text: widget.existingProvider != null ? widget.existingProvider!['Nombre Proveedor'] : '');
    _emailController = TextEditingController(
        text: widget.existingProvider != null ? widget.existingProvider!['Correo'] : '');
    _phoneController = TextEditingController(
        text: widget.existingProvider != null ? widget.existingProvider!['Celular/Telefono'] : '');
    _primeController = TextEditingController(
        text: widget.existingProvider != null ? widget.existingProvider!['Que provee'] : '');
    
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _primeController.dispose();
    super.dispose();
  }

void _saveProvider() async {
  try {
    if (_formKey.currentState!.validate()) {
      final providerData = {
        'Nombre Proveedor': _nameController.text.trim(),
        'Correo': _emailController.text.trim(),
        'Celular/Telefono': _phoneController.text.trim(),
        'Que provee': _primeController.text.trim(),
      };

      List<Map<String, dynamic>> existingProviders = await readProviders();

      if (widget.existingProvider == null) {
        existingProviders.add(providerData);
      } else {
        final index = existingProviders.indexWhere(
          (p) => p['Nombre Proveedor'] == widget.existingProvider!['Nombre Proveedor']
        );
        if (index != -1) {
          existingProviders[index] = providerData;
        }
      }

      await writeProviders(existingProviders);
      Navigator.pop(context, providerData); // 👈 puede mantenerse sin await aquí
    }
  } catch (e) {
    print("Error al guardar proveedor: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existingProvider != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Editar Proveedor" : "Crear Proveedor")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) => value!.isEmpty ? 'Ingrese el nombre' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Correo electrónico'),
                validator: (value) => value!.isEmpty ? 'Ingrese un correo válido' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Celular/Teléfono'),
                validator: (value) => value!.isEmpty ? 'Ingrese el Celular o teléfono' : null,
              ),
              TextFormField(
                controller: _primeController,
                decoration: const InputDecoration(labelText: 'Que provee'),
                validator: (value) => value!.isEmpty ? 'Ingrese una provision' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProvider,
                child: Text(isEdit ? 'Guardar cambios' : 'Crear proveedor'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}