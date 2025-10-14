import 'package:coop/components/goal_card.dart';
import 'package:coop/components/up_coming_bill_card.dart';
import 'package:coop/constants.dart';
import 'package:flutter/material.dart';
import '../pages/home_page.dart';

class OverviewSection extends StatelessWidget {
  const OverviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < kTabletBreakpoint;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Responsive layout for cards
        if (isMobile)
          // 📱 On mobile → show in a column
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GoalsCard(
                targetAmount: 20000,
                achievedAmount: 12500,
                month: 'May',
                year: 2023,
              ),
              const SizedBox(height: 16),
              UpcomingBillsCard(
                bills: [
                  BillModel(
                    month: "May",
                    day: 15,
                    title: "Figma",
                    description: "Figma - Monthly",
                    lastChargeDate: "14 May, 2022",
                    amount: 150,
                  ),
                  BillModel(
                    month: "Jun",
                    day: 16,
                    title: "Adobe",
                    description: "Adobe - Yearly",
                    lastChargeDate: "17 Jun, 2023",
                    amount: 559,
                    logo:
                        "https://img.icons8.com/?size=100&id=W0YEwBDDfTeu&format=png&color=000000",
                  ),
                ],
              ),
            ],
          )
        else
          // 💻 On large screens → show side by side
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: GoalsCard(
                  targetAmount: 20000,
                  achievedAmount: 12500,
                  month: 'May',
                  year: 2023,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: UpcomingBillsCard(
                  bills: bills,
                ),
              ),
            ],
          ),

        const SizedBox(height: 24),

        // Dropdown and Export button
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: "This Month",
                    items: <String>["This Month", "Last Month", "This Year"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: Theme.of(context).textTheme.bodyMedium),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {},
                    icon: Icon(Icons.keyboard_arrow_down_rounded,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6)),
                    style: Theme.of(context).textTheme.bodyMedium,
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).cardColor,
                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                  side: BorderSide(color: Colors.grey.shade200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                icon: const Icon(Icons.download_rounded, size: 20),
                label: Text('Export',
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
