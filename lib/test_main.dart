// import 'package:contacts_app/core/constants/app_icons.dart';
// import 'package:contacts_app/data/datasources/remote/network_service.dart';
// import 'package:contacts_app/data/datasources/remote_data_sources.dart';
// import 'package:contacts_app/data/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         textTheme: GoogleFonts.poppinsTextTheme(),
//       ),
//       home: const Home(),
//     );
//   }
// }

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   late final UserRemoteDataSource _userDataSource;
//   List<UserModel> _users = [];
//   bool _isLoading = true;
//   bool _isMissed = false;
//   bool _isAll = true;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _initializeDataSource();
//     _loadUsers();
//   }

//   void _initializeDataSource() {
//     final networkService = NetworkServiceImpl(
//       baseUrl: 'https://jsonplaceholder.typicode.com',
//     );
//     _userDataSource = UserRemoteDataSourceImpl(networkService);
//   }

//   Future<void> _loadUsers() async {
//     try {
//       setState(() {
//         _isLoading = true;
//         _errorMessage = null;
//       });

//       final usersList = await _userDataSource.getAllUsers();
//       setState(() {
//         _users = usersList;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _errorMessage = e.toString();
//         _isLoading = false;
//       });
//     }
//   }

//   Future<void> _makePhoneCall(String phoneNumber) async {
//     try {
//       final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
//       if (await canLaunchUrl(phoneUri)) {
//         await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
//       } else {
//         _showSnackBar('Could not make phone call to $phoneNumber',
//             isError: true);
//       }
//     } catch (e) {
//       _showSnackBar('Error making phone call: ${e.toString()}', isError: true);
//     }
//   }

//   Future<void> _sendSms(String phoneNumber) async {
//     try {
//       final Uri smsUri = Uri(scheme: 'sms', path: phoneNumber);
//       if (await canLaunchUrl(smsUri)) {
//         await launchUrl(smsUri, mode: LaunchMode.externalApplication);
//       } else {
//         _showSnackBar('Could not send SMS to $phoneNumber', isError: true);
//       }
//     } catch (e) {
//       _showSnackBar('Error sending SMS: ${e.toString()}', isError: true);
//     }
//   }

//   void _showSnackBar(String message, {bool isError = false}) {
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(message),
//           backgroundColor: isError ? Colors.red : Colors.green,
//           duration: const Duration(milliseconds: 2000),
//         ),
//       );
//     }
//   }

//   void _onFilterChanged(bool isAll) {
//     setState(() {
//       _isAll = isAll;
//       _isMissed = !isAll;
//     });
//   }

//   void _onUserTap(UserModel user) {
//     _showSnackBar("User's phone: ${user.phone}");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const SizedBox(height: 40),
//               _buildFilterButtons(),
//               const SizedBox(height: 20),
//               Expanded(
//                 child: _buildContent(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFilterButtons() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         _buildFilterButton(
//           label: 'All',
//           isSelected: _isAll,
//           color: Colors.green.shade400,
//           onPressed: () => _onFilterChanged(true),
//         ),
//         _buildFilterButton(
//           label: 'Missed',
//           isSelected: _isMissed,
//           color: Colors.red.shade400,
//           onPressed: () => _onFilterChanged(false),
//         ),
//       ],
//     );
//   }

//   Widget _buildFilterButton({
//     required String label,
//     required bool isSelected,
//     required Color color,
//     required VoidCallback onPressed,
//   }) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         minimumSize: const Size(145, 50),
//         backgroundColor: isSelected ? color : Colors.grey.shade300,
//       ),
//       child: Text(
//         label,
//         style: const TextStyle(color: Colors.black, fontSize: 18),
//       ),
//     );
//   }

//   Widget _buildContent() {
//     if (_isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     if (_errorMessage != null) {
//       return _buildErrorWidget();
//     }

//     if (_users.isEmpty) {
//       return _buildEmptyState();
//     }

//     return _isAll ? _buildAllCallsList() : _buildMissedCallsList();
//   }

//   Widget _buildErrorWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('Error: $_errorMessage'),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: _loadUsers,
//             child: const Text('Retry'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return const Center(
//       child: Text('No users found'),
//     );
//   }

//   Widget _buildAllCallsList() {
//     return ListView.builder(
//       physics: const BouncingScrollPhysics(),
//       itemCount: _users.length,
//       itemBuilder: (context, index) {
//         final user = _users[index];
//         return _buildCallListItem(user, index);
//       },
//     );
//   }

//   Widget _buildMissedCallsList() {
//     final missedUsers = _users.where((user) {
//       final index = _users.indexOf(user);
//       return index == 3 || index == 2 || index == 7;
//     }).toList();

//     if (missedUsers.isEmpty) {
//       return Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Text(
//             'No missed calls',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey.shade600,
//             ),
//           ),
//         ),
//       );
//     }

//     return ListView.builder(
//       physics: const BouncingScrollPhysics(),
//       itemCount: missedUsers.length,
//       itemBuilder: (context, index) {
//         final user = missedUsers[index];
//         final originalIndex = _users.indexOf(user);
//         return _buildCallListItem(user, originalIndex, isMissed: true);
//       },
//     );
//   }

//   Widget _buildCallListItem(UserModel user, int index,
//       {bool isMissed = false}) {
//     final isRedUser = index == 3 || index == 2 || index == 7;

//     return Padding(
//       padding: const EdgeInsets.only(top: 10),
//       child: Column(
//         children: [
//           ListTile(
//             onTap: () => _onUserTap(user),
//             trailing: _buildActionButtons(user),
//             leading: _buildUserAvatar(index),
//             title: Text(
//               maxLines: 1,
//               user.name,
//               style: TextStyle(
//                 color: isRedUser ? Colors.red : Colors.black,
//               ),
//             ),
//             subtitle: Text(
//               isMissed
//                   ? 'Missed call - ${NetworkServiceImpl.getCallTime(index)}'
//                   : NetworkServiceImpl.getCallTime(index),
//               style: TextStyle(
//                 color: isMissed ? Colors.red.shade400 : null,
//               ),
//             ),
//           ),
//           if (index != _users.length - 1)
//             Divider(
//               thickness: 1,
//               color: Colors.grey.shade300,
//               indent: 16,
//               endIndent: 16,
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionButtons(UserModel user) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         _buildActionButton(
//           icon: AppIcons.phoneIcon,
//           onPressed: () => _makePhoneCall(user.phone),
//         ),
//         _buildActionButton(
//           icon: AppIcons.smsIcon,
//           onPressed: () => _sendSms(user.phone),
//         ),
//       ],
//     );
//   }

//   Widget _buildActionButton({
//     required String icon,
//     required VoidCallback onPressed,
//   }) {
//     return IconButton(
//       onPressed: onPressed,
//       icon: Container(
//         alignment: Alignment.center,
//         height: 40,
//         width: 40,
//         decoration: BoxDecoration(
//           color: Colors.grey.shade200,
//           shape: BoxShape.circle,
//         ),
//         child: SvgPicture.asset(
//           fit: BoxFit.cover,
//           icon,
//           height: 20,
//           width: 20,
//         ),
//       ),
//     );
//   }

//   Widget _buildUserAvatar(int index) {
//     return CircleAvatar(
//       radius: 30,
//       child: ClipOval(
//         child: Image.network(
//           NetworkServiceImpl.getProfileImage(index),
//           fit: BoxFit.cover,
//           width: 60,
//           height: 60,
//           errorBuilder: (context, error, stackTrace) {
//             return Container(
//               width: 60,
//               height: 60,
//               color: Colors.grey.shade300,
//               child: Icon(
//                 Icons.person,
//                 color: Colors.grey.shade600,
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
