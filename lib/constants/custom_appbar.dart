import 'package:flutter/material.dart';
import 'package:scholarly/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ci.dart';
import 'package:scholarly/screens/main_screen_menu.dart';
// import 'package:scholarly/screens/menu_stats.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final monthFormat = DateFormat('MMMM');
    final yearFormat = DateFormat('yyyy');

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
                      fontSize: 25,
                      color: AppColors.kMainText,
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      TextSpan(
                        text: monthFormat.format(now),
                      ),
                      const TextSpan(
                        text: ' ',
                        style: TextStyle(color: Colors.transparent),
                      ),
                      TextSpan(
                        text: yearFormat.format(now),
                        style: const TextStyle(color: AppColors.kDarkGray),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Let\'s be productive this month!',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.kSecondaryText,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuPage()),
                );
                print('Menu button pressed');
              },
              icon: const Iconify(
                Ci.menu_alt_05,
                color: AppColors.kMainText,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
