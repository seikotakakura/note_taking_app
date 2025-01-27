import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  final Widget child;
  final String currentLocation;

  const BottomNavBar(
      {Key? key, required this.child, required this.currentLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List of tabs and their corresponding routes
    final List<Map<String, dynamic>> tabs = [
      {
        'label': 'Home',
        'icon': Icons.home,
        'route': '/home_page',
      },
      {
        'label': 'New Note',
        'icon': Icons.note_add,
        'route': '/new_note_page',
      },
      {
        'label': 'Calendar',
        'icon': Icons.calendar_month_outlined,
        'route': '/calendar_page',
      },
    ];

    final widthTab = 45.0;
    final heightTab = 45.0;

    bool showBottomNav = true;
    if (currentLocation == '/new_note_page') {
      showBottomNav = false;
    }

    return Scaffold(
      body: child,
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: showBottomNav == false ? null : SafeArea(
        child: Container(
          width: (widthTab + 8) * 3, //(width + padding) * content
          height: 56.0,
          // padding: EdgeInsets.all(12.0),
          margin: EdgeInsets.symmetric(horizontal: 24.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: tabs.map((tab) {
              final isActive = tab['route'] == currentLocation;

              return GestureDetector(
                onTap: () {
                  final String selectedRoute = tab['route']!;
                  if (selectedRoute != currentLocation) {
                    context.go(selectedRoute);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: widthTab,
                    height: heightTab,
                    decoration: BoxDecoration(
                      color: isActive ? Color(0xFFFF6903) : Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    ),
                    child: Icon(
                      tab['icon'],
                      size: 18.0,
                      color: isActive ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
