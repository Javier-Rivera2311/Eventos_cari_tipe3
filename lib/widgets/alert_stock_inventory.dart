import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AlertStockInventory extends StatefulWidget {
  final List<Map<String, String>> inventory;

  const AlertStockInventory({super.key, required this.inventory});

  @override
  State<AlertStockInventory> createState() => _AlertStockInventoryState();
}

class _AlertStockInventoryState extends State<AlertStockInventory> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _checkLowStock();
  }

  // Inicializa las notificaciones locales
  void _initializeNotifications() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Verifica si hay productos con stock bajo y muestra una alerta
  void _checkLowStock() {
    final lowStockItems = widget.inventory
        .where((item) => int.parse(item['cantidad']!) < 10)
        .toList();

    if (lowStockItems.isNotEmpty) {
      _showLowStockAlert(lowStockItems);
      _sendLowStockNotification(lowStockItems);
    }
  }

  // Muestra una alerta visual en la aplicación
  void _showLowStockAlert(List<Map<String, String>> lowStockItems) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Alerta de Stock Bajo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: lowStockItems.map((item) {
              return Text(
                  '${item['nombre']} tiene solo ${item['cantidad']} unidades.');
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  // Envía una notificación local al celular
  Future<void> _sendLowStockNotification(
      List<Map<String, String>> lowStockItems) async {
    for (var item in lowStockItems) {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'low_stock_channel', // ID del canal
        'Stock Bajo', // Nombre del canal
        channelDescription: 'Notificaciones de stock bajo',
        importance: Importance.high,
        priority: Priority.high,
      );

      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.show(
        0, // ID de la notificación
        'Stock Bajo: ${item['nombre']}',
        '${item['nombre']} tiene solo ${item['cantidad']} unidades.',
        platformChannelSpecifics,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // Este widget no tiene UI, solo lógica.
  }
}