import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart'; // Importa las pantallas
import 'clientes.dart';
import 'personal.dart';
import 'IngresosYGastos.dart';
import 'inventory.dart';
import 'eventos.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // Lista de pantallas
  late List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      HomeScreen(onNavigate: (index) => setState(() => _currentIndex = index)),
      const IngresosYGastosScreen(),
      const InventoryScreen(),
      const Screen3(),
      const Screen4(),
      const EventosScreen(),
    ];
  }

  final colors = [
    Color(0xFFA8D5BA),
    Color(0xFF69B4A1),
    Color(0xFFA4D679),
    Color(0xFF3A7F54),
    Color(0xFF3A7F54),
    Color(0xFF3A7F54)
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return false;
        }
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Container(
            decoration: BoxDecoration(
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
              title: const Text('Eventos Cari App',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
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
      ),
    );
  }
}
