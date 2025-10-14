import 'package:coop/components/up_coming_bill_card.dart';

final List<Map<String, dynamic>> transactionData = [
  // January
  {
    'activity': 'Product Sales',
    'orderId': 'INV_000101',
    'date': '12 Jan, 2026',
    'time': '10:20 AM',
    'price': 18400,
    'status': 'Sale'
  },
  {
    'activity': 'Office Rent',
    'orderId': 'EXP_000201',
    'date': '05 Jan, 2026',
    'time': '08:45 AM',
    'price': 25000,
    'status': 'Expense'
  },

  // February
  {
    'activity': 'Service Payment (Consultation)',
    'orderId': 'INV_000102',
    'date': '14 Feb, 2026',
    'time': '01:30 PM',
    'price': 12000,
    'status': 'Sale'
  },
  {
    'activity': 'Utility Bills (Electricity)',
    'orderId': 'EXP_000202',
    'date': '18 Feb, 2026',
    'time': '09:15 AM',
    'price': 3400,
    'status': 'Expense'
  },

  // March
  {
    'activity': 'Software License Renewal',
    'orderId': 'EXP_000203',
    'date': '06 Mar, 2026',
    'time': '11:00 AM',
    'price': 5600,
    'status': 'Expense'
  },
  {
    'activity': 'Client Payment (Web Design)',
    'orderId': 'INV_000103',
    'date': '20 Mar, 2026',
    'time': '04:45 PM',
    'price': 24000,
    'status': 'Sale'
  },

  // April
  {
    'activity': 'Online Course Purchase',
    'orderId': 'EXP_000204',
    'date': '09 Apr, 2026',
    'time': '07:15 PM',
    'price': 3200,
    'status': 'Expense'
  },
  {
    'activity': 'Freelance Project Payment',
    'orderId': 'INV_000104',
    'date': '28 Apr, 2026',
    'time': '03:20 PM',
    'price': 27000,
    'status': 'Sale'
  },

  // May
  {
    'activity': 'Equipment Purchase',
    'orderId': 'EXP_000205',
    'date': '10 May, 2026',
    'time': '11:40 AM',
    'price': 14500,
    'status': 'Expense'
  },
  {
    'activity': 'Product Sales',
    'orderId': 'INV_000105',
    'date': '23 May, 2026',
    'time': '02:10 PM',
    'price': 21500,
    'status': 'Sale'
  },

  // June
  {
    'activity': 'Employee Salary',
    'orderId': 'EXP_000206',
    'date': '30 Jun, 2026',
    'time': '09:00 AM',
    'price': 50000,
    'status': 'Expense'
  },
  {
    'activity': 'Service Income (Maintenance)',
    'orderId': 'INV_000106',
    'date': '19 Jun, 2026',
    'time': '05:30 PM',
    'price': 16500,
    'status': 'Sale'
  },

  // July
  {
    'activity': 'Advertising (Social Media)',
    'orderId': 'EXP_000207',
    'date': '11 Jul, 2026',
    'time': '01:45 PM',
    'price': 7800,
    'status': 'Expense'
  },
  {
    'activity': 'Client Payment (Graphics Design)',
    'orderId': 'INV_000107',
    'date': '25 Jul, 2026',
    'time': '11:10 AM',
    'price': 9400,
    'status': 'Sale'
  },

  // August
  {
    'activity': 'Office Supplies',
    'orderId': 'EXP_000208',
    'date': '07 Aug, 2026',
    'time': '10:30 AM',
    'price': 4200,
    'status': 'Expense'
  },
  {
    'activity': 'Service Payment (Consultation)',
    'orderId': 'INV_000108',
    'date': '21 Aug, 2026',
    'time': '03:00 PM',
    'price': 18000,
    'status': 'Sale'
  },

  // September
  {
    'activity': 'Transport and Logistics',
    'orderId': 'EXP_000209',
    'date': '09 Sep, 2026',
    'time': '04:10 PM',
    'price': 6100,
    'status': 'Expense'
  },
  {
    'activity': 'Product Sales',
    'orderId': 'INV_000109',
    'date': '18 Sep, 2026',
    'time': '12:25 PM',
    'price': 32000,
    'status': 'Sale'
  },

  // October
  {
    'activity': 'Equipment Maintenance',
    'orderId': 'EXP_000210',
    'date': '05 Oct, 2026',
    'time': '10:00 AM',
    'price': 7400,
    'status': 'Expense'
  },
  {
    'activity': 'Service Income (Software Setup)',
    'orderId': 'INV_000110',
    'date': '27 Oct, 2026',
    'time': '06:15 PM',
    'price': 26500,
    'status': 'Sale'
  },

  // November
  {
    'activity': 'Office Internet Subscription',
    'orderId': 'EXP_000211',
    'date': '10 Nov, 2026',
    'time': '09:40 AM',
    'price': 6500,
    'status': 'Expense'
  },
  {
    'activity': 'Training Income (Workshop)',
    'orderId': 'INV_000111',
    'date': '19 Nov, 2026',
    'time': '01:35 PM',
    'price': 12800,
    'status': 'Sale'
  },

  // December
  {
    'activity': 'End of Year Staff Party',
    'orderId': 'EXP_000212',
    'date': '22 Dec, 2026',
    'time': '07:00 PM',
    'price': 28500,
    'status': 'Expense'
  },
  {
    'activity': 'Product Sales (Holiday Offer)',
    'orderId': 'INV_000112',
    'date': '18 Dec, 2026',
    'time': '02:50 PM',
    'price': 35600,
    'status': 'Sale'
  },
];

 final List<BillModel> bills = [
  // BillModel(
  //     month: "May",
  //     day: 15,
  //     title: "Netflix",
  //     description: "Figma - Monthly",
  //     lastChargeDate: "14 May, 2022",
  //     amount: 150,
  //     logo:
  //         "https://img.icons8.com/?size=100&id=VZLXV08EcZsm&format=png&color=000000"),
  // BillModel(
  //   month: "Jun",
  //   day: 16,
  //   title: "Adobe",
  //   description: "Adobe - Yearly",
  //   lastChargeDate: "17 Jun, 2023",
  //   amount: 559,
  //   logo:
  //       "https://img.icons8.com/?size=100&id=W0YEwBDDfTeu&format=png&color=000000",
  // ),
  // BillModel(
  //   month: "Jun",
  //   day: 16,
  //   title: "Adobe",
  //   description: "Adobe - Yearly",
  //   lastChargeDate: "17 Jun, 2023",
  //   amount: 559,
  //   logo:
  //       "https://img.icons8.com/?size=100&id=gav46YArUSy1&format=png&color=000000",
  // )
];
