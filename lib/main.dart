
import 'package:flutter/material.dart';
import 'pages/events_page.dart';
import 'pages/tasks_page.dart';
import 'pages/settings_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
			const MyApp({super.key});

			@override
			Widget build(BuildContext context) {
				return MaterialApp(
					title: 'Gigflow',
					theme: ThemeData(
						primarySwatch: Colors.indigo,
					),
					home: const HomeShell(),
				);
			}
}

class HomeShell extends StatefulWidget {
	const HomeShell({super.key});

	@override
	State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
	int _currentIndex = 0;

	final List<Widget> _pages = const [
		EventsPage(),
		TasksPage(),
		SettingsPage(),
	];

	void _onTap(int index) {
		setState(() => _currentIndex = index);
	}

			@override
			Widget build(BuildContext context) {
				return Scaffold(
					body: IndexedStack(
						index: _currentIndex,
						children: _pages,
					),
					bottomNavigationBar: BottomNavigationBar(
						currentIndex: _currentIndex,
						onTap: _onTap,
						items: const [
							BottomNavigationBarItem(icon: Icon(Icons.event), label: EventsPage.title),
							BottomNavigationBarItem(icon: Icon(Icons.check_box), label: TasksPage.title),
							BottomNavigationBarItem(icon: Icon(Icons.settings), label: SettingsPage.title),
						],
					),
				);
			}
}

