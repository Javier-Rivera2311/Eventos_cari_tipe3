import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class IngresosYGastosScreen extends StatelessWidget {
  const IngresosYGastosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingresos y Gastos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navegar a la vista de Comparativas
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ComparativasScreen()), // Elimina 'const'
                );
              },
              child: const Text('Comparativas'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navegar a la vista de Formulario de Registros
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FormularioDeRegistrosScreen()), // Elimina 'const'
                );
              },
              child: const Text('Formulario de Registros'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navegar a la vista de Reporte Financiero
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ReporteFinancieroScreen()), // Elimina 'const'
                );
              },
              child: const Text('Reporte Financiero'),
            ),
          ],
        ),
      ),
    );
  }
}

// Vistas para cada uno de los botones
class ComparativasScreen extends StatefulWidget {
  const ComparativasScreen({super.key});

  @override
  _ComparativasScreenState createState() => _ComparativasScreenState();
}

class _ComparativasScreenState extends State<ComparativasScreen> {
  // Variables para los datos del gráfico
  List<FlSpot> monthlyData = [
    FlSpot(0, 10),
    FlSpot(1, 12),
    FlSpot(2, 15),
  ];
  List<FlSpot> quarterlyData = [
    FlSpot(0, 8),
    FlSpot(1, 9),
    FlSpot(2, 14),
  ];
  List<FlSpot> annualData = [
    FlSpot(0, 20),
    FlSpot(1, 25),
    FlSpot(2, 30),
  ];

  // Variable para controlar los datos del gráfico
  late List<FlSpot> currentData;

  @override
  void initState() {
    super.initState();
    // Inicializamos el gráfico con los datos mensuales
    currentData = monthlyData;
  }

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
              'Comparativas de Datos:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Lista de comparaciones entre algoritmos
            Expanded(
              child: ListView(
                children: [
                  _buildComparisonTile(
                      'Mensual', 'Mejor rendimiento', 'PSO', monthlyData),
                  _buildComparisonTile(
                      'Trimestral', 'Mejor en eficiencia', 'GA', quarterlyData),
                  _buildComparisonTile(
                      'Anual', 'Mejor en precisión', 'APO', annualData),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Aquí mostramos el gráfico de líneas horizontal
            AspectRatio(
              aspectRatio: 1.5,
              child: LineChart(
                LineChartData(
                  borderData: FlBorderData(show: true),
                  titlesData: FlTitlesData(show: false),
                  gridData: FlGridData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: currentData, // Datos del gráfico
                      isCurved: true,
                      color: Colors.blue, // Color de la línea
                      barWidth: 4,
                      belowBarData: BarAreaData(
                          show:
                              false), // Opcional, para quitar área debajo de la línea
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para ver más detalles de las comparativas
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
      String title, String description, String algorithm, List<FlSpot> data) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text('$description ($algorithm)'),
        leading: const Icon(Icons.compare_arrows),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          setState(() {
            currentData =
                data; // Actualizar los datos del gráfico según la opción seleccionada
          });
        },
      ),
    );
  }
}

class FormularioDeRegistrosScreen extends StatelessWidget {
  const FormularioDeRegistrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de Registros'),
      ),
      body: const Center(
        child: Text('Formulario de Registros', style: TextStyle(fontSize: 25)),
      ),
    );
  }
}

class ReporteFinancieroScreen extends StatelessWidget {
  const ReporteFinancieroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo para el gráfico de barras (Ingresos vs Gastos)
    List<BarChartGroupData> barChartData = [
      BarChartGroupData(x: 0, barRods: [
        BarChartRodData(toY: 5000, color: Colors.green), // Ingresos
      ]),
      BarChartGroupData(x: 1, barRods: [
        BarChartRodData(toY: 2000, color: Colors.red), // Gastos
      ]),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reporte Financiero'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Resumen de ingresos, gastos y saldo
            const Text(
              'Resumen Financiero:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildFinancialSummary(),
            const SizedBox(height: 20),

            // Gráfico de barras de ingresos y gastos
            const Text(
              'Distribución de Ingresos y Gastos:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            AspectRatio(
              aspectRatio: 1.5,
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: true),
                  titlesData: FlTitlesData(show: false),
                  gridData: FlGridData(show: true),
                  barGroups: barChartData,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Lista de transacciones
            const Text(
              'Transacciones recientes:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildTransactionTile('Venta de Producto', 1000, 'Ingreso'),
                  _buildTransactionTile('Compra de insumos', -500, 'Gasto'),
                  _buildTransactionTile('Pago de alquiler', -800, 'Gasto'),
                  _buildTransactionTile(
                      'Servicio de publicidad', -200, 'Gasto'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para el resumen financiero
  Widget _buildFinancialSummary() {
    double ingresos = 10000; // Ejemplo de ingresos
    double gastos = 5000; // Ejemplo de gastos
    double saldo = ingresos - gastos;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSummaryRow('Ingresos:', ingresos),
        _buildSummaryRow('Gastos:', gastos),
        _buildSummaryRow('Saldo:', saldo),
      ],
    );
  }

  // Widget para construir cada fila del resumen financiero
  Widget _buildSummaryRow(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Widget para construir cada transacción de la lista
  Widget _buildTransactionTile(String description, double amount, String type) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(description),
        subtitle: Text(type),
        trailing: Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
            color: amount < 0 ? Colors.red : Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
