import 'package:flutter/material.dart';
<<<<<<< HEAD

import 'order_success_screen.dart';

/// Same brown family as rest of the app (buttons, accents).
const Color _kAppBrown = Color(0xFF6D4C41);

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({super.key});

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  int selectedStep = 0;

  /// Moment user opened this screen — timeline dates/times derive from [DateTime] here.
  late final DateTime _openedAt;

  @override
  void initState() {
    super.initState();
    _openedAt = DateTime.now();
  }

  static String _fmtDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}-'
        '${d.month.toString().padLeft(2, '0')}-'
        '${d.year}';
  }

  static String _fmtTime(DateTime d) {
    final h24 = d.hour;
    final m = d.minute;
    final period = h24 >= 12 ? 'PM' : 'AM';
    final h12 = h24 % 12 == 0 ? 12 : h24 % 12;
    return '$h12:${m.toString().padLeft(2, '0')} $period';
  }

  List<Map<String, dynamic>> get _steps {
    final now = _openedAt;
    final confirmed = now.subtract(const Duration(hours: 2, minutes: 10));
    final processed = now.subtract(const Duration(hours: 1, minutes: 20));
    final delivery = now.subtract(const Duration(minutes: 40));

    return [
      {
        'icon': Icons.inventory_2_outlined,
        'title': 'Order Confirmed',
        'date': _fmtDate(confirmed),
        'time': _fmtTime(confirmed),
      },
      {
        'icon': Icons.settings_outlined,
        'title': 'Order Processed',
        'date': _fmtDate(processed),
        'time': _fmtTime(processed),
      },
      {
        'icon': Icons.local_shipping_outlined,
        'title': 'On Delivery',
        'date': _fmtDate(delivery),
        'time': _fmtTime(delivery),
      },
      {
        'icon': Icons.thumb_up_outlined,
        'title': 'Order Completed',
        'date': '------',
        'time': '',
      },
    ];
  }

  Future<void> _handleTap(int index) async {
    if (index == 3) {
=======
import 'order_success_screen.dart';

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({Key? key}) : super(key: key);

  @override
 State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {

  int selectedStep = 0;

  final List<Map<String, dynamic>> steps = [
    {
      "icon": Icons.inventory_2_outlined,
      "title": "Order Confirmed",
      "date": "20-12-2022",
      "time": "11:00 PM",
    },
    {
      "icon": Icons.settings_outlined,
      "title": "Order Processed",
      "date": "20-12-2022",
      "time": "10:30 PM",
    },
    {
      "icon": Icons.local_shipping_outlined,
      "title": "On Delivery",
      "date": "20-12-2022",
      "time": "12:30 PM",
    },
    {
      "icon": Icons.thumb_up_outlined,
      "title": "Order Completed",
      "date": "------",
      "time": "",
    },
  ];

  Future<void> _handleTap(int index) async {

    if (index == 3) {

      /// 🟤 LOADING
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
<<<<<<< HEAD
          child: CircularProgressIndicator(color: _kAppBrown),
=======
          child: CircularProgressIndicator(
            color: Colors.brown,
          ),
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
        ),
      );

      await Future.delayed(const Duration(seconds: 5));

<<<<<<< HEAD
      if (!mounted) return;
      Navigator.pop(context);
=======
      Navigator.pop(context); // close loader
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OrderSuccessScreen(),
        ),
      );
<<<<<<< HEAD
    } else {
=======

    } else {

>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
      setState(() {
        selectedStep = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final steps = _steps;

    return Scaffold(
      backgroundColor: const Color(0xFFD8BBA9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD8BBA9),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/logo.jpeg',
=======

    return Scaffold(

      backgroundColor: Colors.black87,

      /// ✅ APP BAR WITH LOGO
      appBar: AppBar(

        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        title: Row(

          mainAxisSize: MainAxisSize.min,

          children: [

            /// ✅ APP LOGO PNG
            ClipRRect(
              borderRadius: BorderRadius.circular(50),

              child: Image.asset(
                "assets/logo.jpeg", // <-- your logo path
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
<<<<<<< HEAD
            const SizedBox(width: 10),
            const Text(
              'ORDER STATUS',
              style: TextStyle(
                color: _kAppBrown,
=======

            const SizedBox(width: 10),

            const Text(
              "ORDER STATUS",
              style: TextStyle(
                color: Colors.grey,
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
<<<<<<< HEAD
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
=======

      body: Center(

        child: Container(

          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,

>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
<<<<<<< HEAD
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Order Status Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: _kAppBrown,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: steps.length,
                  itemBuilder: (context, index) {
                    final step = steps[index];
                    final isActive = index <= selectedStep;

                    return GestureDetector(
                      onTap: () => _handleTap(index),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Icon(
                                step['icon'] as IconData,
                                color: isActive
                                    ? _kAppBrown
                                    : Colors.brown.shade300,
                                size: 28,
                              ),
                              if (index != steps.length - 1)
                                Container(
                                  width: 2,
                                  height: 60,
                                  color: isActive
                                      ? Colors.brown.shade300
                                      : Colors.brown.shade100,
                                ),
                            ],
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 25),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isActive
                                      ? _kAppBrown
                                      : Colors.brown.shade200,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    step['title'] as String,
=======

          child: Column(

            children: [

              const SizedBox(height: 20),

              const Text(
                "Order Status Details",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 30),

              Expanded(

                child: ListView.builder(

                  padding: const EdgeInsets.symmetric(horizontal: 20),

                  itemCount: steps.length,

                  itemBuilder: (context, index) {

                    final step = steps[index];

                    bool isActive = index <= selectedStep;

                    return GestureDetector(

                      onTap: () => _handleTap(index),

                      child: Row(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          /// LEFT SIDE ICON + LINE
                          Column(

                            children: [

                              Icon(
                                step["icon"],
                                color: isActive
                                    ? Colors.orange
                                    : Colors.grey,
                                size: 28,
                              ),

                              if (index != steps.length - 1)

                                Container(
                                  width: 2,
                                  height: 60,
                                  color: Colors.grey.shade300,
                                ),
                            ],
                          ),

                          const SizedBox(width: 15),

                          /// RIGHT SIDE CARD
                          Expanded(

                            child: Container(

                              margin: const EdgeInsets.only(bottom: 25),

                              padding: const EdgeInsets.all(12),

                              decoration: BoxDecoration(

                                border: Border.all(
                                  color: isActive
                                      ? Colors.orange
                                      : Colors.grey.shade300,
                                ),

                                borderRadius: BorderRadius.circular(10),
                              ),

                              child: Column(

                                crossAxisAlignment:
                                    CrossAxisAlignment.start,

                                children: [

                                  Text(
                                    step["title"],
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: isActive
<<<<<<< HEAD
                                          ? _kAppBrown
                                          : Colors.brown.shade700,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        step['date'] as String,
                                        style: TextStyle(
                                          color: Colors.brown.shade600,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        step['time'] as String,
                                        style: TextStyle(
                                          color: Colors.brown.shade600,
                                          fontSize: 12,
=======
                                          ? Colors.orange
                                          : Colors.black,
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  Row(

                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,

                                    children: [

                                      Text(
                                        step["date"],
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),

                                      Text(
                                        step["time"],
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 02bb75ff6ab1a819f0f9bb47a3027b0911e6f527
