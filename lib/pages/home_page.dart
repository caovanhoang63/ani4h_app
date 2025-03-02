import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class OptionA extends StatelessWidget {
  const OptionA({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Option A', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    );
  }
}
class OptionB extends StatelessWidget {
  const OptionB({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min, // Keeps Column centered vertically
        children: [
          Text('Option B', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/firstpage");
            },
            child: Text('To first page'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              print("Button 2 in Option B pressed");
            },
            child: Text('Button 2'),
          ),
        ],
      ),
    );
  }
}
class OptionC extends StatelessWidget {
  const OptionC({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min, // Keeps Column centered vertically
        children: [
          Text('Option C', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              print("Button 1 in Option C pressed");
            },
            child: Text('Button 1'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              print("Button 2 in Option C pressed");
            },
            child: Text('Button 2'),
          ),
        ],
      ),
    );
  }
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static final List<Widget> _pages = <Widget>[
    OptionA(),
    OptionB(),
    OptionC(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Title"),
        leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: const Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Option A'),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Option B'),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Option C'),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}