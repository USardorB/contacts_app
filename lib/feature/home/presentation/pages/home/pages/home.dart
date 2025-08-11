import 'package:contacts_app/core/constants/app_icons.dart';
import 'package:contacts_app/data/datasources/remote/network_service.dart';
import 'package:contacts_app/data/datasources/remote_data_sources.dart';
import 'package:contacts_app/data/models/user_model.dart';
import 'package:contacts_app/feature/auth/presentation/widgets/custom_navbar.dart';
import 'package:contacts_app/feature/home/presentation/pages/home/pages/home_tab.dart';
import 'package:contacts_app/feature/home/presentation/pages/home/pages/phone_tab.dart';
import 'package:contacts_app/feature/profile/presentation/pages/profile_page.dart';
import 'package:contacts_app/feature/reminder/presentation/pages/reminder_page.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int _selectedIndex = 0;
  late PageController _pageController;
  late final UserRemoteDataSource _userDataSource;

  // API state management with caching
  List<UserModel> _users = [];
  bool _isLoading = true;
  String? _errorMessage;
  bool _isInitialized = false;
  DateTime? _lastFetchTime;
  static const Duration _cacheValidDuration = Duration(minutes: 5);

  @override
  void initState() {
    super.initState();
    _initializeDataSource();
    _pageController = PageController(initialPage: _selectedIndex);
    _loadUsers();
  }

  void _initializeDataSource() {
    final networkService = NetworkServiceImpl(
      baseUrl: 'https://jsonplaceholder.typicode.com',
    );
    _userDataSource = UserRemoteDataSourceImpl(networkService);
  }

  bool _isCacheValid() {
    if (_lastFetchTime == null) return false;
    return DateTime.now().difference(_lastFetchTime!) < _cacheValidDuration;
  }

  Future<void> _loadUsers() async {
    // Check if we have valid cached data
    if (_isInitialized && _isCacheValid() && _users.isNotEmpty) {
      return;
    }

    try {
      if (!mounted) return;
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final usersList = await _userDataSource.getAllUsers();
      if (!mounted) return;
      setState(() {
        _users = usersList;
        _isLoading = false;
        _isInitialized = true;
        _lastFetchTime = DateTime.now();
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
        _isInitialized = true;
      });
    }
  }

  Future<void> _refreshUsers() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final usersList = await _userDataSource.getAllUsers();
      if (!mounted) return;
      setState(() {
        _users = usersList;
        _isLoading = false;
        _lastFetchTime = DateTime.now();
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
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
            label: "Reminder",
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
          HomeTab(
            users: _users,
            isLoading: _isLoading,
            errorMessage: _errorMessage,
            onRefresh: _refreshUsers,
          ),
          PhoneTab(),
          ReminderPage(),
          ProfilePage(),
        ],
      ),
    );
  }
}
