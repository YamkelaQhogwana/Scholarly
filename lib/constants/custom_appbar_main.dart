import 'package:flutter/material.dart';
import 'package:scholarly/constants/colors.dart';
import 'package:intl/intl.dart';

class CustomAppBarMain extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarMain({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateFormat = DateFormat('MMMM dd, yyyy');

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      toolbarHeight: 100,
      automaticallyImplyLeading: false,
      title: SizedBox(
        height: 60,
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage:
                  AssetImage('assets/images/avatars/black-wn-av.png'),
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.kSecondaryText,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: dateFormat.format(now),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'This Week',
                  style: TextStyle(
                    fontSize: 25,
                    color: AppColors.kMainText,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Remove the commented IconButton widget
          ],
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.kMainText, // Change the menu icon color here
      ),
    );
  }
}

