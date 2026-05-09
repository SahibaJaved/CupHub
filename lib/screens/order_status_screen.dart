import 'package:flutter/material.dart';
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
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
          child: CircularProgressIndicator(
            color: Colors.brown,
          ),
        ),
      );

      await Future.delayed(const Duration(seconds: 5));

      Navigator.pop(context); // close loader

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OrderSuccessScreen(),
        ),
      );

    } else {

      setState(() {
        selectedStep = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

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
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 10),

            const Text(
              "ORDER STATUS",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      body: Center(

        child: Container(

          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),

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
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: isActive
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
}