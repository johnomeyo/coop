import 'package:coop/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class RecentTransactionsSection extends StatelessWidget {
  RecentTransactionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < kTabletBreakpoint;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Transaction',
                    style: Theme.of(context).textTheme.titleLarge),
                Row(
                  children: [
                    Container(
                      width: 250,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: const Color(0xFFA0AEC0)),
                          prefixIcon: const Icon(Icons.search,
                              size: 20, color: Color(0xFF718096)),
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    _buildFilterDropdown(context, "All Category"),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_alt_outlined, size: 20),
                      label: Text('Filter',
                          style: Theme.of(context).textTheme.bodyMedium),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).cardColor,
                        foregroundColor:
                            Theme.of(context).colorScheme.onSurface,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                        side: BorderSide(color: Colors.grey.shade200),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            isMobile
                ? _buildMobileTransactionList(context)
                : _buildDesktopTransactionTable(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterDropdown(BuildContext context, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: <String>["All Category", "Shopping", "Food", "Travel"]
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
            );
          }).toList(),
          onChanged: (String? newValue) {
            // Handle dropdown change
          },
          icon: Icon(Icons.keyboard_arrow_down_rounded,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
          style: Theme.of(context).textTheme.bodyMedium,
          isDense: true,
        ),
      ),
    );
  }

  Widget _buildDesktopTransactionTable(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final columnWidth = constraints.maxWidth / 6;

            return Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
                dividerTheme: const DividerThemeData(
                  color: Colors.transparent,
                  space: 0,
                  thickness: 0,
                  indent: 0,
                  endIndent: 0,
                ),
              ),
              child: DataTable(
                showCheckboxColumn: false,
                columnSpacing: 0,
                dataRowMaxHeight: 60,
                headingRowHeight: 50,
                horizontalMargin: 0,
                columns: [
                  DataColumn(
                      label: SizedBox(
                          width: columnWidth,
                          child: Text('Title',
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(fontWeight: FontWeight.bold,color: const Color(0xFF718096))))),
                  DataColumn(
                      label: SizedBox(
                          width: columnWidth,
                          child: Text('Order ID',
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(fontWeight: FontWeight.bold,color: const Color(0xFF718096))))),
                  DataColumn(
                      label: SizedBox(
                          width: columnWidth,
                          child: Text('Date',
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(fontWeight: FontWeight.bold,color: const Color(0xFF718096))))),
                  DataColumn(
                      label: SizedBox(
                          width: columnWidth,
                          child: Text('Time',
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(fontWeight: FontWeight.bold,color: const Color(0xFF718096))))),
                  DataColumn(
                      label: SizedBox(
                          width: columnWidth,
                          child: Text('Amount',
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(fontWeight: FontWeight.bold,color: const Color(0xFF718096))))),
                  DataColumn(
                      label: SizedBox(
                          width: columnWidth,
                          child: Text('Status',
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(fontWeight: FontWeight.bold,color: const Color(0xFF718096))))),
                ],
                rows: List.generate(
                  _transactionData.length,
                  (index) => _buildTransactionDataRow(
                      context, _transactionData[index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  DataRow _buildTransactionDataRow(
      BuildContext context, Map<String, dynamic> data) {
    Color statusColor;
    Color statusBgColor;
    IconData statusIcon;

    switch (data['status']) {
      case 'Success':
        statusColor = const Color(0xFF53C79A); // Green
        statusBgColor = const Color(0xFF53C79A).withOpacity(0.1);
        statusIcon = Icons.check_circle_outline_rounded;
        break;
      case 'Pending':
        statusColor = const Color(0xFFF6AD55); // Orange
        statusBgColor = const Color(0xFFF6AD55).withOpacity(0.1);
        statusIcon = Icons.pending_actions_rounded;
        break;
      default:
        statusColor = Colors.grey;
        statusBgColor = Colors.grey.withOpacity(0.1);
        statusIcon = Icons.info_outline;
    }

    return DataRow(
      cells: [
        DataCell(Text(data['activity'],
            style: Theme.of(context).textTheme.bodyMedium)),
        DataCell(Text(data['orderId'],
            style: Theme.of(context).textTheme.bodyMedium)),
        DataCell(
            Text(data['date'], style: Theme.of(context).textTheme.bodyMedium)),
        DataCell(
            Text(data['time'], style: Theme.of(context).textTheme.bodyMedium)),
        DataCell(Text(data['price'],
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600))),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: statusBgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(statusIcon, size: 16, color: statusColor),
                const SizedBox(width: 4),
                Text(
                  data['status'],
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: statusColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileTransactionList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _transactionData.length,
      itemBuilder: (context, index) {
        final data = _transactionData[index];
        Color statusColor;
        Color statusBgColor;
        IconData statusIcon;

        switch (data['status']) {
          case 'Success':
            statusColor = const Color(0xFF53C79A); // Green
            statusBgColor = const Color(0xFF53C79A).withOpacity(0.1);
            statusIcon = Icons.check_circle_outline_rounded;
            break;
          case 'Pending':
            statusColor = const Color(0xFFF6AD55); // Orange
            statusBgColor = const Color(0xFFF6AD55).withOpacity(0.1);
            statusIcon = Icons.pending_actions_rounded;
            break;
          default:
            statusColor = Colors.grey;
            statusBgColor = Colors.grey.withOpacity(0.1);
            statusIcon = Icons.info_outline;
        }

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 0.5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(data['activity'],
                        style: Theme.of(context).textTheme.titleMedium),
                    Text(data['price'],
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Order ID: ${data['orderId']}',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: const Color(0xFF718096))),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: statusBgColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(statusIcon, size: 16, color: statusColor),
                          const SizedBox(width: 4),
                          Text(
                            data['status'],
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                    color: statusColor,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text('${data['date']} - ${data['time']}',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: const Color(0xFF718096))),
              ],
            ),
          ),
        );
      },
    );
  }

  final List<Map<String, dynamic>> _transactionData = [
    {
      'activity': 'Hotel Booking',
      'orderId': 'INV_000078',
      'date': '17 Apr, 2026',
      'time': '03:45 PM',
      'price': '\$25,500',
      'status': 'Success'
    },
    {
      'activity': 'Flight Ticket Booking',
      'orderId': 'INV_000076',
      'date': '17 Apr, 2026',
      'time': '03:45 PM',
      'price': '\$3,500',
      'status': 'Pending'
    },
    {
      'activity': 'App Subscription',
      'orderId': 'INV_000075',
      'date': '17 Apr, 2026',
      'time': '03:45 PM',
      'price': '\$150',
      'status': 'Success'
    },
    {
      'activity': 'Online Course',
      'orderId': 'INV_000074',
      'date': '17 Apr, 2026',
      'time': '03:45 PM',
      'price': '\$2,500',
      'status': 'Success'
    },
    {
      'activity': 'Grocery Shopping',
      'orderId': 'INV_000073',
      'date': '17 Apr, 2026',
      'time': '03:45 PM',
      'price': '\$320',
      'status': 'Pending'
    },
  ];
}
