import 'package:coop/presentation/pages/bills_page.dart';
import 'package:flutter/material.dart';

// --- Bill Model (Kept for completeness) ---
class BillModel {
  final String month;
  final int day;
  final String title;
  final String description;
  final String lastChargeDate;
  final double amount;
  final String? logo;

  BillModel({
    required this.month,
    required this.day,
    required this.title,
    required this.description,
    required this.lastChargeDate,
    required this.amount,
    this.logo,
  });
}
// ----------------------------------------

class UpcomingBillsCard extends StatelessWidget {
  final List<BillModel> bills;

  const UpcomingBillsCard({super.key, required this.bills});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20), // Slightly increased padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Essential for tight Column
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Upcoming Bills",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const BillsPage()),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 20),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "View All",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          size: 12, color: colorScheme.primary)
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),

            // Bills List / Empty State
            if (bills.isEmpty)
              _buildEmptyState(context)
            else
              // Use ListView.separated for clean list dividers and controlled height
              // Since this card will likely sit in a column/list, we must use shrinkWrap and physics
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: bills.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _buildBillItem(context, bills[index]);
                },
              ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widget for an empty state ---
  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(Icons.inbox_rounded,
              size: 40,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.6)),
          const SizedBox(height: 12),
          Text(
            "All clear!",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            "No upcoming bills scheduled.",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  // --- Helper Widget for individual Bill item ---
  Widget _buildBillItem(BuildContext context, BillModel bill) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor, // Use cardColor for item background
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Date
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withOpacity(0.05), // Primary color highlight
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  bill.month,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  bill.day.toString(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16), // Increased spacing

          // Bill details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Handle bill logo display
                    if (bill.logo != null) ...[
                      // Assuming bill.logo is a network or local asset path that works with Image.network/asset
                      Image.network(bill.logo!,
                          width: 20,
                          height: 20,
                          errorBuilder: (context, error, stackTrace) =>
                              const SizedBox.shrink()),
                      const SizedBox(width: 6),
                    ],
                    // Use Flexible to prevent the title from pushing the Row out
                    Flexible(
                      child: Text(
                        bill.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  bill.description,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey.shade600),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "Last Charge: ${bill.lastChargeDate}",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: Colors.grey.shade500),
                ),
              ],
            ),
          ),

          // Price
          const SizedBox(width: 12),
          Text(
            "\$${bill.amount.toStringAsFixed(2)}", // Ensure currency format is correct
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context)
                      .colorScheme
                      .error, // Use error color to highlight cost
                ),
          ),
        ],
      ),
    );
  }
}
