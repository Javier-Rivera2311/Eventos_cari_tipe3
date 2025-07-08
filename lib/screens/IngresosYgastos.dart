import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class IngresosYGastosScreen extends StatefulWidget {
  const IngresosYGastosScreen({super.key});

  @override
  _IngresosYGastosScreenState createState() => _IngresosYGastosScreenState();
}

class _IngresosYGastosScreenState extends State<IngresosYGastosScreen> {
  List<Map<String, dynamic>> financialRecords = [];
  List<Map<String, dynamic>> bills = [];
  List<Map<String, dynamic>> income = [];

  @override
  void initState() {
    super.initState();
    _initializeDataWithExamples();
  }

  void _initializeDataWithExamples() {
    // Datos de ejemplo basados en los eventos
    financialRecords = [
      {
        'id': 'FR001',
        'amount': 500000.0,
        'observations': 'Pago inicial sistema de sonido',
        'payment_method': 'Transferencia',
        'date': DateTime(2023, 12, 1),
      },
      {
        'id': 'FR002', 
        'amount': -300000.0,
        'observations': 'Compra de materiales decorativos',
        'payment_method': 'Tarjeta de Crédito',
        'date': DateTime(2024, 1, 15),
      },
    ];

    bills = [
      {
        'id': 'B001',
        'amount': -150000.0,
        'observations': 'Factura mensual electricidad',
        'payment_method': 'Transferencia',
        'date': DateTime(2024, 1, 5),
        'suppliers_id': 'SUPP001',
        'category': 'Servicios Básicos',
        'details': 'Consumo eléctrico enero 2024',
      },
      {
        'id': 'B002',
        'amount': -800000.0,
        'observations': 'Compra de mesas y sillas',
        'payment_method': 'Cheque',
        'date': DateTime(2023, 11, 20),
        'suppliers_id': 'SUPP002',
        'category': 'Mobiliario',
        'details': 'Set completo para eventos grandes',
      },
      {
        'id': 'B003',
        'amount': -250000.0,
        'observations': 'Servicio de catering especializado',
        'payment_method': 'Transferencia',
        'date': DateTime(2024, 2, 10),
        'suppliers_id': 'SUPP003',
        'category': 'Alimentación',
        'details': 'Catering para evento corporativo',
      },
    ];

    income = [
      {
        'id': 'I001',
        'amount': 2500000.0,
        'observations': 'Pago completo boda Carmen',
        'payment_method': 'Transferencia',
        'date': DateTime(2023, 12, 15),
        'customer_id': '1',
        'event': 'Boda de Carmen',
      },
      {
        'id': 'I002',
        'amount': 1200000.0,
        'observations': 'Pago cumpleaños Miguel Jr.',
        'payment_method': 'Efectivo',
        'date': DateTime(2023, 11, 5),
        'customer_id': '2',
        'event': 'Cumpleaños Miguel Jr.',
      },
      {
        'id': 'I003',
        'amount': 1800000.0,
        'observations': 'Anticipo graduación Lucía',
        'payment_method': 'Tarjeta de Crédito',
        'date': DateTime(2024, 1, 10),
        'customer_id': '3',
        'event': 'Graduación Lucía',
      },
      {
        'id': 'I004',
        'amount': 800000.0,
        'observations': 'Pago completo aniversario Carmen',
        'payment_method': 'Transferencia',
        'date': DateTime(2023, 8, 22),
        'customer_id': '1',
        'event': 'Aniversario Carmen',
      },
      {
        'id': 'I005',
        'amount': 1500000.0,
        'observations': 'Pago bautizo Roberto Jr.',
        'payment_method': 'Cheque',
        'date': DateTime(2024, 2, 28),
        'customer_id': '4',
        'event': 'Bautizo Roberto Jr.',
      },
    ];
  }

  void _agregarRegistroFinanciero(Map<String, dynamic> registro) {
    setState(() {
      financialRecords.add(registro);
    });
  }

  void _agregarFactura(Map<String, dynamic> factura) {
    setState(() {
      bills.add(factura);
    });
  }

  void _agregarIngreso(Map<String, dynamic> ingreso) {
    setState(() {
      income.add(ingreso);
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
            child: const Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Text(
                    'Ingresos y Gastos',
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
          Expanded(
            child: VistaBotonesBonitos(
              onComparativas: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ComparativasScreen(
                    financialRecords: financialRecords,
                    bills: bills,
                    income: income,
                  ),
                ),
              ),
              onFormulario: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FormularioDeRegistrosScreen(
                    agregarRegistroFinanciero: _agregarRegistroFinanciero,
                    agregarFactura: _agregarFactura,
                    agregarIngreso: _agregarIngreso,
                    financialRecords: financialRecords,
                    bills: bills,
                    income: income,
                  ),
                ),
              ),
              onReporte: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ReporteFinancieroScreen(
                    financialRecords: financialRecords,
                    bills: bills,
                    income: income,
                  ),
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
        _buildBoton(const Color(0xFFA8D5BA), Icons.bar_chart, 'Comparativas',
            'Análisis gráfico', onComparativas),
        _buildBoton(const Color(0xFF69B4A1), Icons.receipt_long,
            'Formulario de Registro', 'Gestionar finanzas', onFormulario),
        _buildBoton(const Color(0xFF3A7F54), Icons.insert_chart,
            'Reporte Financiero', 'Resumen completo', onReporte),
      ],
    );
  }
}

class FormularioDeRegistrosScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) agregarRegistroFinanciero;
  final Function(Map<String, dynamic>) agregarFactura;
  final Function(Map<String, dynamic>) agregarIngreso;
  final List<Map<String, dynamic>> financialRecords;
  final List<Map<String, dynamic>> bills;
  final List<Map<String, dynamic>> income;

  const FormularioDeRegistrosScreen({
    super.key,
    required this.agregarRegistroFinanciero,
    required this.agregarFactura,
    required this.agregarIngreso,
    required this.financialRecords,
    required this.bills,
    required this.income,
  });

  @override
  _FormularioDeRegistrosScreenState createState() =>
      _FormularioDeRegistrosScreenState();
}

class _FormularioDeRegistrosScreenState
    extends State<FormularioDeRegistrosScreen> {
  int _currentTab = 0;
  final _formKey = GlobalKey<FormState>();

  // Controladores comunes
  final _amountController = TextEditingController();
  final _observationsController = TextEditingController();
  final _idController = TextEditingController();
  
  // Controladores específicos
  final _supplierIdController = TextEditingController();
  final _categoryController = TextEditingController();
  final _detailsController = TextEditingController();
  final _customerIdController = TextEditingController();
  final _eventController = TextEditingController();

  String _paymentMethod = 'Efectivo';
  DateTime _selectedDate = DateTime.now();

  final List<String> _paymentMethods = [
    'Efectivo',
    'Tarjeta de Crédito',
    'Tarjeta de Débito',
    'Transferencia',
    'Cheque'
  ];

  void _guardarRegistro() {
    if (_formKey.currentState?.validate() ?? false) {
      final amount = double.tryParse(_amountController.text);
      
      if (amount != null) {
        final baseRecord = {
          'id': _idController.text,
          'amount': amount,
          'observations': _observationsController.text,
          'payment_method': _paymentMethod,
          'date': _selectedDate,
        };

        if (_currentTab == 0) {
          // Financial Record
          widget.agregarRegistroFinanciero(baseRecord);
        } else if (_currentTab == 1) {
          // Bills
          final billRecord = {
            ...baseRecord,
            'suppliers_id': _supplierIdController.text,
            'category': _categoryController.text,
            'details': _detailsController.text,
          };
          widget.agregarFactura(billRecord);
        } else {
          // Income
          final incomeRecord = {
            ...baseRecord,
            'customer_id': _customerIdController.text,
            'event': _eventController.text,
          };
          widget.agregarIngreso(incomeRecord);
        }

        _limpiarFormulario();
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

  void _limpiarFormulario() {
    _amountController.clear();
    _observationsController.clear();
    _idController.clear();
    _supplierIdController.clear();
    _categoryController.clear();
    _detailsController.clear();
    _customerIdController.clear();
    _eventController.clear();
    setState(() {
      _paymentMethod = 'Efectivo';
      _selectedDate = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'Formulario de Registros',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[100],
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _currentTab = 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _currentTab == 0 ? const Color(0xFF3A7F54) : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Registro Financiero',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _currentTab == 0 ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _currentTab = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _currentTab == 1 ? const Color(0xFF3A7F54) : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Facturas',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _currentTab == 1 ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _currentTab = 2),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _currentTab == 2 ? const Color(0xFF3A7F54) : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Ingresos',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _currentTab == 2 ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Campos comunes
                    _buildCommonFields(),
                    const SizedBox(height: 16),
                    
                    // Campos específicos según el tab
                    if (_currentTab == 1) _buildBillsFields(),
                    if (_currentTab == 2) _buildIncomeFields(),
                    
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3A7F54),
                          foregroundColor: Colors.white,
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
        ],
      ),
    );
  }

  Widget _buildCommonFields() {
    return Column(
      children: [
        TextFormField(
          controller: _idController,
          decoration: InputDecoration(
            labelText: 'ID',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          validator: (value) => value?.isEmpty ?? true ? 'Campo requerido' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _amountController,
          decoration: InputDecoration(
            labelText: 'Monto (\$)',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'Campo requerido';
            if (double.tryParse(value!) == null) return 'Número inválido';
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _observationsController,
          decoration: InputDecoration(
            labelText: 'Observaciones',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: _paymentMethod,
          decoration: InputDecoration(
            labelText: 'Método de Pago',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          items: _paymentMethods.map((method) {
            return DropdownMenuItem<String>(
              value: method,
              child: Text(method),
            );
          }).toList(),
          onChanged: (value) => setState(() => _paymentMethod = value!),
        ),
        const SizedBox(height: 16),
        ListTile(
          title: Text('Fecha: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
          trailing: const Icon(Icons.calendar_today),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: _selectedDate,
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
            );
            if (date != null) {
              setState(() => _selectedDate = date);
            }
          },
        ),
      ],
    );
  }

  Widget _buildBillsFields() {
    return Column(
      children: [
        TextFormField(
          controller: _supplierIdController,
          decoration: InputDecoration(
            labelText: 'ID del Proveedor',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          validator: (value) => value?.isEmpty ?? true ? 'Campo requerido' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _categoryController,
          decoration: InputDecoration(
            labelText: 'Categoría',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          validator: (value) => value?.isEmpty ?? true ? 'Campo requerido' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _detailsController,
          decoration: InputDecoration(
            labelText: 'Detalles',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildIncomeFields() {
    return Column(
      children: [
        TextFormField(
          controller: _customerIdController,
          decoration: InputDecoration(
            labelText: 'ID del Cliente',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          validator: (value) => value?.isEmpty ?? true ? 'Campo requerido' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _eventController,
          decoration: InputDecoration(
            labelText: 'Evento',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          validator: (value) => value?.isEmpty ?? true ? 'Campo requerido' : null,
        ),
      ],
    );
  }
}

class ComparativasScreen extends StatefulWidget {
  final List<Map<String, dynamic>> financialRecords;
  final List<Map<String, dynamic>> bills;
  final List<Map<String, dynamic>> income;

  const ComparativasScreen({
    super.key,
    required this.financialRecords,
    required this.bills,
    required this.income,
  });

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
    // Calcular datos mensuales
    Map<int, double> ingresosPorMes = {};
    Map<int, double> gastosPorMes = {};

    // Procesar ingresos
    for (var ingreso in widget.income) {
      DateTime fecha = ingreso['date'];
      double monto = ingreso['amount'];
      int mes = fecha.month;
      ingresosPorMes[mes] = (ingresosPorMes[mes] ?? 0) + monto;
    }

    // Procesar gastos (bills y financial records negativos)
    for (var factura in widget.bills) {
      DateTime fecha = factura['date'];
      double monto = factura['amount'].abs();
      int mes = fecha.month;
      gastosPorMes[mes] = (gastosPorMes[mes] ?? 0) + monto;
    }

    for (var record in widget.financialRecords) {
      DateTime fecha = record['date'];
      double monto = record['amount'];
      int mes = fecha.month;
      if (monto < 0) {
        gastosPorMes[mes] = (gastosPorMes[mes] ?? 0) + monto.abs();
      } else {
        ingresosPorMes[mes] = (ingresosPorMes[mes] ?? 0) + monto;
      }
    }

    // Convertir a FlSpot para los gráficos
    List<FlSpot> ingresosSpots = [];
    List<FlSpot> gastosSpots = [];

    for (int mes = 1; mes <= 12; mes++) {
      ingresosSpots.add(FlSpot(mes.toDouble(), ingresosPorMes[mes] ?? 0));
      gastosSpots.add(FlSpot(mes.toDouble(), gastosPorMes[mes] ?? 0));
    }

    setState(() {
      monthlyData = ingresosSpots;
      quarterlyData = gastosSpots;
      annualData = [
        FlSpot(1, ingresosPorMes.values.fold(0, (a, b) => a + b)),
        FlSpot(2, gastosPorMes.values.fold(0, (a, b) => a + b)),
      ];
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
              title: 'Ingresos Mensuales',
              description: 'Mejor rendimiento en eventos',
              icon: Icons.trending_up,
              data: monthlyData,
              color: const Color(0xFF4FA6B8),
            ),
            const SizedBox(height: 16),
            _buildStyledCard(
              title: 'Gastos Mensuales',
              description: 'Control de gastos operativos',
              icon: Icons.trending_down,
              data: quarterlyData,
              color: const Color(0xFF336D7B),
            ),
            const SizedBox(height: 16),
            _buildStyledCard(
              title: 'Resumen Anual',
              description: 'Ingresos vs Gastos totales',
              icon: Icons.bar_chart,
              data: annualData,
              color: const Color(0xFF275664),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gráfico de Tendencias',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3A7F54),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AspectRatio(
                    aspectRatio: 1.5,
                    child: LineChart(
                      LineChartData(
                        borderData: FlBorderData(show: true),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                switch (value.toInt()) {
                                  case 1: return const Text('Ene');
                                  case 3: return const Text('Mar');
                                  case 6: return const Text('Jun');
                                  case 9: return const Text('Sep');
                                  case 12: return const Text('Dic');
                                  default: return const Text('');
                                }
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        gridData: FlGridData(show: true),
                        lineBarsData: [
                          LineChartBarData(
                            spots: currentData,
                            isCurved: true,
                            color: const Color(0xFF3A7F54),
                            barWidth: 4,
                            dotData: FlDotData(show: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
  final List<Map<String, dynamic>> financialRecords;
  final List<Map<String, dynamic>> bills;
  final List<Map<String, dynamic>> income;

  const ReporteFinancieroScreen({
    super.key,
    required this.financialRecords,
    required this.bills,
    required this.income,
  });

  @override
  Widget build(BuildContext context) {
    double totalIngresos = 0;
    double totalGastos = 0;

    // Calcular ingresos
    for (var ingreso in income) {
      totalIngresos += ingreso['amount'];
    }

    // Calcular gastos
    for (var factura in bills) {
      totalGastos += factura['amount'].abs();
    }

    for (var record in financialRecords) {
      if (record['amount'] < 0) {
        totalGastos += record['amount'].abs();
      } else {
        totalIngresos += record['amount'];
      }
    }

    double saldo = totalIngresos - totalGastos;

    // Datos para el gráfico de barras mejorado
    List<BarChartGroupData> barChartData = [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: totalIngresos / 1000000,
            color: Colors.green,
            width: 40,
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [Colors.green.shade300, Colors.green.shade700],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: totalGastos / 1000000,
            color: Colors.red,
            width: 40,
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [Colors.red.shade300, Colors.red.shade700],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ],
      ),
    ];

    // Datos para el gráfico de pastel
    List<PieChartSectionData> pieChartData = [
      PieChartSectionData(
        color: Colors.green,
        value: totalIngresos,
        title: 'Ingresos\n${((totalIngresos / (totalIngresos + totalGastos)) * 100).toStringAsFixed(1)}%',
        radius: 80,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: totalGastos,
        title: 'Gastos\n${((totalGastos / (totalIngresos + totalGastos)) * 100).toStringAsFixed(1)}%',
        radius: 80,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
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
                'Reporte Financiero',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Resumen financiero con mejores diseños
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.grey.shade50],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.analytics, 
                          color: const Color(0xFF3A7F54), size: 28),
                      const SizedBox(width: 12),
                      const Text(
                        'Resumen Financiero',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3A7F54),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildEnhancedSummaryCard('Total Ingresos', totalIngresos, 
                      Colors.green, Icons.trending_up),
                  const SizedBox(height: 12),
                  _buildEnhancedSummaryCard('Total Gastos', totalGastos, 
                      Colors.red, Icons.trending_down),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: saldo >= 0 ? Colors.green.shade50 : Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: saldo >= 0 ? Colors.green.shade200 : Colors.red.shade200,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              saldo >= 0 ? Icons.account_balance_wallet : Icons.warning,
                              color: saldo >= 0 ? Colors.green : Colors.red,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Saldo Neto:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: saldo >= 0 ? Colors.green.shade800 : Colors.red.shade800,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '\$${saldo.toStringAsFixed(0).replaceAllMapped(
                            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            (Match m) => '${m[1]}.',
                          )}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: saldo >= 0 ? Colors.green.shade800 : Colors.red.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Gráficos mejorados
            Row(
              children: [
                // Gráfico de barras
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.bar_chart, 
                                color: const Color(0xFF3A7F54), size: 24),
                            const SizedBox(width: 8),
                            const Text(
                              'Comparación\n(en millones)',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3A7F54),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        AspectRatio(
                          aspectRatio: 1.2,
                          child: BarChart(
                            BarChartData(
                              borderData: FlBorderData(show: false),
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: false,
                                horizontalInterval: 1,
                                getDrawingHorizontalLine: (value) {
                                  return FlLine(
                                    color: Colors.grey.shade300,
                                    strokeWidth: 1,
                                  );
                                },
                              ),
                              titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      const style = TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      );
                                      switch (value.toInt()) {
                                        case 0: return Text('Ingresos', style: style);
                                        case 1: return Text('Gastos', style: style);
                                        default: return const Text('');
                                      }
                                    },
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 40,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        '${value.toInt()}M',
                                        style: const TextStyle(fontSize: 10),
                                      );
                                    },
                                  ),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              barGroups: barChartData,
                              maxY: ((totalIngresos > totalGastos ? totalIngresos : totalGastos) / 1000000) * 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Gráfico de pastel
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.pie_chart, 
                                color: const Color(0xFF3A7F54), size: 24),
                            const SizedBox(width: 8),
                            const Text(
                              'Distribución\nPorcentual',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3A7F54),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        AspectRatio(
                          aspectRatio: 1.2,
                          child: PieChart(
                            PieChartData(
                              sections: pieChartData,
                              borderData: FlBorderData(show: false),
                              sectionsSpace: 2,
                              centerSpaceRadius: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Lista de transacciones recientes mejorada
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.receipt_long, 
                          color: const Color(0xFF3A7F54), size: 24),
                      const SizedBox(width: 12),
                      const Text(
                        'Transacciones Recientes por Eventos',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3A7F54),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: income.length,
                    itemBuilder: (context, index) {
                      final ingreso = income[index];
                      return _buildEnhancedTransactionTile(
                        ingreso['event'] ?? 'Evento sin nombre',
                        ingreso['amount'],
                        'Ingreso',
                        ingreso['date'],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnhancedSummaryCard(String label, double amount, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          Text(
            '\$${amount.toStringAsFixed(0).replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]}.',
            )}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color, // Use the base color or replace with a specific Color if needed
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedTransactionTile(String description, double amount, String type, DateTime date) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: amount >= 0 ? Colors.green.shade50 : Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: amount >= 0 ? Colors.green.shade200 : Colors.red.shade200,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: amount >= 0 ? Colors.green : Colors.red,
              shape: BoxShape.circle,
            ),
            child: Icon(
              amount >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '$type - ${date.day}/${date.month}/${date.year}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(0).replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]}.',
            )}',
            style: TextStyle(
              color: amount >= 0 ? Colors.green.shade800 : Colors.red.shade800,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
