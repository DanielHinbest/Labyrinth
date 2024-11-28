import 'package:flutter/material.dart';

class User {
  final String? username;
  final String? avatarUrl;
  final String? email;
  final String? membershipLevel;

  User({
    this.username,
    this.avatarUrl,
    this.email,
    this.membershipLevel,
  });
}

// TODO: Skeleton page, refine and what not
class UserProfileOverlay extends StatelessWidget {
  final User currentUser;

  const UserProfileOverlay({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context)
              .pop(), // Dismiss overlay when background is tapped
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: currentUser.avatarUrl != null
                              ? NetworkImage(currentUser.avatarUrl!)
                              : null,
                          child: currentUser.avatarUrl == null
                              ? Icon(Icons.person, size: 40)
                              : null,
                        ),
                        SizedBox(width: 10),
                        Text(
                          currentUser.username ?? 'User',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text('Email: ${currentUser.email ?? 'Not Provided'}'),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Add logic for account settings
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Account settings feature coming soon...')),
                        );
                      },
                      icon: Icon(Icons.settings),
                      label: Text('Account Settings'),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Add logout logic here
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Logged out successfully!')),
                        );
                      },
                      icon: Icon(Icons.logout),
                      label: Text('Log Out'),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close overlay
                      },
                      child: Text('Close'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

void showUserProfileOverlay(BuildContext context, User currentUser) {
  showDialog(
    context: context,
    builder: (context) {
      return UserProfileOverlay(currentUser: currentUser);
    },
  );
}
