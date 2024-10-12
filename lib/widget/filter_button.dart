import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UserFilterButton extends StatelessWidget {
  final String currentFilter;
  final Function(String) onFilterChanged;

  const UserFilterButton({
    super.key,
    required this.currentFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(LineAwesomeIcons.filter_solid),
      onSelected: onFilterChanged,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'All',
          child: Text('All'),
        ),
        const PopupMenuItem<String>(
          value: 'visitor',
          child: Text('Visitor'),
        ),
        const PopupMenuItem<String>(
          value: 'admin',
          child: Text('Admin'),
        ),
      ],
    );
  }
}
