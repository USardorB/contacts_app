import 'package:contacts_app/core/constants/app_icons.dart';
import 'package:contacts_app/data/datasources/remote/network_service.dart';
import 'package:contacts_app/data/datasources/remote_data_sources.dart';
import 'package:contacts_app/data/models/user_model.dart';
import 'package:contacts_app/feature/auth/presentation/widgets/custom_navbar.dart';
import 'package:contacts_app/presentation/pages/home/pages/calendar_tab.dart';
import 'package:contacts_app/presentation/pages/home/pages/home_tab.dart';
import 'package:contacts_app/presentation/pages/home/pages/phone_tab.dart';
import 'package:contacts_app/presentation/pages/home/pages/profile_tab.dart';
// import 'package:contacts_app/presentation/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: CustomNavbar(
              iconPath: AppIcons.homeIcon,
              index: 0,
              selectedIndex: _selectedIndex,
            ),
            label: "Home",
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: CustomNavbar(
              iconPath: AppIcons.phoneIcon,
              index: 1,
              selectedIndex: _selectedIndex,
            ),
            label: "Phone",
          ),
          BottomNavigationBarItem(
            icon: CustomNavbar(
              iconPath: AppIcons.calendarIcon,
              index: 2,
              selectedIndex: _selectedIndex,
            ),
            label: "Calendar",
          ),
          BottomNavigationBarItem(
            icon: CustomNavbar(
              iconPath: AppIcons.personIcon,
              index: 3,
              selectedIndex: _selectedIndex,
            ),
            label: "Profile",
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          HomeTab(),
          PhoneTab(),
          CalendarTab(),
          ProfileTab(),
        ],
      ),
    );
  }
}
