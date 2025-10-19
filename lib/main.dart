
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/events_page.dart';
import 'pages/tasks_page.dart';
import 'pages/settings_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
			const MyApp({super.key});

			@override
			Widget build(BuildContext context) {
					final base = ThemeData(primarySwatch: Colors.indigo);
					return MaterialApp(
						title: 'Gigflow',
						theme: base.copyWith(
							textTheme: GoogleFonts.quicksandTextTheme(base.textTheme),
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
					bottomNavigationBar: SafeArea(
						child: ClipRRect(
							borderRadius: BorderRadius.circular(16),
							child: BackdropFilter(
								filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
								child: Container(
									color: const Color(0xFFF5F5F7),
									padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
									child: Row(
										mainAxisAlignment: MainAxisAlignment.spaceEvenly,
										children: [
											_iOSIconButton(index: 0, icon: Icons.event, label: EventsPage.title),
											_iOSIconButton(index: 1, icon: Icons.check_box, label: TasksPage.title),
											_iOSIconButton(index: 2, icon: Icons.settings, label: SettingsPage.title),
										],
									),
								),
								),
							),
						),
				);
			}
}

	Widget _iOSIconButton({required int index, required IconData icon, required String label}) {
	  return Builder(builder: (context) {
	    final state = context.findAncestorStateOfType<_HomeShellState>();
	    final isActive = state?._currentIndex == index;
		final activeColor = const Color(0xFF0FA958); // phone-green

			// pill-shaped button (rounded rectangle)
			final double pillHeight = 44;
			final double pillWidth = isActive ? 84 : 56;
				return GestureDetector(
					onTap: () => state?._onTap(index),
					child: AnimatedContainer(
						duration: const Duration(milliseconds: 220),
						curve: Curves.easeInOut,
						width: pillWidth,
						height: pillHeight,
						decoration: BoxDecoration(
							color: isActive ? activeColor : const Color(0xFFF0F0F0),
							borderRadius: BorderRadius.circular(14),
							boxShadow: isActive
									? []
									: [
											BoxShadow(
												color: const Color.fromRGBO(0, 0, 0, 0.04),
												blurRadius: 6,
												offset: const Offset(0, 2),
											),
										],
							border: isActive
									? null
									: Border.all(color: Colors.black12, width: 0.6),
						),
						alignment: Alignment.center,
						child: Icon(
							icon,
							size: 28,
							color: isActive ? Colors.white : Colors.black87,
						),
					),
				);
	  });
	}

