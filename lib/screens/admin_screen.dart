import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../services/firestore_service.dart';
import 'login_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  double _s(BuildContext ctx, double value) => value * MediaQuery.of(ctx).size.width / 375;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5ECE0),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6F4436),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
            );
          },
        ),
        title: Text('Orders', style: TextStyle(fontSize: _s(context,18), color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _buildOrdersViewWrapper(context),
      ),
    );
  }

  Widget _buildOrdersViewWrapper(BuildContext context) {
    return StreamBuilder<List<OrderModel>>(
      stream: _firestoreService.streamAllOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Color(0xFF6F4436)));
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error fetching orders: ${snapshot.error}"));
        }

        final orders = snapshot.data ?? [];
        return _buildOrdersView(context, orders);
      },
    );
  }

  Widget _buildOrdersView(BuildContext context, List<OrderModel> orders) {
    final totalOrders = orders.length;
    final pendingOrders = orders.where((o) => o.orderStatus == 'pending').length;
    final completedOrders = orders.where((o) => o.orderStatus == 'delivered' || o.orderStatus == 'cancelled').length;
    final acceptedOrders = orders.where((o) => o.orderStatus == 'preparing' || o.orderStatus == 'delivered').toList();
    
    final totalRevenue = acceptedOrders.fold<double>(0, (sum, order) {
      return sum + order.totalAmount;
    });

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: _s(context,16), vertical: _s(context,14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(_s(context,16)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(_s(context,18)),
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.withOpacity(0.12),
                  blurRadius: _s(context,14),
                  offset: Offset(0, _s(context,6)),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: _s(context,64),
                  height: _s(context,64),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6F4436),
                    borderRadius: BorderRadius.circular(_s(context,14)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(_s(context,14)),
                    child: Image.asset(
                      'assets/logo.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: _s(context,12)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome, Admin', style: TextStyle(color: Colors.black87, fontSize: _s(context,18), fontWeight: FontWeight.bold)),
                      SizedBox(height: _s(context,6)),
                      Text('CupHub Dashboard', style: TextStyle(color: Colors.black54, fontSize: _s(context,13))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: _s(context,16)),
          Text('Order Overview', style: TextStyle(fontSize: _s(context,16), fontWeight: FontWeight.bold)),
          SizedBox(height: _s(context,10)),
          Container(
            padding: EdgeInsets.all(_s(context,12)),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(_s(context,12))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildOverviewBox(context, 'Total Orders', '$totalOrders', Colors.brown),
                _buildOverviewBox(context, 'Pending', '$pendingOrders', const Color(0xFFD7B892)),
                _buildOverviewBox(context, 'Completed', '$completedOrders', const Color(0xFF8DBE8F)),
                _buildOverviewBox(context, 'Revenue', 'Rs. ${totalRevenue.toStringAsFixed(0)}', const Color(0xFF6F4436)),
              ],
            ),
          ),
          SizedBox(height: _s(context,16)),
          Text('Orders List', style: TextStyle(fontSize: _s(context,16), fontWeight: FontWeight.bold)),
          SizedBox(height: _s(context,10)),
          if (orders.isEmpty)
             Padding(
               padding: const EdgeInsets.only(top: 20),
               child: Center(child: Text("No orders found.", style: TextStyle(color: Colors.grey))),
             ),
          Column(children: orders.map((order) => _buildOrderCard(context, order)).toList()),
        ],
      ),
    );
  }

  Widget _buildOverviewBox(BuildContext context, String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(_s(context,12)),
        margin: EdgeInsets.symmetric(horizontal: _s(context,4)),
        decoration: BoxDecoration(color: Color.fromRGBO(color.red, color.green, color.blue, 0.12), borderRadius: BorderRadius.circular(_s(context,12))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: TextStyle(color: Color.fromRGBO(color.red, color.green, color.blue, 0.9), fontSize: _s(context,11))),
          SizedBox(height: _s(context,6)),
          Text(value, style: TextStyle(color: color, fontSize: _s(context,18), fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, OrderModel order) {
    Color badgeColor;
    String displayStatus;
    
    switch (order.orderStatus) {
      case 'pending':
      case 'confirmed':
        badgeColor = const Color(0xFFF2C88B);
        displayStatus = 'Pending';
        break;
      case 'preparing':
        badgeColor = const Color(0xFFDEC19D);
        displayStatus = 'Preparing';
        break;
      case 'delivered':
        badgeColor = const Color(0xFF8DBE8F);
        displayStatus = 'Delivered';
        break;
      case 'cancelled':
        badgeColor = Colors.red;
        displayStatus = 'Cancelled';
        break;
      default:
        badgeColor = Colors.grey;
        displayStatus = order.orderStatus;
    }

    String itemStr = order.items.map((e) => "${e.quantity} ${e.name}").join(', ');

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: _s(context,14)),
      padding: EdgeInsets.all(_s(context,12)),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(_s(context,14)), border: Border.all(color: Colors.brown.shade100)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text("#${order.id.substring(0, 5).toUpperCase()}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: _s(context,14))),
          Spacer(),
          Container(padding: EdgeInsets.symmetric(horizontal: _s(context,10), vertical: _s(context,6)), decoration: BoxDecoration(color: Color.fromRGBO(badgeColor.red, badgeColor.green, badgeColor.blue, 0.2), borderRadius: BorderRadius.circular(_s(context,10))), child: Text(displayStatus, style: TextStyle(color: badgeColor, fontWeight: FontWeight.w600))),
        ]),
        SizedBox(height: _s(context,8)),
        Text(order.customerName, style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: _s(context,6)),
        Text(itemStr, style: TextStyle(color: Colors.black54)),
        SizedBox(height: _s(context,12)),
        Row(children: [
          Text('Rs. ${order.totalAmount.toStringAsFixed(0)}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: _s(context,14))),
          Spacer(),
          if (order.orderStatus == 'pending' || order.orderStatus == 'confirmed') ...[
            ElevatedButton(
              onPressed: () => _firestoreService.updateOrderStatus(order.id, 'preparing'), 
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6F4436), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_s(context,12))), elevation: 0), 
              child: const Text('Accept Order', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
            ),
            SizedBox(width: _s(context,8)),
            ElevatedButton(
              onPressed: () => _firestoreService.updateOrderStatus(order.id, 'cancelled'), 
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_s(context,12))), elevation: 0), 
              child: const Text('Reject', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
            ),
          ] else if (order.orderStatus == 'preparing') ...[
            ElevatedButton(
              onPressed: () => _firestoreService.updateOrderStatus(order.id, 'delivered'), 
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6F4436), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_s(context,12))), elevation: 0), 
              child: const Text('Mark as Delivered', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
            ),
          ],
        ])
      ]),
    );
  }
}
