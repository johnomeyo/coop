import 'package:coop/utils/utils.dart';
import 'package:flutter/material.dart';

class GoalsCard extends StatelessWidget {
  final double targetAmount;
  final double achievedAmount;
  final String month;
  final int year;

  const GoalsCard({
    super.key,
    required this.targetAmount,
    required this.achievedAmount,
    required this.month,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    final progress = targetAmount > 0 ? achievedAmount / targetAmount : 0.0;
    final percent = (progress * 100).clamp(0, 100);
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 300,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Define the internal breakpoint where the layout switches from Row to Column
              const double cardBreakpoint = 450;
              final isWide = constraints.maxWidth > cardBreakpoint;
        
              // Define dynamic chart sizes
              final chartSize = isWide ? 130.0 : 100.0;
              final chartStrokeWidth = isWide ? 16.0 : 12.0;
        
              // Determine progress color (kept from previous iteration for good feedback)
              Color progressColor;
              if (progress >= 1.0) {
                progressColor = colorScheme.primary;
              } else if (progress >= 0.75) {
                progressColor = Colors.teal;
              } else if (progress >= 0.4) {
                progressColor = Colors.orange;
              } else {
                progressColor = Colors.red;
              }
        
              // 1. LEFT SECTION (Stats and Goals)
              final statsSection = Column(
                // Align to the start/left for better readability
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header (Goals + Month/Year)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Goals',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$month, $year',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
        
                  // Target Amount & Edit Icon
                  Row(
                    children: [
                      Text(
                        'KES ${Utils.formatWithCommas(targetAmount)}',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: isWide ? 32 : 28,
                              letterSpacing: 1
                            ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.edit, size: 18, color: Colors.grey.shade500),
                    ],
                  ),
                  const SizedBox(height: 24),
        
                  // Achieved Amount Stat
                  _buildStatRow(
                    context,
                    icon: Icons.emoji_events_rounded,
                    iconColor: Colors.orange.shade700,
                    label: 'Achieved: \$${achievedAmount.toStringAsFixed(0)}',
                  ),
                  const SizedBox(height: 12),
        
                  // Target Goal Stat
                  _buildStatRow(
                    context,
                    icon: Icons.flag_circle_rounded,
                    iconColor: Colors.teal.shade600,
                    label: 'Target Goal: \$${targetAmount.toStringAsFixed(0)}',
                  ),
                ],
              );
        
              // 2. RIGHT SECTION (Circular Chart)
              final chartSection = Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: chartSize,
                          width: chartSize,
                          child: CircularProgressIndicator(
                            value: progress.clamp(0, 1),
                            strokeWidth: chartStrokeWidth,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${percent.toStringAsFixed(0)}%',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isWide ? 22 : 20,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Progress',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Target vs Achievement",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                  ),
                ],
              );
        
              // 3. RESPONSIVE LAYOUT DECISION
              return isWide
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Allow stats section to take necessary space, but ensure it doesn't push the chart out
                        Flexible(child: statsSection),
                        const SizedBox(width: 32),
                        chartSection,
                      ],
                    )
                  : Column(
                      // On narrow screens (mobile), stack them vertically, centering the content
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Chart goes first on mobile for visual impact
                        chartSection,
                        const SizedBox(height: 24),
                        // Align stats section to the left on the mobile column
                        Align(
                          alignment: Alignment.centerLeft,
                          child: statsSection,
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }

  // Helper method for statistics rows, ensuring no text overflow
  Widget _buildStatRow(BuildContext context,
      {required IconData icon, required Color iconColor, required String label}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(width: 10),
        // Use Flexible to prevent text from overflowing the row
        Flexible(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis, // Truncate long text if necessary
          ),
        ),
      ],
    );
  }
}