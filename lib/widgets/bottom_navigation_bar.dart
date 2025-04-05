import 'package:flutter/material.dart';
import '../themes/colours.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: AppColours.primary,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.ssid_chart),
          label: 'Waves',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.science_outlined),
          label: 'Problem Solver',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.tungsten_outlined),
          label: 'Solutions',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sticky_note_2_outlined),
          label: 'Cheat Sheet',
        ),
      ],
    );
  }
}
