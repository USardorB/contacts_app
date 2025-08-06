import 'package:contacts_app/core/constants/app_icons.dart';
import 'package:contacts_app/data/datasources/remote/network_service.dart';
import 'package:contacts_app/data/datasources/remote_data_sources.dart';
import 'package:contacts_app/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        // Show a snackbar instead of throwing an exception
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not make phone call to $phoneNumber'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Show error message to user
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
        // Show a snackbar instead of throwing an exception
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not send SMS to $phoneNumber'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Show error message to user
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
    load();
  }

  Future<void> load() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final usersList = await userDataSource.getAllUsers();
      setState(() {
        users = usersList;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 40,
              ),
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
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: isAll
                    ? ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: Duration(milliseconds: 200),
                                        content: Text(
                                          "this users phone: ${users[index].phone}",
                                        ),
                                      ),
                                    );
                                  },
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          _makePhoneCall(users[index].phone);
                                          debugPrint(
                                              "phone is: ${users[index].phone}");
                                        },
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
                                        NetworkServiceImpl.pictureUrl[index %
                                            NetworkServiceImpl
                                                .pictureUrl.length],
                                        fit: BoxFit.cover,
                                        width: 60,
                                        height: 60,
                                        errorBuilder:
                                            (context, error, stackTrace) {
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
                                      color:
                                          index == 3 || index == 2 || index == 7
                                              ? Colors.red
                                              : Colors.black,
                                    ),
                                  ),
                                  subtitle:
                                      Text(NetworkServiceImpl.times[index]),
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
                      )
                    : isMissed
                        ? ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: users
                                .where((user) =>
                                    users.indexOf(user) == 3 ||
                                    users.indexOf(user) == 2 ||
                                    users.indexOf(user) == 7)
                                .length,
                            itemBuilder: (context, index) {
                              final missedUsers = users
                                  .where((user) =>
                                      users.indexOf(user) == 3 ||
                                      users.indexOf(user) == 2 ||
                                      users.indexOf(user) == 7)
                                  .toList();

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

                              final user = missedUsers[index];
                              final originalIndex = users.indexOf(user);

                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            duration:
                                                Duration(milliseconds: 200),
                                            content: Text(
                                              "this users phone: ${users[index].phone}",
                                            ),
                                          ),
                                        );
                                      },
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              _makePhoneCall(user.phone);
                                            },
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
                                            NetworkServiceImpl.pictureUrl[
                                                originalIndex %
                                                    NetworkServiceImpl
                                                        .pictureUrl.length],
                                            fit: BoxFit.cover,
                                            width: 60,
                                            height: 60,
                                            errorBuilder:
                                                (context, error, stackTrace) {
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
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                      subtitle: Text(
                                        'Missed call - ${NetworkServiceImpl.times[originalIndex]}',
                                        style: TextStyle(
                                          color: Colors.red.shade400,
                                        ),
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
                          )
                        : SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
