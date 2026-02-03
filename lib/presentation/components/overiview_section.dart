import 'package:coop/components/goal_card.dart';
import 'package:coop/components/up_coming_bill_card.dart';
import 'package:coop/constants.dart';
import 'package:flutter/material.dart';

class OverviewSection extends StatelessWidget {
  const OverviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < kTabletBreakpoint;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isMobile)
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
                  achievedAmount: 20000,
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
      ],
    );
  }
}
