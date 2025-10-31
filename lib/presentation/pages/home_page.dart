import 'package:coop/presentation/components/side_menu.dart';
import 'package:flutter/material.dart';

import '../components/header.dart';
import '../components/my_cards_section.dart';
import '../components/overiview_section.dart';
import '../components/recent_transactions_section.dart';
import '../components/transaction_section_chart.dart';



class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < kDesktopBreakpoint) {
            return const SizedBox(
              width: 250, 
            );
          }
          return const SizedBox.shrink(); 
        },
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= kDesktopBreakpoint) {
              return Row(
                children: [

                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const DashboardHeader(),
                            const SizedBox(height: 24),
                            Text('Good Morning, Google',
                                style:
                                    Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                            const Text(
                                'Here\'s an overview of your financial health and recent activity.',
                                style: TextStyle(color: Color(0xFF718096))),
                            const SizedBox(height: 24),
                            const OverviewSection(),
                            const SizedBox(height: 32),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Expanded(
                                    flex: 3, child: TransactionChartSection()),
                                const SizedBox(width: 24),
                                Expanded(flex: 2, child: MyCardsSection()),
                              ],
                            ),
                            const SizedBox(height: 32),
                            RecentTransactionsSection(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              // Mobile/Tablet Layout (single column scrollable)
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DashboardHeader(
                          onMenuTap: () =>
                              _scaffoldKey.currentState?.openDrawer()),
                      const SizedBox(height: 16),
                      Text('Good Morning, Google',
                          style: Theme.of(context).textTheme.headlineSmall),
                      const Text(
                          'Here\'s an overview of your financial health and recent activity.',
                          style: TextStyle(color: Color(0xFF718096))),
                      const SizedBox(height: 24),
                      const OverviewSection(),
                      const SizedBox(height: 32),
                      const TransactionChartSection(),
                      const SizedBox(height: 32),
                      MyCardsSection(),
                      const SizedBox(height: 32),
                      RecentTransactionsSection(),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
