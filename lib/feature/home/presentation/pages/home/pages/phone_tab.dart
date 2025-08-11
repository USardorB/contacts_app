import 'package:contacts_app/core/constants/app_icons.dart';
import 'package:contacts_app/core/theme/app_colors.dart';
import 'package:contacts_app/core/theme/app_fonts.dart';
import 'package:contacts_app/data/datasources/remote/network_service.dart';
import 'package:contacts_app/data/datasources/remote_data_sources.dart';
import 'package:contacts_app/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneTab extends StatefulWidget {
  const PhoneTab({super.key});

  @override
  State<PhoneTab> createState() => _PhoneTabState();
}

class _PhoneTabState extends State<PhoneTab> {
  late final UserRemoteDataSource userDataSource;
  List<UserModel> users = [];
  bool isLoading = true;
  bool isMissed = false;
  bool isAll = true;
  String? errorMessage;

  Future<void> _makePhoneCall(String phoneNumber) async {
    try {
      final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not make phone call to $phoneNumber'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error making phone call: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _sendSms(String phoneNumber) async {
    try {
      final Uri smsUri = Uri(scheme: 'sms', path: phoneNumber);
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri, mode: LaunchMode.externalApplication);
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not send SMS to $phoneNumber'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sending SMS: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    final networkService = NetworkServiceImpl(
      baseUrl: 'https://jsonplaceholder.typicode.com',
    );
    userDataSource = UserRemoteDataSourceImpl(networkService);
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    try {
      if (!mounted) return;
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final usersList = await userDataSource.getAllUsers();
      if (!mounted) return;
      setState(() {
        users = usersList;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 60, right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Phone",
            style: AppFonts.bold28(
                color: AppColors.black, font: AppFontFamily.poppins),
          ),
          SizedBox(height: 20),

          // Call History Header
          if (!isLoading && users.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        NetworkImage(NetworkServiceImpl.getProfileImage(0)),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recent Calls",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${users.length} contacts",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          SizedBox(height: 20),

          // Filter Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isAll = true;
                    isMissed = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(145, 50),
                  backgroundColor:
                      isAll ? Colors.green.shade400 : Colors.grey.shade300,
                ),
                child: Text(
                  'All',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isMissed = true;
                    isAll = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(145, 50),
                  backgroundColor:
                      isMissed ? Colors.red.shade400 : Colors.grey.shade300,
                ),
                child: Text(
                  'Missed',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          // Call History List
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Error: $errorMessage'),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _loadUsers,
                              child: Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : isAll
                        ? _buildAllCallsList()
                        : _buildMissedCallsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAllCallsList() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(milliseconds: 200),
                      content: Text("User's phone: ${users[index].phone}"),
                    ),
                  );
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => _makePhoneCall(users[index].phone),
                      icon: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          fit: BoxFit.cover,
                          AppIcons.phoneIcon,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _sendSms(users[index].phone),
                      icon: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          fit: BoxFit.cover,
                          AppIcons.smsIcon,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                leading: CircleAvatar(
                  radius: 30,
                  child: ClipOval(
                    child: Image.network(
                      NetworkServiceImpl.getProfileImage(index),
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey.shade300,
                          child: Icon(
                            Icons.person,
                            color: Colors.grey.shade600,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                title: Text(
                  maxLines: 1,
                  users[index].name,
                  style: TextStyle(
                    color: index == 3 || index == 2 || index == 7
                        ? Colors.red
                        : Colors.black,
                  ),
                ),
                subtitle: Text(NetworkServiceImpl.getCallTime(index)),
              ),
              if (index != users.length - 1)
                Divider(
                  thickness: 1,
                  color: Colors.grey.shade300,
                  indent: 16,
                  endIndent: 16,
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMissedCallsList() {
    final missedUsers = users.where((user) {
      final index = users.indexOf(user);
      return index == 3 || index == 2 || index == 7;
    }).toList();

    if (missedUsers.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'No missed calls',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: missedUsers.length,
      itemBuilder: (context, index) {
        final user = missedUsers[index];
        final originalIndex = users.indexOf(user);

        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(milliseconds: 200),
                      content: Text("User's phone: ${user.phone}"),
                    ),
                  );
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => _makePhoneCall(user.phone),
                      icon: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          fit: BoxFit.cover,
                          AppIcons.phoneIcon,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _sendSms(user.phone),
                      icon: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          fit: BoxFit.cover,
                          AppIcons.smsIcon,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                leading: CircleAvatar(
                  radius: 30,
                  child: ClipOval(
                    child: Image.network(
                      NetworkServiceImpl.getProfileImage(originalIndex),
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey.shade300,
                          child: Icon(
                            Icons.person,
                            color: Colors.grey.shade600,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                title: Text(
                  maxLines: 1,
                  user.name,
                  style: TextStyle(color: Colors.red),
                ),
                subtitle: Text(
                  'Missed call - ${NetworkServiceImpl.getCallTime(originalIndex)}',
                  style: TextStyle(color: Colors.red.shade400),
                ),
              ),
              if (index != missedUsers.length - 1)
                Divider(
                  thickness: 1,
                  color: Colors.grey.shade300,
                  indent: 16,
                  endIndent: 16,
                ),
            ],
          ),
        );
      },
    );
  }
}
