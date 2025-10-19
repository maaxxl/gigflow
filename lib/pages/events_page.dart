import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  static const String title = 'Events';

  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 120,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(title),
          ),
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
        ),
        SliverFillRemaining(
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
      ],
    );
  }
}
