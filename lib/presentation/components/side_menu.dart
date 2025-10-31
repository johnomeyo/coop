import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final int currentIndex;
  final Function(int) onPageSelected;

  const SideMenu({
    super.key,
    required this.currentIndex,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {"icon": Icons.home, "title": "Dashboard"},
      {"icon": Icons.analytics_rounded, "title": "Goals"},
      {"icon": Icons.update_rounded, "title": "Bills"},
      {"icon": Icons.settings_rounded, "title": "Settings"},
    ];

    return Container(
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        children: [
          Row(
            children: [
              const SizedBox(width: 16),
              Image.asset('assets/coop_logo.png', height: 40),
              const SizedBox(width: 8),
              Text(
                'Coop',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(indent: 16, endIndent: 16),
          ...List.generate(menuItems.length, (index) {
            final item = menuItems[index];
            final bool isSelected = currentIndex == index;

            return InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => onPageSelected(index),
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(item["icon"] as IconData,
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey[700]),
                    const SizedBox(width: 12),
                    Text(
                      item["title"] as String,
                      style: TextStyle(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey[800],
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
