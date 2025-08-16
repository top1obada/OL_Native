import 'package:flutter/material.dart';

class WDAccountCard extends StatelessWidget {
  final String firstName;
  final int userId;
  final bool isActive;
  final ImageProvider? profileImage;

  const WDAccountCard({
    super.key,
    required this.firstName,
    required this.userId,
    required this.isActive,
    this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 28,
            backgroundImage: profileImage,
            backgroundColor: Colors.grey[400],
            child:
                profileImage == null
                    ? const Icon(Icons.person, size: 30, color: Colors.white)
                    : null,
          ),
          title: Text(
            'Hi $firstName',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'User ID: $userId',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                Text(
                  isActive ? 'Status: Active' : 'Status: Not Active',
                  style: TextStyle(
                    fontSize: 14,
                    color: isActive ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
