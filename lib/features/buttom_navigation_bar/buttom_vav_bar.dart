import 'package:flutter/material.dart';
import 'package:sakn/features/home/home.dart';
import 'package:sakn/features/profile/profile.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import '../search/search.dart';

class ButtomVavBar extends StatefulWidget {
  const ButtomVavBar({super.key});

  @override
  State<ButtomVavBar> createState() => _ButtomVavBarState();
}

class _ButtomVavBarState extends State<ButtomVavBar> {
  List<Widget> pages = [const Home(), const Search(), const Profile()];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: SlidingClippedNavBar.colorful(
        backgroundColor: Colors.white,
        onButtonPressed: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        iconSize: 30,
        selectedIndex: selectedIndex,
        barItems: [
          BarItem(
            icon: Icons.home,
            title: 'Home',
            activeColor: Colors.orange,
            inactiveColor: Colors.grey,
          ),
          BarItem(
            icon: Icons.search,
            title: 'Search',
            activeColor: Colors.red,
            inactiveColor: Colors.grey,
          ),
          BarItem(
            icon: Icons.person,
            title: 'Profile',
            activeColor: Colors.blue,
            inactiveColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}

// Button Navigation Bar

// List - home - profile - search
