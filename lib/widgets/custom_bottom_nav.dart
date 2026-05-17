import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {

  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(

      currentIndex: selectedIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,

      selectedItemColor: const Color(0xFF5D3A26),
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,

      items: [

        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),

        const BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: "Favourite",
        ),

        const BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          label: "Cart",
        ),

        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 12,
            backgroundImage: const AssetImage('assets/profile.jpg'),
          ),
          label: "Profile",
        ),

      ],
    );
  }
}