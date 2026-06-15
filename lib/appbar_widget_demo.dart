import 'package:flutter/material.dart';

class AppBarWidgetDemo extends StatefulWidget {
  const AppBarWidgetDemo({
    super.key,
    required this.isDarkMode,
    required this.onDarkModeChanged,
  });

  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeChanged;

  @override
  State<AppBarWidgetDemo> createState() => _AppBarWidgetDemoState();
}

class _AppBarWidgetDemoState extends State<AppBarWidgetDemo> {
  static const _titles = ['My Tasks', 'Team Sprint', 'Weekend Errands'];

  int _titleIndex = 0;
  Color _barColor = Colors.deepPurple;
  bool _centerTitle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: Text(_titles[_titleIndex]),
        centerTitle: _centerTitle,
        backgroundColor: _barColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Text('Body content shows here'),
            ),
          ),
          const Divider(height: 1),
          _AttributePanel(
            titleIndex: _titleIndex,
            titles: _titles,
            barColor: _barColor,
            centerTitle: _centerTitle,
            isDarkMode: widget.isDarkMode,
            onTitleChanged: (index) => setState(() => _titleIndex = index),
            onColorChanged: (color) => setState(() => _barColor = color),
            onCenterTitleChanged: (value) =>
                setState(() => _centerTitle = value),
            onDarkModeChanged: widget.onDarkModeChanged,
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: _barColor,
      //   onPressed: () {},
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

class _AttributePanel extends StatelessWidget {
  const _AttributePanel({
    required this.titleIndex,
    required this.titles,
    required this.barColor,
    required this.centerTitle,
    required this.isDarkMode,
    required this.onTitleChanged,
    required this.onColorChanged,
    required this.onCenterTitleChanged,
    required this.onDarkModeChanged,
  });

  final int titleIndex;
  final List<String> titles;
  final Color barColor;
  final bool centerTitle;
  final bool isDarkMode;
  final ValueChanged<int> onTitleChanged;
  final ValueChanged<Color> onColorChanged;
  final ValueChanged<bool> onCenterTitleChanged;
  final ValueChanged<bool> onDarkModeChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AppBar attributes (live demo)',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 12),
            Text('title', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 6),
            SegmentedButton<int>(
              segments: [
                for (var i = 0; i < titles.length; i++)
                  ButtonSegment(value: i, label: Text('${i + 1}')),
              ],
              selected: {titleIndex},
              onSelectionChanged: (selection) =>
                  onTitleChanged(selection.first),
            ),
            const SizedBox(height: 12),
            Text(
              'backgroundColor',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              children: [
                _ColorChip(
                  color: Colors.deepPurple,
                  selected: barColor == Colors.deepPurple,
                  onTap: () => onColorChanged(Colors.deepPurple),
                ),
                _ColorChip(
                  color: Colors.teal,
                  selected: barColor == Colors.teal,
                  onTap: () => onColorChanged(Colors.teal),
                ),
                _ColorChip(
                  color: Colors.orange,
                  selected: barColor == Colors.orange,
                  onTap: () => onColorChanged(Colors.orange),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('centerTitle'),
              subtitle: const Text(
                'When true, the title is centered in the toolbar.',
              ),
              value: centerTitle,
              onChanged: onCenterTitleChanged,
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Dark Mode'),
              subtitle: const Text('Remembered next time you open the app.'),
              value: isDarkMode,
              onChanged: onDarkModeChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorChip extends StatelessWidget {
  const _ColorChip({
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(_colorName(color)),
      selected: selected,
      onSelected: (_) => onTap(),
      avatar: CircleAvatar(backgroundColor: color, radius: 10),
    );
  }

  String _colorName(Color color) {
    if (color == Colors.deepPurple) return 'Purple';
    if (color == Colors.teal) return 'Teal';
    return 'Orange';
  }
}
