// payment_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../providers/cart_provider.dart';
import '../models/order_model.dart';
import '../services/firestore_service.dart';
import 'order_status_screen.dart';

class PaymentScreen extends StatefulWidget {

  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() =>
      _PaymentScreenState();
}

class _PaymentScreenState
    extends State<PaymentScreen> {

  /// DEFAULT PAYMENT
  String selectedPayment = "Cash";

  @override
  Widget build(BuildContext context) {

    final cart = context.watch<CartProvider>();

    return Scaffold(

      backgroundColor: const Color(0xFFD8BBA9),

      appBar: AppBar(

        backgroundColor: const Color(0xFFD8BBA9),
        elevation: 0,

        leading: IconButton(

          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),

          style: IconButton.styleFrom(
            backgroundColor: const Color(0xFF6D4C41),
          ),

          onPressed: () {

            Navigator.pop(context);

          },
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            /// LOGO
            Align(

              alignment: Alignment.topRight,

              child: ClipRRect(

                borderRadius:
                    BorderRadius.circular(12),

                child: Image.asset(

                  "assets/logo.jpeg",

                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// CART ITEMS
            Expanded(

              child: ListView.builder(

                itemCount: cart.items.length,

                itemBuilder: (context, index) {

                  final item = cart.items[index];

                  return Padding(

                    padding:
                        const EdgeInsets.only(
                      bottom: 12,
                    ),

                    child: Container(

                      decoration: BoxDecoration(

                        border: Border.all(
                          color:
                              Colors.grey.shade300,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                                15),
                      ),

                      child: ListTile(

                        contentPadding:
                            const EdgeInsets.all(
                                8),

                        leading: ClipRRect(

                          borderRadius:
                              BorderRadius.circular(
                                  10),

                          child: Image.asset(

                            item.image,

                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),

                        title: Text(

                          item.name,

                          style: const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        subtitle: Text(
                          "Rs. ${item.price}",
                        ),

                        trailing: Column(

                          mainAxisAlignment:
                              MainAxisAlignment
                                  .center,

                          children: [

                            const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 18,
                            ),

                            const SizedBox(
                                height: 5),

                            Text(

                              "Qty: ${item.quantity}",

                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            /// LOCATION
            const Row(

              children: [

                Icon(
                  Icons.location_on,
                  color: Color(0xFF5D4037),
                ),

                SizedBox(width: 8),

                Text(

                  'Manawala, Faisalabad',

                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            /// PAYMENT TITLE
            const Text(

              "Payment Method",

              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            /// CASH
            _paymentOption(

              icon: Icons.money,

              title: "Cash",

              isSelected:
                  selectedPayment == "Cash",

              onTap: () {

                setState(() {

                  selectedPayment = "Cash";

                });
              },
            ),

            /// EASYPAISA
            _paymentOption(

              icon:
                  Icons.account_balance_wallet,

              title: "EasyPaisa / JazzCash",

              isSelected:
                  selectedPayment ==
                      "EasyPaisa / JazzCash",

              onTap: () {

                setState(() {

                  selectedPayment =
                      "EasyPaisa / JazzCash";

                });
              },
            ),

            /// CARD
            _paymentOption(

              icon: Icons.credit_card,

              title: "Bank Card",

              isSelected:
                  selectedPayment ==
                      "Bank Card",

              onTap: () {

                setState(() {

                  selectedPayment =
                      "Bank Card";

                });
              },
            ),

            const SizedBox(height: 30),

            /// CREATE ORDER BUTTON
            GestureDetector(

              onTap: () async {
                if (cart.items.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Your cart is empty")),
                  );
                  return;
                }

                // Show loading dialog
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(child: CircularProgressIndicator()),
                );

                try {
                  final userId = FirebaseAuth.instance.currentUser?.uid;
                  final userEmail = FirebaseAuth.instance.currentUser?.email;

                  if (userId == null) {
                    Navigator.pop(context); // close dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please login to place an order.")),
                    );
                    return;
                  }

                  // 1. Prepare Order Items
                  final List<OrderItemModel> orderItems = cart.items.map((item) {
                    return OrderItemModel(
                      productId: item.name.replaceAll(' ', '_').toLowerCase(),
                      name: item.name,
                      price: item.price,
                      quantity: item.quantity,
                    );
                  }).toList();

                  // 2. Prepare Final Order
                  final double deliveryFee = 2.50; // Mock delivery fee
                  final order = OrderModel(
                    id: '', // Will be auto-generated by FirestoreService
                    userId: userId,
                    customerName: userEmail?.split('@').first ?? 'Customer',
                    subtotal: cart.totalPrice,
                    deliveryFee: deliveryFee,
                    totalAmount: cart.totalPrice + deliveryFee,
                    paymentMethod: selectedPayment,
                    paymentStatus: 'pending',
                    orderStatus: 'confirmed',
                    createdAt: DateTime.now(),
                    items: orderItems,
                  );

                  // 3. Send to Firestore (this also clears the cart)
                  await FirestoreService().placeOrder(order);

                  // Close loading dialog
                  Navigator.pop(context);

                  // 4. Success Feedback & Navigation
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Order Created with $selectedPayment")),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrderStatusScreen(),
                    ),
                  );
                } catch (e) {
                  Navigator.pop(context); // close dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to place order: $e")),
                  );
                }
              },

              child: Container(

                width: double.infinity,

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),

                decoration: BoxDecoration(

                  color:
                      const Color(0xFF915F47),

                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: Row(

                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                  children: [

                    const Text(

                      'Place Order',

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),

                    Text(

                      'Rs. ${cart.totalPrice}',

                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// PAYMENT OPTION WIDGET
  Widget _paymentOption({

    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,

  }) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        margin:
            const EdgeInsets.symmetric(
          vertical: 8,
        ),

        padding: const EdgeInsets.all(15),

        decoration: BoxDecoration(

          color: isSelected
              ? const Color(0xFFEFEBE9)
              : Colors.white,

          borderRadius:
              BorderRadius.circular(15),

          border: Border.all(

            color: isSelected
                ? const Color(0xFF6D4C41)
                : Colors.grey.shade300,

            width: 2,
          ),
        ),

        child: Row(

          children: [

            Icon(

              icon,

              size: 28,

              color: const Color(0xFF5D4037),
            ),

            const SizedBox(width: 15),

            Expanded(

              child: Text(

                title,

                style: const TextStyle(
                  fontSize: 16,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            Icon(

              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,

              color: const Color(0xFF6D4C41),
            ),
          ],
        ),
      ),
    );
  }
}