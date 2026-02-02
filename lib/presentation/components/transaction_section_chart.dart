import 'package:coop/constants.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class TransactionChartSection extends StatefulWidget {
  const TransactionChartSection({super.key});

  @override
  State<TransactionChartSection> createState() => _TransactionChartSectionState();
}

class _TransactionChartSectionState extends State<TransactionChartSection> {
  bool _isMonthly = true;

  Map<String, Map<String, double>> _aggregateTransactions(bool isMonthly) {
    final Map<String, Map<String, double>> aggregated = {};

    final sortedData = List<Map<String, dynamic>>.from(transactionData);
    sortedData.sort((a, b) {
      final dateA = DateFormat('d MMM, yyyy').parse(a['date']);
      final dateB = DateFormat('d MMM, yyyy').parse(b['date']);
      return dateA.compareTo(dateB);
    });

    for (var transaction in sortedData) {
      final date = DateFormat('d MMM, yyyy').parse(transaction['date']);
      final key = isMonthly
          ? DateFormat('MMM').format(date) 
          : DateFormat('yyyy').format(date);

      if (!aggregated.containsKey(key)) {
        aggregated[key] = {'Sale': 0.0, 'Expense': 0.0};
      }

      final status = transaction['status'];
      aggregated[key]![status] = (aggregated[key]![status] ?? 0.0) + (transaction['price'] as num).toDouble();
    }

    return aggregated;
  }

  List<BarChartGroupData> _buildGroupedBarData(
      Map<String, Map<String, double>> aggregatedData,
      List<String> labels,
      bool isMobile,
      ColorScheme colorScheme) {
    const double barWidth = 20;

    return List.generate(
      labels.length,
      (index) {
        final label = labels[index];
        final sales = aggregatedData[label]!['Sale'] ?? 0;
        final expenses = aggregatedData[label]!['Expense'] ?? 0;

        return BarChartGroupData(
          x: index,
          barRods: [
            // Sale Bar Rod
            BarChartRodData(
              toY: sales,
              color: colorScheme.primary,
              width: barWidth,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(0)),
            ),
            // Expense Bar Rod
            BarChartRodData(
              toY: expenses,
              color: colorScheme.primary.withValues(alpha: 0.3),
              width: barWidth,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(0)),
            ),
          ],
          barsSpace: 0,
          groupVertically: false,
          showingTooltipIndicators: [],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final colorScheme = Theme.of(context).colorScheme;

    final aggregatedData = _aggregateTransactions(_isMonthly);
    final labels = aggregatedData.keys.toList();

    double maxValue = 0;
    for (var data in aggregatedData.values) {
      final maxOfGroup = (data['Sale'] ?? 0) > (data['Expense'] ?? 0) ? (data['Sale'] ?? 0) : (data['Expense'] ?? 0);
      if (maxOfGroup > maxValue) maxValue = maxOfGroup;
    }

    final totalSales = transactionData
        .where((t) => t['status'] == 'Sale')
        .fold<double>(0, (sum, t) => sum + (t['price'] as num).toDouble());
    final totalExpenses = transactionData
        .where((t) => t['status'] == 'Expense')
        .fold<double>(0, (sum, t) => sum + (t['price'] as num).toDouble());
    final percentageChange =
        totalSales > 0 ? ((totalSales - totalExpenses) / totalSales * 100) : 0;

    return Card(
      // elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Analytics', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_upward_rounded, size: 16, color: colorScheme.primary),
                      Text(
                        '${percentageChange.toStringAsFixed(1)}%',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colorScheme.primary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _buildChip(context, "Monthly", _isMonthly),
                    const SizedBox(width: 8),
                    _buildChip(context, "Yearly", !_isMonthly),
                  ],
                ),
                Row(
                  children: [
                    Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(color: colorScheme.primary, shape: BoxShape.circle)),
                    const SizedBox(width: 4),
                    Text('Sales', style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(width: 12),
                    Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(color: colorScheme.primary.withValues(alpha: 0.3), shape: BoxShape.circle)),
                    const SizedBox(width: 4),
                    Text('Expenses', style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Bar Chart
            AspectRatio(
              aspectRatio: isMobile ? 1.2 : 2.2,
              child: labels.isEmpty
                  ? Center(
                      child: Text(
                        'No transaction data available',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade500),
                      ),
                    )
                  : BarChart(
                      BarChartData(
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            fitInsideHorizontally: true,
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              final label = labels[group.x];
                              final status = rodIndex == 0 ? 'Sales' : 'Expenses';
                              final amount = rod.toY;
                              return BarTooltipItem(
                                '$label\n',
                                const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '$status: \$${amount.toStringAsFixed(0)}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        barGroups: _buildGroupedBarData(
                            aggregatedData, labels, isMobile, colorScheme),
                        maxY: maxValue * 1.1,
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: maxValue > 0 ? maxValue / 5 : 1000,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  '\$${(value / 1000).toStringAsFixed(0)}k',
                                  style: Theme.of(context).textTheme.bodySmall,
                                );
                              },
                              reservedSize: isMobile ? 40 : 50,
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final index = value.toInt();
                                if (index >= 0 && index < labels.length) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      labels[index],
                                      style: Theme.of(context).textTheme.bodySmall,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }
                                return const SizedBox();
                              },
                              reservedSize: isMobile ? 40 : 50,
                            ),
                          ),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        gridData: FlGridData(
                          show: true,
                          drawHorizontalLine: true,
                          drawVerticalLine: false,
                          horizontalInterval: maxValue > 0 ? maxValue / 5 : 1000,
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color: Colors.grey.shade200,
                              strokeWidth: 1,
                            );
                          },
                        ),
                        borderData: FlBorderData(show: false),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(BuildContext context, String text, bool isSelected) {
    return ChoiceChip(
      label: Text(text),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _isMonthly = text == "Monthly";
        });
      },
      selectedColor: Theme.of(context).colorScheme.primary,
      backgroundColor: Colors.grey.shade200,
      labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isSelected
                ? Colors.white
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}