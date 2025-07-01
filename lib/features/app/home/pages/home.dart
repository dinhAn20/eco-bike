import 'package:eco_bike/features/bike/presentation/pages/way_station.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  final _pages = [Container(), WayStationPage(), Container(), Container()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Eco Bike")),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Iconsax.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.map),
            label: "Way Station",
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.notification),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.setting),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
