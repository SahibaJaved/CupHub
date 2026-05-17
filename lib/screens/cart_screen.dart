import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import 'home_screen.dart';
import 'payment_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final cart = context.watch<CartProvider>();

    return Scaffold(

      backgroundColor: const Color(0xFFD8BBA9),

      body: SafeArea(

        child: Column(

          children: [

            /// TOP BAR
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),

              child: Row(

                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: [

                  /// LEFT SIDE
                  Row(
                    children: [

                      IconButton(

                        onPressed: () {

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const HomeScreen(),
                            ),
                            (route) => false,
                          );
                        },

                        style: IconButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF6D4C41),
                        ),

                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(width: 10),

                      const Text(
                        "Cart",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  /// LOGO
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10),

                    child: Image.asset(
                      "assets/logo.jpeg",
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),

            /// CART ITEMS
            Expanded(

              child: cart.items.isEmpty

                  ? const Center(
                      child: Text(
                        "Cart is empty",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )

                  : ListView.builder(

                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),

                      itemCount: cart.items.length,

                      itemBuilder: (context, index) {

                        final item = cart.items[index];

                        return Container(

                          margin:
                              const EdgeInsets.only(
                            bottom: 15,
                          ),

                          padding:
                              const EdgeInsets.all(12),

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(18),

                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                              ),
                            ],
                          ),

                          child: Row(

                            children: [

                              /// IMAGE
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(
                                        12),

                                child: Image.asset(
                                  item.image,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              const SizedBox(width: 15),

                              /// NAME + PRICE
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                  children: [

                                    Text(
                                      item.name,
                                      style:
                                          const TextStyle(
                                        fontSize: 18,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(
                                        height: 5),

                                    Text(
                                      "Rs. ${item.price}",
                                      style:
                                          const TextStyle(
                                        fontSize: 16,
                                        color:
                                            Colors.brown,
                                        fontWeight:
                                            FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              /// QUANTITY BUTTONS
                              Column(
                                children: [

                                  IconButton(
                                    onPressed: () {
                                      cart
                                          .increaseQuantity(
                                              index);
                                    },

                                    icon: const Icon(
                                      Icons.add_circle,
                                      color:
                                          Color(0xFF6D4C41),
                                    ),
                                  ),

                                  Text(
                                    "${item.quantity}",
                                    style:
                                        const TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),

                                  IconButton(
                                    onPressed: () {
                                      cart
                                          .decreaseQuantity(
                                              index);
                                    },

                                    icon: const Icon(
                                      Icons.remove_circle,
                                      color:
                                          Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),

            /// TOTAL + ORDER BUTTON
            Container(

              padding: const EdgeInsets.all(20),

              decoration: const BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.vertical(
                  top: Radius.circular(30),
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                  ),
                ],
              ),

              child: Column(

                children: [

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [

                      const Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        "Rs. ${cart.totalPrice.toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6D4C41),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton(

                      onPressed: () {

                        if (cart.items.isEmpty) {

                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Cart is empty",
                              ),
                            ),
                          );

                          return;
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const PaymentScreen(),
                          ),
                        );
                      },

                      style: ElevatedButton.styleFrom(

                        backgroundColor:
                            const Color(0xFF6D4C41),

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15),
                        ),
                      ),

                      child: const Text(
                        "Tap to Order",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}