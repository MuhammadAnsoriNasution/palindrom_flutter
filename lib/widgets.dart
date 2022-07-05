import 'package:flutter/material.dart';
import 'package:palindrome_flutter/models/user_model.dart';
import 'package:palindrome_flutter/them.dart';

Widget input(controller, {double marginBottom = 0, String placeholder = ''}) {
  return Container(
    margin: EdgeInsets.only(bottom: marginBottom),
    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: placeholder,
      ),
      style: TextStyle(
        color: secondaryColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget button({
  String label = '',
  required Function onTap,
  double marginBottom = 0,
}) {
  return Container(
    height: 55,
    margin: EdgeInsets.only(
      bottom: marginBottom,
    ),
    decoration: BoxDecoration(
      color: primaryColor,
      borderRadius: BorderRadius.circular(12),
    ),
    width: double.infinity,
    child: Material(
      borderRadius: BorderRadius.circular(12),
      color: primaryColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          onTap();
        },
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: whiteColor),
          ),
        ),
      ),
    ),
  );
}

Widget cardUser(UserModel user) {
  return Card(
    child: InkWell(
      onTap: () {
        print("a");
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  user.avatar,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.firstName),
                Text(user.email),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
