import 'package:flutter/material.dart';
import 'inventory.dart';
import 'IngresosYGastos.dart';
import 'clientes.dart';
import 'personal.dart';
import 'eventos.dart';

class HomeScreen extends StatelessWidget {
  final void Function(int)? onNavigate;

  const HomeScreen({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 100,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFA8D5BA),
                  Color(0xFF69B4A1),
                  Color(0xFFA4D679),
                  Color(0xFF3A7F54),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.only(left: 24, bottom: 24),
            child: const Text(
              'Bienvenido a Eventos Cari App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Text(
                'Explora las funcionalidades de la aplicación desde el menú lateral o utiliza los botones rápidos a continuación.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                _buildStyledButton(
                  context,
                  icon: Icons.inventory,
                  label: 'Inventario',
                  color: const Color(0xFFA8D5BA),
                  onTap: () {
                    onNavigate?.call(2);
                  },
                ),
                _buildStyledButton(
                  context,
                  icon: Icons.analytics,
                  label: 'Ingresos y Gastos',
                  color: const Color(0xFF69B4A1),
                  onTap: () {
                    onNavigate?.call(1);
                  },
                ),
                _buildStyledButton(
                  context,
                  icon: Icons.person,
                  label: 'Clientes',
                  color: const Color(0xFFA4D679),
                  onTap: () {
                    onNavigate?.call(3);
                  },
                ),
                _buildStyledButton(
                  context,
                  icon: Icons.group,
                  label: 'Personal',
                  color: const Color(0xFF3A7F54),
                  onTap: () {
                    onNavigate?.call(4);
                  },
                ),
                _buildStyledButton(
                  context,
                  icon: Icons.event,
                  label: 'Eventos',
                  color: const Color(0xFF2E5D47),
                  onTap: () {
                    onNavigate?.call(5);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildStyledButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: 150,
      height: 60,
      child: ElevatedButton.icon(
  onPressed: onTap,
  icon: Icon(icon),
  label: Text(label),
  style: ElevatedButton.styleFrom(
    backgroundColor: color,
    foregroundColor: Colors.white,
    textStyle: const TextStyle(fontWeight: FontWeight.w600),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 4,
  ),
),
    );
  }
}

