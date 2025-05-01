import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class IngresosYGastosScreen extends StatefulWidget {
  const IngresosYGastosScreen({super.key});

  @override
  _IngresosYGastosScreenState createState() => _IngresosYGastosScreenState();
}

class _IngresosYGastosScreenState extends State<IngresosYGastosScreen> {
  // Variables para almacenar los datos de ingresos y gastos
  List<Map<String, dynamic>> movimientos = [];

  // Función para agregar un nuevo movimiento de dinero
  void _agregarMovimiento(Map<String, dynamic> movimiento) {
    setState(() {
      movimientos.add(movimiento);
    });
  }

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
                        ComparativasScreen(movimientos: movimientos),
                  ),
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
                    builder: (context) => FormularioDeRegistrosScreen(
                      agregarMovimiento: _agregarMovimiento,
                    ),
                  ),
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
                        ReporteFinancieroScreen(movimientos: movimientos),
                  ),
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

class FormularioDeRegistrosScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) agregarMovimiento;

  const FormularioDeRegistrosScreen(
      {super.key, required this.agregarMovimiento});

  @override
  _FormularioDeRegistrosScreenState createState() =>
      _FormularioDeRegistrosScreenState();
}

class _FormularioDeRegistrosScreenState
    extends State<FormularioDeRegistrosScreen> {
  final _descripcionController = TextEditingController();
  final _montoController = TextEditingController();
  String _categoria = 'Combustible';

  final List<String> _categorias = [
    'Combustible',
    'Materiales',
    'Servicios',
    'Salarios',
    'Otros'
  ];

  final _formKey = GlobalKey<FormState>();

  void _guardarRegistro() {
    if (_formKey.currentState?.validate() ?? false) {
      final descripcion = _descripcionController.text;
      final monto = double.tryParse(_montoController.text);
      final fecha = DateTime.now();

      if (monto != null) {
        widget.agregarMovimiento({
          'descripcion': descripcion,
          'monto': monto,
          'categoria': _categoria,
          'fecha': fecha,
        });

        _descripcionController.clear();
        _montoController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registro guardado exitosamente!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Monto inválido')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Registros'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  hintText: 'Ejemplo: Compra de combustible',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una descripción';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _montoController,
                decoration: const InputDecoration(
                  labelText: 'Monto (CLP)',
                  hintText: 'Ejemplo: 1000',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un monto';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor ingresa un número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _categoria,
                decoration: const InputDecoration(labelText: 'Categoría'),
                items: _categorias.map((categoria) {
                  return DropdownMenuItem<String>(
                    value: categoria,
                    child: Text(categoria),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _categoria = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor selecciona una categoría';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _guardarRegistro,
                child: const Text('Guardar Registro'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ComparativasScreen extends StatefulWidget {
  final List<Map<String, dynamic>> movimientos;

  const ComparativasScreen({super.key, required this.movimientos});

  @override
  _ComparativasScreenState createState() => _ComparativasScreenState();
}

class _ComparativasScreenState extends State<ComparativasScreen> {
  List<FlSpot> monthlyData = [];
  List<FlSpot> quarterlyData = [];
  List<FlSpot> annualData = [];

  late List<FlSpot> currentData;

  @override
  void initState() {
    super.initState();
    currentData = monthlyData;
    _calcularDatos();
  }

  void _calcularDatos() {
    double ingresosMensuales = 0;
    double gastosMensuales = 0;
    double ingresosTrimestrales = 0;
    double gastosTrimestrales = 0;
    double ingresosAnuales = 0;
    double gastosAnuales = 0;

    for (var movimiento in widget.movimientos) {
      double monto = movimiento['monto'];
      DateTime fecha = movimiento['fecha'];
      if (monto > 0) {
        // Ingreso
        if (fecha.month <= 3) {
          ingresosMensuales += monto;
          ingresosTrimestrales += monto;
          ingresosAnuales += monto;
        }
      } else {
        // Gasto
        if (fecha.month <= 3) {
          gastosMensuales += monto;
          gastosTrimestrales += monto;
          gastosAnuales += monto;
        }
      }
    }

    setState(() {
      monthlyData = [
        FlSpot(0, ingresosMensuales),
        FlSpot(1, gastosMensuales),
      ];
      quarterlyData = [
        FlSpot(0, ingresosTrimestrales),
        FlSpot(1, gastosTrimestrales),
      ];
      annualData = [
        FlSpot(0, ingresosAnuales),
        FlSpot(1, gastosAnuales),
      ];
    });
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
            AspectRatio(
              aspectRatio: 1.5,
              child: LineChart(
                LineChartData(
                  borderData: FlBorderData(show: true),
                  titlesData: FlTitlesData(show: false),
                  gridData: FlGridData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: currentData,
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 4,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

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
            currentData = data;
          });
        },
      ),
    );
  }
}

class ReporteFinancieroScreen extends StatelessWidget {
  final List<Map<String, dynamic>> movimientos;

  const ReporteFinancieroScreen({super.key, required this.movimientos});

  @override
  Widget build(BuildContext context) {
    double ingresos = 0;
    double gastos = 0;
    double saldo = 0;

    for (var movimiento in movimientos) {
      if (movimiento['monto'] > 0) {
        ingresos += movimiento['monto'];
      } else {
        gastos += movimiento['monto'];
      }
    }

    saldo = ingresos + gastos;

    List<BarChartGroupData> barChartData = [
      BarChartGroupData(x: 0, barRods: [
        BarChartRodData(toY: ingresos, color: Colors.green),
      ]),
      BarChartGroupData(x: 1, barRods: [
        BarChartRodData(toY: gastos, color: Colors.red),
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
            const Text(
              'Resumen Financiero:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildFinancialSummary(ingresos, gastos, saldo),
            const SizedBox(height: 20),
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
            const Text(
              'Transacciones recientes:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: movimientos.length,
                itemBuilder: (context, index) {
                  return _buildTransactionTile(
                      movimientos[index]['descripcion'],
                      movimientos[index]['monto'],
                      movimientos[index]['categoria']);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialSummary(double ingresos, double gastos, double saldo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSummaryRow('Ingresos:', ingresos),
        _buildSummaryRow('Gastos:', gastos),
        _buildSummaryRow('Saldo:', saldo),
      ],
    );
  }

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
