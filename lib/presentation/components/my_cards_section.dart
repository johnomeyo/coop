// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:coop/constants.dart'; 


// // Define a constant for the maximum number of items to show
// const int kMaxActivitiesToShow = 5;


// class MyCardsSection extends StatelessWidget {
//   const MyCardsSection({super.key});

//   double parsePrice(String priceStr) {
//     // Safely handles both $XX,XXX and $XXX strings
//     final cleanPrice = priceStr.replaceAll(RegExp(r'[$,]'), '');
//     return double.tryParse(cleanPrice) ?? 0.0;
//   }

//   // New function to process and filter data
//   Map<String, double> _getTopActivities(Map<String, double> totals) {
//     // 1. Convert the map entries to a list
//     final sortedEntries = totals.entries.toList()
//       // 2. Sort the list by value (amount) in descending order
//       ..sort((a, b) => b.value.compareTo(a.value));
    
//     // 3. Take the top N (kMaxActivitiesToShow) entries
//     final topEntries = sortedEntries.take(kMaxActivitiesToShow);

//     // 4. Calculate the total of all remaining entries (if any)
//     double othersTotal = 0.0;
//     if (sortedEntries.length > kMaxActivitiesToShow) {
//       final otherEntries = sortedEntries.skip(kMaxActivitiesToShow);
//       othersTotal = otherEntries.fold(0.0, (sum, entry) => sum + entry.value);
//     }

//     // 5. Build the final map
//     final finalMap = {for (var entry in topEntries) entry.key: entry.value};
    
//     // 6. Add 'Others' entry if there were more than kMaxActivitiesToShow items
//     if (othersTotal > 0) {
//       finalMap['Others'] = othersTotal;
//     }

//     return finalMap;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // 1. Aggregate all totals first
//     final Map<String, double> activityTotals = {};
//     for (final tx in transactionData) {
//       final activity = tx['activity'] as String;
//       // Note: This logic aggregates ALL transactions, regardless of 'status'.
//       // If you only wanted to show 'Sale' transactions, you'd add a filter here.
//       final price = parsePrice(tx['price'].toString());
//       activityTotals.update(activity, (value) => value + price, ifAbsent: () => price);
//     }
    
//     // 2. Filter and sum the 'Others' group
//     final topActivitiesMap = _getTopActivities(activityTotals);


//     // Prepare pie chart sections
//     final List<PieChartSectionData> pieSections = [];
//     final colors = [
//       Theme.of(context).colorScheme.primary,
//       Theme.of(context).colorScheme.secondary,
//       Colors.green,
//       Colors.orange,
//       Colors.purple,
//       Colors.teal,
//       Colors.pink,
//       Colors.indigo,
//     ];
//     int colorIndex = 0;
    
//     // Iterate over the filtered map (topActivitiesMap)
//     topActivitiesMap.forEach((activity, amount) {
//       pieSections.add(
//         PieChartSectionData(
//           value: amount,
//           title: '', 
//           color: colors[colorIndex % colors.length],
//           radius: 100,
//           titleStyle: const TextStyle(
//             fontSize: 12,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       );
//       colorIndex++;
//     });

//     // ... (Rest of the build method uses topActivitiesMap for the legend)

//     return Card(
//       elevation: 0,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               blurRadius: 10,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: 200, 
//                 child: PieChart(
//                   PieChartData(
//                     sections: pieSections,
//                     centerSpaceRadius: 40,
//                     sectionsSpace: 2,
//                     pieTouchData: PieTouchData(
//                       touchCallback: (FlTouchEvent event, pieTouchResponse) {
//                         // Handle touch interactions if needed
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               // Legend: Iterate over the filtered map (topActivitiesMap)
//               Wrap(
//                 spacing: 8,
//                 runSpacing: 8,
//                 children: topActivitiesMap.keys.map((activity) { // <-- Use topActivitiesMap
//                   final index = topActivitiesMap.keys.toList().indexOf(activity);
//                   return Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         width: 12,
//                         height: 12,
//                         decoration: BoxDecoration(
//                           color: colors[index % colors.length],
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       const SizedBox(width: 4),
//                       Flexible(
//                         child: Text(
//                           activity,
//                           style: Theme.of(context).textTheme.bodySmall,
//                         ),
//                       ),
//                     ],
//                   );
//                 }).toList(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }