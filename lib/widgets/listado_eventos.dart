import 'package:flutter/material.dart';

class ListadoEventos extends StatefulWidget {
  const ListadoEventos({super.key});

  @override
  State<ListadoEventos> createState() => _ListadoEventosState();
}

class _ListadoEventosState extends State<ListadoEventos> {
  int? eventoSeleccionadoIndex;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> filteredEventos = [];

  List<Map<String, String>> eventos = [
    {
      'event_name': 'Boda de Carmen',
      'event_time': '15/12/2023 - 18:00',
      'total_amount': '\$2.500.000',
      'observations': 'Ceremonia al aire libre, decoración en blanco y dorado',
      'client_id': '1',
      'client_name': 'Carmen Rodríguez',
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
      'client_id': '1',
      'client_name': 'Carmen Rodríguez',
      'event_location': 'Salón Las Acacias',
      'district': 'Caracas',
      'event_type': 'Aniversario',
      'status': 'Completado',
      'deposit': '\$400.000',
      'outstanding_balance': '\$0'
    },
    {
      'event_name': 'Cumpleaños Miguel Jr.',
      'event_time': '05/11/2023 - 15:00',
      'total_amount': '\$1.200.000',
      'observations': 'Fiesta temática de superhéroes',
      'client_id': '2',
      'client_name': 'Miguel Hernández',
      'event_location': 'Club Los Samanes',
      'district': 'Valencia',
      'event_type': 'Cumpleaños',
      'status': 'Completado',
      'deposit': '\$600.000',
      'outstanding_balance': '\$0'
    },
    {
      'event_name': 'Graduación Lucía',
      'event_time': '18/01/2024 - 17:00',
      'total_amount': '\$1.800.000',
      'observations': 'Celebración de graduación universitaria',
      'client_id': '3',
      'client_name': 'Lucía Morales',
      'event_location': 'Hotel Plaza Centro',
      'district': 'Barquisimeto',
      'event_type': 'Graduación',
      'status': 'Pendiente',
      'deposit': '\$900.000',
      'outstanding_balance': '\$900.000'
    },
    {
      'event_name': 'Bautizo Roberto Jr.',
      'event_time': '28/02/2024 - 11:00',
      'total_amount': '\$1.500.000',
      'observations': 'Ceremonia religiosa seguida de almuerzo',
      'client_id': '4',
      'client_name': 'Roberto Silva',
      'event_location': 'Iglesia San José',
      'district': 'Maracaibo',
      'event_type': 'Bautizo',
      'status': 'Confirmado',
      'deposit': '\$750.000',
      'outstanding_balance': '\$750.000'
    },
    {
      'event_name': 'Quinceañero Isabella',
      'event_time': '15/03/2024 - 20:00',
      'total_amount': '\$2.200.000',
      'observations': 'Fiesta de 15 años con temática princesa',
      'client_id': '5',
      'client_name': 'Isabella Torres',
      'event_location': 'Salón de Fiestas Royal',
      'district': 'Maracay',
      'event_type': 'Quinceañero',
      'status': 'Confirmado',
      'deposit': '\$1.100.000',
      'outstanding_balance': '\$1.100.000'
    }
  ];

  @override
  void initState() {
    super.initState();
    filteredEventos = eventos;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredEventos = eventos.where((evento) {
        final eventName = (evento['event_name'] ?? '').toLowerCase();
        final clientName = (evento['client_name'] ?? '').toLowerCase();
        final eventType = (evento['event_type'] ?? '').toLowerCase();
        return eventName.contains(query) || 
               clientName.contains(query) || 
               eventType.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (eventoSeleccionadoIndex != null) {
          setState(() {
            eventoSeleccionadoIndex = null;
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
                    if (eventoSeleccionadoIndex != null) {
                      setState(() {
                        eventoSeleccionadoIndex = null;
                      });
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                ),
                title: Text(
                  eventoSeleccionadoIndex != null 
                      ? 'Detalles del Evento'
                      : 'Todos los Eventos',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
          ),
        ),
        body: eventoSeleccionadoIndex == null
            ? _buildListaEventos()
            : _buildDetalleEvento(),
      ),
    );
  }

  Widget _buildListaEventos() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Buscar por evento, cliente o tipo',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 0, horizontal: 16),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: filteredEventos.length,
            itemBuilder: (context, index) {
              final evento = filteredEventos[index];
              
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _getStatusColor(evento['status'] ?? ''),
                    child: Icon(_getEventIcon(evento['event_type'] ?? ''), color: Colors.white),
                  ),
                  title: Text(
                    evento['event_name'] ?? 'Sin nombre',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('Cliente: ${evento['client_name'] ?? 'No disponible'}'),
                      Text('Fecha: ${evento['event_time'] ?? 'No disponible'}'),
                      Text('Tipo: ${evento['event_type'] ?? 'No disponible'}'),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getStatusColor(evento['status'] ?? ''),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          evento['status'] ?? 'Sin estado',
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  isThreeLine: true,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 16),
                  onTap: () {
                    setState(() {
                      eventoSeleccionadoIndex = eventos.indexOf(evento);
                    });
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDetalleEvento() {
    final evento = eventos[eventoSeleccionadoIndex!];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
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
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3A7F54),
                ),
              ),
              const SizedBox(height: 16),
              _buildInfoRow(Icons.person, 'Cliente', evento['client_name'] ?? ''),
              _buildInfoRow(Icons.access_time, 'Fecha y Hora', evento['event_time'] ?? ''),
              _buildInfoRow(Icons.location_on, 'Ubicación', evento['event_location'] ?? ''),
              _buildInfoRow(Icons.location_city, 'Distrito', evento['district'] ?? ''),
              _buildInfoRow(Icons.category, 'Tipo de Evento', evento['event_type'] ?? ''),
              _buildInfoRow(Icons.info, 'Estado', evento['status'] ?? '', 
                  color: _getStatusColor(evento['status'] ?? '')),
              const Divider(thickness: 2),
              _buildInfoRow(Icons.attach_money, 'Monto Total', evento['total_amount'] ?? ''),
              _buildInfoRow(Icons.payment, 'Depósito', evento['deposit'] ?? ''),
              _buildInfoRow(Icons.money_off, 'Saldo Pendiente', evento['outstanding_balance'] ?? '',
                  color: evento['outstanding_balance'] != '\$0' ? Colors.red : Colors.green),
              if (evento['observations']?.isNotEmpty ?? false) ...[
                const SizedBox(height: 16),
                const Text(
                  'Observaciones:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    evento['observations'] ?? '',
                    style: const TextStyle(color: Colors.black87),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.blueGrey),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                color: color ?? Colors.black87,
                fontWeight: color != null ? FontWeight.w600 : FontWeight.normal,
                fontSize: 16,
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

  IconData _getEventIcon(String eventType) {
    switch (eventType.toLowerCase()) {
      case 'boda':
        return Icons.favorite;
      case 'cumpleaños':
        return Icons.cake;
      case 'graduación':
        return Icons.school;
      case 'bautizo':
        return Icons.child_care;
      case 'quinceañero':
        return Icons.celebration;
      case 'aniversario':
        return Icons.card_giftcard;
      default:
        return Icons.event;
    }
  }
}
