import 'package:flutter/material.dart';
import '../widgets/large_title_delegate.dart';

class SettingsPage extends StatelessWidget {
  static const String title = 'Settings';

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: LargeTitleDelegate(title: title, maxHeight: 70, action: IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))),
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
