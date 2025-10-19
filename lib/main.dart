import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'pages/events_page.dart';
import 'pages/tasks_page.dart';
import 'pages/settings_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
		const MyApp({super.key});

		@override
		Widget build(BuildContext context) {
			// iOS26-like color palette
			const Color primary = Color(0xFF0A84FF);
			const Color background = Color(0xFFF6F6F7);
			const Color surface = Colors.white;

			final theme = ThemeData(
				brightness: Brightness.light,
				primaryColor: primary,
				scaffoldBackgroundColor: background,
				canvasColor: surface,
				useMaterial3: true,
				textTheme: const TextTheme(
					headlineLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: Colors.black),
					titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black87),
					bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
				),
				cardTheme: const CardTheme(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16)))),
			);

			return MaterialApp(
				title: 'Gigflow',
				theme: theme,
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
						minimum: const EdgeInsets.only(bottom: 8, left: 12, right: 12),
						child: _buildIosTabBar(context),
					),
				);
		}

			Widget _buildIosTabBar(BuildContext context) {
				// saturated iOS-like colors
					const Color eventsColor = Color(0xFF0A84FF); // blue
					const Color tasksColor = Color(0xFF34C759); // green (phone app)
					const Color settingsColor = Color(0xFFFF9F0A); // orange

					// make the bar lighter/brighter than the page background
					final barColor = const Color.fromRGBO(255, 255, 255, 0.96);

					return ClipRRect(
						borderRadius: BorderRadius.circular(30),
						child: BackdropFilter(
							filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
							child: Container(
								padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
								decoration: BoxDecoration(
									color: barColor,
									borderRadius: BorderRadius.circular(30),
									border: Border.all(color: Colors.white.withAlpha((0.85 * 255).round())),
									boxShadow: [
										BoxShadow(color: Colors.black.withAlpha((0.08 * 255).round()), blurRadius: 18, offset: const Offset(0, 8)),
									],
								),
								child: Row(
									children: List.generate(3, (i) {
										final active = i == _currentIndex;
										IconData icon;
										Color activeColor;
										if (i == 0) {
											icon = CupertinoIcons.calendar;
											activeColor = eventsColor;
										} else if (i == 1) {
											icon = CupertinoIcons.check_mark;
											activeColor = tasksColor;
										} else {
											icon = CupertinoIcons.settings;
											activeColor = settingsColor;
										}


										return Expanded(
											child: GestureDetector(
												behavior: HitTestBehavior.opaque,
												onTap: () => _onTap(i),
												child: Column(
													mainAxisSize: MainAxisSize.min,
													children: [
																				AnimatedContainer(
																					duration: const Duration(milliseconds: 220),
																					curve: Curves.easeOutCubic,
																					padding: const EdgeInsets.all(10),
																					decoration: BoxDecoration(
																						color: active ? activeColor : Colors.grey.shade100,
																						borderRadius: BorderRadius.circular(14),
																						border: active ? null : Border.all(color: Colors.grey.shade300, width: 0.8),
																						// subtle inner shadow when active
																						boxShadow: active
																								? [BoxShadow(color: activeColor.withAlpha((0.18 * 255).round()), blurRadius: 8, offset: const Offset(0, 4))]
																								: null,
																					),
																					child: Icon(
																						icon,
																						size: 30,
																						color: active ? Colors.white : Colors.grey.shade700,
																					),
																				),
													],
												),
											),
										);
									}),
								),
							),
						),
					);
			}
}

