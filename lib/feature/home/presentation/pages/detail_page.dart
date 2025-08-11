import 'package:contacts_app/core/constants/app_icons.dart';
import 'package:contacts_app/feature/home/data/models/user_model.dart';
import 'package:contacts_app/feature/auth/presentation/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailPage extends StatefulWidget {
  final UserModel user;
  final String imageUrl;

  const DetailPage({
    super.key,
    required this.user,
    required this.imageUrl,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: IconButton(
          icon: SvgPicture.asset(
            AppIcons.backButton,
            fit: BoxFit.cover,
            height: 45,
            width: 45,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      title: const Text("Contact Details"),
      actions: [
        IconButton(
          icon: SvgPicture.asset(AppIcons.noteIcon),
          onPressed: () {
            // TODO: Implement note functionality
            _showSnackBar('Note functionality coming soon!');
          },
        ),
        const SizedBox(width: 15),
      ],
    );
  }

  Widget _buildBody() {
    return ListView(
      padding: const EdgeInsets.only(top: 40),
      children: [
        _buildProfileSection(),
        const SizedBox(height: 30),
        _buildActionButtons(),
        const Divider(thickness: 0.1, color: Colors.grey),
        _buildContactDetails(),
      ],
    );
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        CircleAvatar(
          radius: 100,
          child: ClipOval(
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
              width: 220,
              height: 220,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 220,
                  height: 220,
                  color: Colors.grey.shade300,
                  child: Icon(
                    Icons.person,
                    color: Colors.grey.shade600,
                    size: 80,
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          widget.user.name,
          style: const TextStyle(fontSize: 22),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MyButton(
          onTap: () => _showSnackBar('Message functionality coming soon!'),
          imagePath: AppIcons.smsIcon,
          text: "Message",
        ),
        MyButton(
          onTap: () => _showSnackBar('Call functionality coming soon!'),
          imagePath: AppIcons.phoneIcon,
          text: "Call",
        ),
        MyButton(
          onTap: () => _showSnackBar('Email functionality coming soon!'),
          imagePath: AppIcons.mmsIcon,
          text: "Email",
        ),
      ],
    );
  }

  Widget _buildContactDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailSection(
            title: "Phone Numbers",
            value: "+ ${widget.user.phone}",
            subtitle: widget.user.address.street,
            icon: AppIcons.phoneIcon,
          ),
          _buildDetailSection(
            title: "Email Address",
            value: widget.user.email,
            subtitle: widget.user.website,
            icon: AppIcons.mmsIcon,
          ),
          _buildDetailSection(
            title: "Important Dates",
            value: "Birthday",
            subtitle: "18th March",
            icon: AppIcons.birthdayIcon,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection({
    required String title,
    required String value,
    required String subtitle,
    required String icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              icon,
              height: 24,
              width: 24,
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (title != "Important Dates")
          const Divider(thickness: 0.1, color: Colors.grey),
        if (title != "Important Dates") const SizedBox(height: 10),
      ],
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
