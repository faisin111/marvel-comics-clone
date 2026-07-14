import 'package:flutter/material.dart';

Widget infoRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Expanded(
          child: Text(title, style: const TextStyle(color: Colors.grey)),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget infoCard(IconData icon, String title, String value) {
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: const Color(0xff1B1D22),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.red.withOpacity(.15),
          child: Icon(icon, color: Colors.red),
        ),

        const SizedBox(width: 18),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.grey)),

              const SizedBox(height: 4),

              Text(
                value.isEmpty ? "-" : value,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
