import 'package:contacts_app/core/constants/app_icons.dart';
import 'package:contacts_app/data/models/user_model.dart';
import 'package:contacts_app/feature/auth/presentation/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailPage extends StatefulWidget {
  final UserModel user;
  final String imageUlr;
  const DetailPage({super.key, required this.user, required this.imageUlr});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: IconButton(
            icon: SvgPicture.asset(
              AppIcons.backButton,
              fit: BoxFit.cover,
              height: 45,
              width: 45,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text("Contact Details"),
        actions: [
          IconButton(
            icon: SvgPicture.asset(AppIcons.noteIcon),
            onPressed: () {
              /// Todo: Implement note functionality
            },
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 100,
                    child: ClipOval(
                      child: Image.network(
                        widget.imageUlr,
                        fit: BoxFit.cover,
                        width: 220,
                        height: 220,
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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.user.name,
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // here
                      MyButton(
                        onTap: () {},
                        imagePath: AppIcons.smsIcon,
                        text: "Message",
                      ),

                      MyButton(
                        onTap: () {},
                        imagePath: AppIcons.phoneIcon,
                        text: "Call",
                      ),

                      MyButton(
                        onTap: () {},
                        imagePath: AppIcons.mmsIcon,
                        text: "Email",
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.1,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Phone Numbers",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "+ ${widget.user.phone}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Text(
                                      widget.user.address.street,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              SvgPicture.asset(
                                AppIcons.phoneIcon,
                                height: 24,
                                width: 24,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 0.1,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          //
                          Text(
                            "Email Address",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.user.email,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Text(
                                      widget.user.website,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              SvgPicture.asset(
                                AppIcons.mmsIcon,
                                height: 24,
                                width: 24,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 0.1,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //
                          Text(
                            "Important Dates",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Birthday",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Text(
                                      "18th March",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              SvgPicture.asset(
                                AppIcons.birthdayIcon,
                                height: 24,
                                width: 24,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
