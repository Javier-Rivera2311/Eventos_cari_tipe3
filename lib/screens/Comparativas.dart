import 'package:flutter/material.dart';

class ComparativasScreen extends StatelessWidget {
  const ComparativasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comparativas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Comparativas de Algoritmos:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Lista de comparaciones entre algoritmos
            Expanded(
              child: ListView(
                children: [
                  _buildComparisonTile(
                      'Algoritmo 1', 'Mejor rendimiento', 'PSO'),
                  _buildComparisonTile(
                      'Algoritmo 2', 'Mejor en eficiencia', 'GA'),
                  _buildComparisonTile(
                      'Algoritmo 3', 'Mejor en precisión', 'APO'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para ver detalles más específicos de las comparativas
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Detalles de Comparativa'),
                      content: const Text(
                          'Aquí irían los detalles de la comparación entre los algoritmos.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cerrar'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Ver más detalles'),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir los elementos de la lista de comparativas
  Widget _buildComparisonTile(
      String title, String description, String algorithm) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text('$description ($algorithm)'),
        leading: const Icon(Icons.compare_arrows),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          // Puedes agregar navegación a una nueva pantalla si deseas ver más detalles sobre una comparación específica
          print('Ver detalles de $title');
        },
      ),
    );
  }
}
