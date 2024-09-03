import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;

  BottomNavBar({required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.of(context).pushReplacementNamed('/panel');
            break;
          case 1:
            Navigator.of(context).pushReplacementNamed('/home');
            break;
          case 2:
            Navigator.of(context).pushReplacementNamed('/add');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Panel',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.note_add),
          label: 'Agregar',
        ),
      ],
      selectedItemColor: Colors.brown[800],
      unselectedItemColor: Colors.grey,
    );
  }
}
