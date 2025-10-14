import 'package:coop/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, 
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 24),
          Row(
            children: [
              Image.asset('assets/coop_logo.png', height: 40),
              const SizedBox(width: 8),
              Text(
                'Coop',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          const Divider(indent: 16, endIndent: 16, height: 16, color: Colors.grey,),
          _buildMenuCategory(context, "Menu"),
          _buildMenuItem(context, Icons.dashboard_rounded, "Dashboard", isSelected: true),
          _buildMenuItem(context, Icons.analytics_rounded, "Analytics"),
          _buildMenuItem(context, Icons.insights_rounded, "Insights"),
          _buildMenuItem(context, Icons.update_rounded, "Updates"),
          const Divider(indent: 16, endIndent: 16, height: 16, color: Colors.grey,),
          _buildMenuCategory(context, "General"),
          _buildMenuItem(context, Icons.settings_rounded, "Settings"),
          _buildMenuItem(context, Icons.help_outline_rounded, "Help Desk"),
          _buildMenuItem(context, Icons.integration_instructions_rounded, "Integration"),
          _buildMenuItem(context, Icons.feedback_rounded, "Feedback"),
          const SizedBox(height: 24),
          // _buildUpgradeProCard(context),
        ],
      ),
    );
  }

  Widget _buildMenuCategory(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, {bool isSelected = false, String? trailingText}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
        ),
        trailing: trailingText != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  trailingText,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              )
            : null,
        onTap: () {
          // Handle menu item tap
          if (MediaQuery.of(context).size.width < kDesktopBreakpoint) {
             Navigator.pop(context); // Close drawer on mobile
          }
        },
      ),
    );
  }

  Widget _buildUpgradeProCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.rocket_launch_rounded, color: Theme.of(context).colorScheme.primary, size: 28),
              GestureDetector(
                onTap: () {
                  // Handle close button tap
                },
                child: Icon(Icons.close, size: 18, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Upgrade Pro!',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 4),
          Text(
            'Higher productivity with better organization',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.primary.withOpacity(0.8)),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Handle upgrade pro tap
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              elevation: 0,
            ),
            child: Text('Upgrade Pro', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}