import 'package:flutter/material.dart';
import 'package:palindrome_flutter/screens/users_screen.dart';
import 'package:palindrome_flutter/them.dart';
import 'package:palindrome_flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  final String name;
  const HomeScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
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
              child: empty(),
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
