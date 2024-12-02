import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:labyrinth/data/providers/user_provider.dart';
import 'package:labyrinth/util/language_manager.dart';

class UserProfileButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? avatarUrl;

  const UserProfileButton({
    super.key,
    this.avatarUrl,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().currentUser;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: avatarUrl != null
                  ? NetworkImage(avatarUrl!)
                  : null, // Use avatarUrl if available
              backgroundColor: avatarUrl == null
                  ? Colors.grey
                  : Colors.white, // Placeholder color if no avatar
              child: avatarUrl == null
                  ? Icon(
                      Icons.person,
                      color: Colors.white,
                    )
                  : null, // Placeholder icon if no avatar
            ),
            SizedBox(width: 8),
            Text(
              user.isOnline
                  ? user.username
                  : '${user.username} [${LanguageManager.instance.translate('offline').toUpperCase()}]',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
