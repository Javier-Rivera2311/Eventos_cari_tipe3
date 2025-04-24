import 'package:flutter/material.dart';
import 'home.dart'; // Importa las pantallas
import 'screen_3.dart';
import 'ingresos_gastos.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'lista_proveedores.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // Lista de pantallas
  final screens = [
  const HomeScreen(),
  const IngresosYGastosScreen(),
  const Screen3(),
  const ListaProveedoresScreen(), // ⬅️ NUEVA pantalla
  ];


  final colors = [
    Color(0xFFA8D5BA),
    Color(0xFF69B4A1),
    Color(0xFFA4D679),
    Color(0xFF3A7F54)
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
              title: const Text('Vista 2'),
              onTap: () {
                setState(() => _currentIndex = 1);
                Navigator.pop(context); // Cierra el drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text('Vista 3'),
              onTap: () {
                setState(() => _currentIndex = 2);
                Navigator.pop(context); // Cierra el drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Proveedores'),
              onTap: () {
                setState(() => _currentIndex = 3); // índice correspondiente
                Navigator.pop(context);
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
              text: 'Vista 2',
              iconActiveColor: Colors.white,
              textColor: Colors.white,
            ),
            GButton(
              icon: Icons.inventory,
              text: 'Vista 3',
              iconActiveColor: Colors.white,
              textColor: Colors.white,
            ),
            GButton(
              icon: Icons.list,
              text: 'Proveedores',
              iconActiveColor: Colors.white,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
