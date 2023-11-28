import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/login.dart';

class UserInformationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user != null && user.displayName != null && user.displayName!.isNotEmpty
                ? user.displayName!
                : 'Guest'),
            accountEmail: Text(user?.email ?? 'No email'),
            currentAccountPicture: CircleAvatar(
              // Ensure we check for null or empty before accessing substring
              child: Text(user != null && user.displayName != null && user.displayName!.isNotEmpty
                  ? user.displayName!.substring(0, 1)
                  : 'G'),
            ),
            // Optional: Provide an additional decoration if needed
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  ); // Close the drawer
            },
          ),
          // ... add other list tiles for navigation
        ],
      ),
    );
  }
}
