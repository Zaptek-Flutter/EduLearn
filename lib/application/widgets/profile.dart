import 'package:edulearn/authentication/signout_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget {

  const Profile({super.key});

 void _signOut(BuildContext context) {
    // Call the SignOutService to show confirmation and handle sign-out
    SignOutService.signOutWithConfirmation(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5), 
      child: SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.blue),
                  title: Text('Profile', style: GoogleFonts.inter(color: Colors.blue)),
                  onTap: () {
                    // Implement navigation to the profile page if needed
                    Navigator.of(context).pop();
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: Text('Sign out', style: GoogleFonts.inter(color: Colors.red, )),
                  onTap: () => _signOut(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}