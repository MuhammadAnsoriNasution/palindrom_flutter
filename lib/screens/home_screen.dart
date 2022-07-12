import 'package:flutter/material.dart';
import 'package:palindrome_flutter/providers/profile_provider.dart';
import 'package:palindrome_flutter/screens/users_screen.dart';
import 'package:palindrome_flutter/screens/website_screen.dart';
import 'package:palindrome_flutter/them.dart';
import 'package:palindrome_flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final String name;
  const HomeScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);

    Widget empty() {
      return SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/userdefault.png",
              width: 164,
              height: 164,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Select a user to show the profile",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Color(0xff808080),
              ),
            )
          ],
        ),
      );
    }

    Widget profile() {
      return SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(164),
              child: Image.network(
                profileProvider.profile.avatar,
                width: 164,
                height: 164,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 53,
            ),
            Text(
              profileProvider.profile.name,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: secondary200Color),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              profileProvider.profile.email,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WebsiteScreen()));
              },
              child: const Text("Website"),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(color: primaryColor),
        ),
        centerTitle: true,
        backgroundColor: whiteColor,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: darkColor,
              ),
            ),
            Text(
              widget.name,
              style: TextStyle(
                fontSize: 18,
                color: darkColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: profileProvider.profile.name != '' ? profile() : empty(),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(10),
        child: button(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Userscreen()),
              );
            },
            label: 'Choose a user',
            marginBottom: 20),
      ),
    );
  }
}
