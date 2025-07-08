import 'package:flutter/material.dart';

class HistorialEventosClientes extends StatefulWidget {
  const HistorialEventosClientes({super.key});

  @override
  State<HistorialEventosClientes> createState() => _HistorialEventosClientesState();
}

class _HistorialEventosClientesState extends State<HistorialEventosClientes> {
  int? clienteSeleccionadoIndex;

  List<Map<String, String>> clientes = [
    {
      'id': '1',
      'name': 'Carmen Rodríguez',
      'phone': '+58 424-7778899',
    },
    {
      'id': '2',
      'name': 'Miguel Hernández',
      'phone': '+58 412-3334455',
    },
    {
      'id': '3',
      'name': 'Lucía Morales',
      'phone': '+58 416-6667788',
    },
    {
      'id': '4',
      'name': 'Roberto Silva',
      'phone': '+58 426-9990011',
    },
  ];

  // Eventos por cliente ID
  Map<String, List<Map<String, String>>> eventosClientes = {
    '1': [
      {
        'event_name': 'Boda de Carmen',
        'event_time': '15/12/2023 - 18:00',
        'total_amount': '\$2.500.000',
        'observations': 'Ceremonia al aire libre, decoración en blanco y dorado',
        'event_location': 'Jardín Botánico Nacional',
        'district': 'Caracas',
        'event_type': 'Boda',
        'status': 'Completado',
        'deposit': '\$1.000.000',
        'outstanding_balance': '\$0'
      },
      {
        'event_name': 'Aniversario Carmen',
        'event_time': '22/08/2023 - 19:30',
        'total_amount': '\$800.000',
        'observations': 'Celebración íntima para 30 personas',
        'event_location': 'Salón Las Acacias',
        'district': 'Caracas',
        'event_type': 'Aniversario',
        'status': 'Completado',
        'deposit': '\$400.000',
        'outstanding_balance': '\$0'
      }
    ],
    '2': [
      {
        'event_name': 'Cumpleaños Miguel Jr.',
        'event_time': '05/11/2023 - 15:00',
        'total_amount': '\$1.200.000',
        'observations': 'Fiesta temática de superhéroes',
        'event_location': 'Club Los Samanes',
        'district': 'Valencia',
        'event_type': 'Cumpleaños',
        'status': 'Completado',
        'deposit': '\$600.000',
        'outstanding_balance': '\$0'
      }
    ],
    '3': [
      {
        'event_name': 'Graduación Lucía',
        'event_time': '18/01/2024 - 17:00',
        'total_amount': '\$1.800.000',
        'observations': 'Celebración de graduación universitaria',
        'event_location': 'Hotel Plaza Centro',
        'district': 'Barquisimeto',
        'event_type': 'Graduación',
        'status': 'Pendiente',
        'deposit': '\$900.000',
        'outstanding_balance': '\$900.000'
      }
    ],
    '4': [
      {
        'event_name': 'Bautizo Roberto Jr.',
        'event_time': '28/02/2024 - 11:00',
        'total_amount': '\$1.500.000',
        'observations': 'Ceremonia religiosa seguida de almuerzo',
        'event_location': 'Iglesia San José',
        'district': 'Maracaibo',
        'event_type': 'Bautizo',
        'status': 'Confirmado',
        'deposit': '\$750.000',
        'outstanding_balance': '\$750.000'
      }
    ]
  };

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (clienteSeleccionadoIndex != null) {
          setState(() {
            clienteSeleccionadoIndex = null;
          });
          return false;
        } else {
          Navigator.of(context).pop();
          return false;
        }
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
                    if (clienteSeleccionadoIndex != null) {
                      setState(() {
                        clienteSeleccionadoIndex = null;
                      });
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                ),
                title: Text(
                  clienteSeleccionadoIndex != null 
                      ? 'Eventos de ${clientes[clienteSeleccionadoIndex!]['name']}'
                      : 'Historial de Eventos',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
          ),
        ),
        body: clienteSeleccionadoIndex == null
            ? _buildListaClientes()
            : _buildDetalleEventos(),
      ),
    );
  }

  Widget _buildListaClientes() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: clientes.length,
      itemBuilder: (context, index) {
        final cliente = clientes[index];
        final eventos = eventosClientes[cliente['id']] ?? [];
        
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFFA4D679),
              child: const Icon(Icons.person, color: Colors.white),
            ),
            title: Text(
              cliente['name'] ?? 'Sin nombre',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${eventos.length} evento(s) registrado(s)'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              setState(() {
                clienteSeleccionadoIndex = index;
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildDetalleEventos() {
    final cliente = clientes[clienteSeleccionadoIndex!];
    final eventos = eventosClientes[cliente['id']] ?? [];

    if (eventos.isEmpty) {
      return const Center(
        child: Text(
          'No hay eventos registrados para este cliente',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: eventos.length,
      itemBuilder: (context, index) {
        final evento = eventos[index];
        
        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  evento['event_name'] ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3A7F54),
                  ),
                ),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.access_time, 'Fecha y Hora', evento['event_time'] ?? ''),
                _buildInfoRow(Icons.location_on, 'Ubicación', evento['event_location'] ?? ''),
                _buildInfoRow(Icons.location_city, 'Distrito', evento['district'] ?? ''),
                _buildInfoRow(Icons.category, 'Tipo de Evento', evento['event_type'] ?? ''),
                _buildInfoRow(Icons.info, 'Estado', evento['status'] ?? '', 
                    color: _getStatusColor(evento['status'] ?? '')),
                const Divider(),
                _buildInfoRow(Icons.attach_money, 'Monto Total', evento['total_amount'] ?? ''),
                _buildInfoRow(Icons.payment, 'Depósito', evento['deposit'] ?? ''),
                _buildInfoRow(Icons.money_off, 'Saldo Pendiente', evento['outstanding_balance'] ?? '',
                    color: evento['outstanding_balance'] != '\$0' ? Colors.red : Colors.green),
                if (evento['observations']?.isNotEmpty ?? false) ...[
                  const SizedBox(height: 8),
                  const Text(
                    'Observaciones:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    evento['observations'] ?? '',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Colors.blueGrey),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                color: color ?? Colors.black87,
                fontWeight: color != null ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completado':
        return Colors.green;
      case 'pendiente':
        return Colors.orange;
      case 'confirmado':
        return Colors.blue;
      case 'cancelado':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
