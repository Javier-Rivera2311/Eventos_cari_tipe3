import 'package:flutter/material.dart';
import 'home.dart'; // Importa las pantallas
import 'clientes.dart';
import 'personal.dart';
import 'IngresosYGastos.dart';
import 'inventory.dart';
import 'eventos.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'proveedores_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // Lista de pantallas
  final screens = [
    const HomeScreen(), // Llama la vista HomeScreen
    const IngresosYGastosScreen(), // Llama la vista Screen2
    const InventoryScreen(),
    const Screen3(), // Llama la vista Screen3
    const Screen4(), // Llama la vista Screen4
    const EventosScreen(),
    const ProveedoresHome(), // Llama la vista ProveedoresHome
  ];

  final colors = [
    Color(0xFFA8D5BA),
    Color(0xFF69B4A1),
    Color(0xFFA4D679),
    Color(0xFF3A7F54),
    Color.fromARGB(255, 12, 90, 42),
    Color(0xFF3A7F54),
    Color(0xFF3A7F54),
    Color(0xFF3A7F54),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyApp',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        centerTitle: true,
        backgroundColor: colors[_currentIndex],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: colors[_currentIndex],
              ),
              child: const Text(
                'Menú',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                setState(() => _currentIndex = 0);
                Navigator.pop(context); // Cierra el drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text('Ingresos Y Gastos'),
              onTap: () {
                setState(() => _currentIndex = 1);
                Navigator.pop(context); // Cierra el drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text('Inventario'),
              onTap: () {
                setState(() => _currentIndex = 2);
                Navigator.pop(context); // Cierra el drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Clientes'),
              onTap: () {
                setState(() => _currentIndex = 3);
                Navigator.pop(context); // Cierra el drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Personal'),
              onTap: () {
                setState(() => _currentIndex = 4);
                Navigator.pop(context); // Cierra el drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Eventos'),
              onTap: () {
                setState(() => _currentIndex = 5);
                Navigator.pop(context); // Cierra el drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text('Proveedores'),
              onTap: () {
                setState(() => _currentIndex = 6);
                Navigator.pop(context); // Cierra el drawer
              },
            ),
          ],
        ),
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.only(bottom: 10),
        child: GNav(
          color: colors[_currentIndex],
          tabBackgroundColor: colors[_currentIndex],
          selectedIndex: _currentIndex,
          tabBorderRadius: 10,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          onTabChange: (index) => {setState(() => _currentIndex = index)},
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
              iconActiveColor: Colors.white,
              textColor: Colors.white,
            ),
            GButton(
              icon: Icons.analytics,
              text: 'Ingresos y gastos',
              iconActiveColor: Colors.white,
              textColor: Colors.white,
            ),
            GButton(
              icon: Icons.inventory,
              text: 'Inventario',
              iconActiveColor: Colors.white,
              textColor: Colors.white,
            ),
            GButton(
              icon: Icons.person,
              text: 'Clientes',
              iconActiveColor: Colors.white,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
