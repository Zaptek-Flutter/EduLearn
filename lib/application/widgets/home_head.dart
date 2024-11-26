// ignore_for_file: avoid_print

import 'package:edulearn/application/widgets/profile.dart';
import 'package:edulearn/application/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeHead extends StatelessWidget {
  const HomeHead({super.key});

  // Function to show the profile when tapped
  void _showProfileModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const Profile();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(child: Image.asset('assets/images/appheader.png')),
          Positioned(
            top: 35,
            left: 15,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Image.asset(
                    'assets/icons/back.png',
                    width: 30,
                  ),
                ),
                const SizedBox(width: 2),
                Text(
                  'Back',
                  style: GoogleFonts.roboto(
                    color: const Color.fromRGBO(230, 126, 34, 1),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 35,
            right: 85,
            child: GestureDetector(
                onTap: () => print('Notifications'),
                child: Image.asset(
                  'assets/icons/notification.png',
                  width: 24,
                )),
          ),
          Positioned(
            top: 35,
            right: 35,
            child: GestureDetector(
                onTap: () => _showProfileModal(context),
                child: Image.asset(
                  'assets/icons/user.png',
                  width: 24,
                  color: Colors.orange,
                )),
          ),
          const Positioned(
            top: 105,
            left: 15,
            child: Search(),
          )
        ],
      ),
    );
  }
}