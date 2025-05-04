import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class IngresosYGastosScreen extends StatefulWidget {
  const IngresosYGastosScreen({super.key});

  @override
  _IngresosYGastosScreenState createState() => _IngresosYGastosScreenState();
}

class _IngresosYGastosScreenState extends State<IngresosYGastosScreen> {
  List<Map<String, dynamic>> movimientos = [];

  void _agregarMovimiento(Map<String, dynamic> movimiento) {
    setState(() {
      movimientos.add(movimiento);
    });
  }

  void _eliminarMovimiento(Map<String, dynamic> movimiento) {
    setState(() {
      movimientos.remove(movimiento);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.only(top: 10, left: 80),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Ingresos y Gastos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: VistaBotonesBonitos(
              onComparativas: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ComparativasScreen(movimientos: movimientos),
                ),
              ),
              onFormulario: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FormularioDeRegistrosScreen(
                    agregarMovimiento: _agregarMovimiento,
                    eliminarMovimiento: _eliminarMovimiento,
                    movimientos: movimientos,
                  ),
                ),
              ),
              onReporte: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ReporteFinancieroScreen(movimientos: movimientos),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VistaBotonesBonitos extends StatelessWidget {
  final VoidCallback onComparativas;
  final VoidCallback onFormulario;
  final VoidCallback onReporte;

  const VistaBotonesBonitos({
    super.key,
    required this.onComparativas,
    required this.onFormulario,
    required this.onReporte,
  });

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

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 40),
      children: [
        _buildBoton(Colors.teal.shade600, Icons.bar_chart, 'Comparativas',
            'Lineas', onComparativas),
        _buildBoton(Colors.teal.shade800, Icons.receipt_long,
            'Formulario de Registro', '', onFormulario),
        _buildBoton(Colors.teal.shade900, Icons.insert_chart,
            'Reporte Financiero', '', onReporte),
      ],
    );
  }
}

// Las demás clases como ComparativasScreen, FormularioDeRegistrosScreen, ReporteFinancieroScreen deben estar ya definidas como parte de tu app.

// Nota: Asegúrate de no tener otra llamada a FormularioDeRegistrosScreen() en otro archivo
// sin los parámetros requeridos. Este error ocurre si en otro lado del código haces algo como:
// Navigator.push(context, MaterialPageRoute(builder: (_) => FormularioDeRegistrosScreen()));
// Esa llamada también debe incluir los tres parámetros requeridos.

class FormularioDeRegistrosScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) agregarMovimiento;
  final Function(Map<String, dynamic>) eliminarMovimiento;
  final List<Map<String, dynamic>> movimientos;

  const FormularioDeRegistrosScreen({
    super.key,
    required this.agregarMovimiento,
    required this.eliminarMovimiento,
    required this.movimientos,
  });

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
    final transacciones = widget.movimientos
        .where((mov) => mov['monto'] != null)
        .toList()
      ..sort((a, b) => b['fecha'].compareTo(a['fecha']));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Registros'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _descripcionController,
                          decoration: InputDecoration(
                            labelText: 'Descripción',
                            hintText: 'Ejemplo: Compra de combustible',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
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
                          decoration: InputDecoration(
                            labelText: 'Monto (CLP)',
                            hintText: 'Ejemplo: 1000 (ingreso) o -500 (gasto)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
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
                          decoration: InputDecoration(
                            labelText: 'Categoría',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
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
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: _guardarRegistro,
                            child: const Text(
                              'Guardar Registro',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Movimientos recientes:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transacciones.length,
                itemBuilder: (context, index) {
                  final mov = transacciones[index];
                  final DateTime fecha = mov['fecha'];
                  final String tipo = mov['monto'] >= 0 ? 'Ingreso' : 'Gasto';

                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(mov['descripcion']),
                      subtitle: Text(
                        '$tipo - ${mov['categoria']} - ${fecha.day}/${fecha.month}/${fecha.year}',
                      ),
                      trailing: Text(
                        '\$${mov['monto'].toStringAsFixed(2)}',
                        style: TextStyle(
                          color: mov['monto'] >= 0 ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('¿Eliminar movimiento?'),
                            content: const Text(
                                '¿Estás seguro de eliminar este movimiento?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, false),
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, true),
                                child: const Text('Eliminar'),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true) {
                          widget.eliminarMovimiento(mov);
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Movimiento eliminado')),
                          );
                        }
                      },
                    ),
                  );
                },
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
        if (fecha.month <= 3) {
          ingresosMensuales += monto;
          ingresosTrimestrales += monto;
          ingresosAnuales += monto;
        }
      } else {
        if (fecha.month <= 3) {
          gastosMensuales += monto;
          gastosTrimestrales += monto;
          gastosAnuales += monto;
        }
      }
    }

    setState(() {
      monthlyData = [FlSpot(0, ingresosMensuales), FlSpot(1, gastosMensuales)];
      quarterlyData = [
        FlSpot(0, ingresosTrimestrales),
        FlSpot(1, gastosTrimestrales)
      ];
      annualData = [FlSpot(0, ingresosAnuales), FlSpot(1, gastosAnuales)];
    });
  }

  @override
  Widget build(BuildContext context) {
    final cardStyle = BoxDecoration(
      color: const Color(0xFF356E73),
      borderRadius: BorderRadius.circular(24),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comparativas'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildStyledCard(
              title: 'Mensual',
              description: 'Mejor rendimiento',
              icon: Icons.calendar_today,
              data: monthlyData,
              color: const Color(0xFF4FA6B8),
            ),
            const SizedBox(height: 16),
            _buildStyledCard(
              title: 'Trimestral',
              description: 'Mejor en eficiencia',
              icon: Icons.pie_chart,
              data: quarterlyData,
              color: const Color(0xFF336D7B),
            ),
            const SizedBox(height: 16),
            _buildStyledCard(
              title: 'Anual',
              description: 'Mejor en precisión',
              icon: Icons.bar_chart,
              data: annualData,
              color: const Color(0xFF275664),
            ),
            const SizedBox(height: 24),
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
                      color: Colors.blueAccent,
                      barWidth: 4,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStyledCard({
    required String title,
    required String description,
    required IconData icon,
    required List<FlSpot> data,
    required Color color,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          currentData = data;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Icon(icon, size: 36, color: Colors.white),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                Text(description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    )),
              ],
            ),
          ],
        ),
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
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text('Reporte Financiero'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumen Financiero:',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4))
                ],
              ),
              child: _buildFinancialSummary(ingresos, gastos, saldo),
            ),
            const SizedBox(height: 24),
            const Text(
              'Distribución de Ingresos y Gastos:',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 12),
            AspectRatio(
              aspectRatio: 1.5,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BarChart(
                    BarChartData(
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(show: false),
                      gridData: FlGridData(show: true),
                      barGroups: barChartData,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Transacciones recientes:',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: movimientos.length,
                itemBuilder: (context, index) {
                  return _buildTransactionTile(
                    movimientos[index]['descripcion'],
                    movimientos[index]['monto'],
                    movimientos[index]['categoria'],
                  );
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
        _buildSummaryRow('Ingresos:', ingresos, Colors.green),
        _buildSummaryRow('Gastos:', gastos, Colors.red),
        _buildSummaryRow('Saldo:', saldo, Colors.deepPurple),
      ],
    );
  }

  Widget _buildSummaryRow(String label, double amount, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: color),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionTile(String description, double amount, String type) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(
          amount >= 0 ? Icons.arrow_downward : Icons.arrow_upward,
          color: amount >= 0 ? Colors.green : Colors.red,
        ),
        title: Text(description,
            style: const TextStyle(fontWeight: FontWeight.w600)),
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
