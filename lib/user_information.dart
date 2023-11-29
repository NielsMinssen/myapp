import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/data_manager.dart';
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
            accountName: FutureBuilder<String>(
              future: FirestoreService().getFirstName(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text(
                      snapshot.data ?? 'No Name'); // Show name if loaded
                }
                return const Text(
                    'Loading...'); // Show loading text while waiting
              },
            ),
            accountEmail: Text(user?.email ?? 'No email'),
            currentAccountPicture: CircleAvatar(
              // Ensure we check for null or empty before accessing substring
              child: FutureBuilder<String>(
                future: FirestoreService().getFirstName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text(
                        snapshot.data ?? 'No Name'); // Show name if loaded
                  }
                  return const Text(
                      'Loading...'); // Show loading text while waiting
                },
              ),
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
