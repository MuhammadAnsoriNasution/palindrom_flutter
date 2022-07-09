import 'package:flutter/material.dart';
import 'package:palindrome_flutter/models/profile_model.dart';
import 'package:palindrome_flutter/models/user_model.dart';
import 'package:palindrome_flutter/providers/profile_provider.dart';
import 'package:palindrome_flutter/providers/user_providers.dart';
import 'package:palindrome_flutter/screens/home_screen.dart';
import 'package:palindrome_flutter/them.dart';
import 'package:provider/provider.dart';

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

alertDialog(UserModel user, BuildContext context) {
  ProfileProvider profileProvider =
      Provider.of<ProfileProvider>(context, listen: false);

  return AlertDialog(
    alignment: Alignment.bottomCenter,
    contentPadding: const EdgeInsets.all(10),
    insetPadding: EdgeInsets.zero,
    scrollable: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32.0),
        topRight: Radius.circular(32.0),
      ),
    ),
    content: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(150),
            child: Image.network(
              user.avatar,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            '${user.firstName} ${user.lastName}',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 33,
          ),
        ],
      ),
    ),
    actions: [
      button(
          onTap: () {
            profileProvider.profile = ProfileModel(
              avatar: user.avatar,
              name: '${user.firstName} ${user.lastName}',
              email: user.email,
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const HomeScreen(name: '')),
              (Route<dynamic> route) => false,
            );
          },
          label: 'Select')
    ],
  );
}

Widget cardUser(UserModel user, BuildContext context) {
  return Card(
    child: InkWell(
      onTap: () => showDialog<String>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (BuildContext context) => alertDialog(user, context),
      ),
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

Widget listViewSUers(ScrollController scrollController,
    UserProvider userProvider, Function fetchData, Function setState) {
  return RefreshIndicator(
    child: ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: userProvider.users.length + 1,
      itemBuilder: (BuildContext ctx, int index) {
        if (index == userProvider.users.length) {
          return Visibility(
            visible: userProvider.loading,
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
          );
        }

        UserModel user = userProvider.users[index];
        return cardUser(user, ctx);
      },
    ),
    onRefresh: () {
      return Future.delayed(
        const Duration(seconds: 1),
        () {
          setState();
          userProvider.loading = true;
          fetchData();
        },
      );
    },
  );
}
