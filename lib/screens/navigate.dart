import 'package:flutter/material.dart';
import 'home.dart'; // Importa las pantallas
import 'screen_3.dart';
import 'screen_4.dart';
import 'IngresosYGastos.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
    const Screen3(), // Llama la vista Screen3
    const Screen4(), // Llama la vista Screen4
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
              leading: const Icon(Icons.person),
              title: const Text('Vista 4'),
              onTap: () {
                setState(() => _currentIndex = 3);
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
              icon: Icons.person,
              text: 'Vista 4',
              iconActiveColor: Colors.white,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
