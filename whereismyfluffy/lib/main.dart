import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:whereismyfluffy/pages/home_page.dart';
import 'package:whereismyfluffy/pages/pet_page';

/// Flutter code sample for [NavigationBar].

void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentPageIndex = 0;

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 500,
          color: Colors.amber,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Modal BottomSheet'),
                ElevatedButton(
                  child: const Text('Close BottomSheet'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: const FluffyAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(36.0)),
        ),
        onPressed: () {
          _showModalBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Transform.scale(
              scale: 1.5,
              child: const Icon(Icons.pets),
            ),
            icon: Badge(
                label: const Text('2'),
                child: Transform.scale(
                  scale: 1.5,
                  child: const Icon(Icons.pets),
                )),
            label: 'Pets',
          ),
          NavigationDestination(
            selectedIcon: Transform.scale(
              scale: 1.5,
              child: const Icon(Icons.home_rounded),
            ),
            icon: Transform.scale(
              scale: 1.5,
              child: const Icon(Icons.home_rounded),
            ),
            label: 'Home',
          ),
        ],
      ),
      body: <Widget>[
        /// Pet page
        const HomePage(),

        /// Home page
        const HomePage(),
      ][currentPageIndex],
    );
  }
}

class FluffyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const FluffyAppBar({super.key})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu), // Replace with your desired icon
        onPressed: () {
          // Action when menu icon is pressed
        },
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              // Action when logout button is pressed
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.blue, backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ), // Button text color
            ),
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.blue, // Text color for logout button
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: () {
            // Action when profile icon is pressed
          },
        ),
      ],
    );
  }
}
