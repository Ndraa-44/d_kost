import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../property/presentation/pages/home_page.dart';
import '../../../booking/presentation/pages/booking_page.dart';
import '../../../saved/presentation/pages/saved_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';

/// Main screen with bottom navigation bar.
///
/// Acts as the shell for the four primary tabs:
/// Discover, Bookings, Favorites, and Profile.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    BookingPage(),
    SavedPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: AppStrings.navDiscover,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: AppStrings.navBookings,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: AppStrings.navFavorites,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: AppStrings.navProfile,
          ),
        ],
      ),
    );
  }
}
