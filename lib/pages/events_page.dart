import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  static const String title = 'Events';

  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          backgroundColor: theme.canvasColor,
          elevation: 0,
          expandedHeight: 140,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsetsDirectional.only(start: 16, bottom: 16, end: 16),
            title: Align(
              alignment: Alignment.centerLeft,
              child: Text(title, style: theme.textTheme.headlineLarge),
            ),
            collapseMode: CollapseMode.pin,
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
          ],
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
