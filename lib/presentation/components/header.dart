import 'package:flutter/material.dart';

const double kDesktopBreakpoint = 900;
const double kTabletBreakpoint = 600;

class DashboardHeader extends StatelessWidget {
  final VoidCallback? onMenuTap;
  const DashboardHeader({super.key, this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop =
        MediaQuery.of(context).size.width >= kDesktopBreakpoint;

    return Container(
      padding:
          EdgeInsets.symmetric(vertical: 16, horizontal: isDesktop ? 0 : 8),
      child: Row(
        children: [
          if (!isDesktop)
            IconButton(
              icon: const Icon(Icons.menu, color: Color(0xFF2D3748)),
              onPressed: onMenuTap,
            ),
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFE2E8F0),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search anything...',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFFA0AEC0),
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF718096),
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 13.0),
                ),
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF2D3748),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          FilledButton(
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: const Text(
                'Send Prompt',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
