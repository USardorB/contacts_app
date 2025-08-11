import 'package:contacts_app/core/theme/app_colors.dart';
import 'package:contacts_app/core/theme/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddReminderPage extends StatelessWidget {
  const AddReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controllerContact = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text("New Reminder",
              style: AppFonts.regular20(
                  font: AppFontFamily.poppins, color: AppColors.black)),
          leading: IconButton(
            icon: Icon(Icons.close, size: 24..sp),
            onPressed: () => context.pop(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                context.pop();
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controllerContact,
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              // Container(
              //   height: 100,
              //   child: ListView.builder(
              //     physics: BouncingScrollPhysics(),
              //     scrollDirection: Axis.horizontal,
              //     itemCount: users.length > 5 ? 5 : users.length,
              //     itemBuilder: (context, index) {
              //       return Padding(
              //         padding: const EdgeInsets.only(right: 10),
              //         child: CircleAvatar(
              //           radius: 30,
              //           child: ClipOval(
              //             child: Image.network(
              //               NetworkServiceImpl.pictureUrl[
              //                   index % NetworkServiceImpl.pictureUrl.length],
              //               fit: BoxFit.cover,
              //               width: 60,
              //               height: 60,
              //               errorBuilder: (context, error, stackTrace) {
              //                 return Container(
              //                   width: 60,
              //                   height: 60,
              //                   color: Colors.grey.shade300,
              //                   child: Icon(Icons.person,
              //                       color: Colors.grey.shade600),
              //                 );
              //               },
              //             ),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
              24.verticalSpace,
              Text(
                "Details",
                style: AppFonts.semibold14(
                    color: AppColors.black.withValues(alpha: 0.5),
                    font: AppFontFamily.poppins),
              ),
              8.verticalSpace,
            ],
          ),
        ));
  }
}
