import 'package:flutter/material.dart';

class TasksPage extends StatelessWidget {
  static const String title = 'Tasks';

  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // fixed, non-collapsing header
        SliverToBoxAdapter(
          child: Container(
            height: 88,
            color: const Color(0xFFF5F5F7), // light gray header background
            padding: const EdgeInsetsDirectional.only(start: 16.0, bottom: 12.0),
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              ],
            ),
          ),
        ),
        SliverFillRemaining(
          child: Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('InWork', style: TextStyle(fontSize: 24)),
                  SizedBox(height: 8),
                  Text(title, style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
