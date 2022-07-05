import 'package:flutter/material.dart';
import 'package:palindrome_flutter/screens/home_screen.dart';
import 'package:palindrome_flutter/them.dart';
import 'package:palindrome_flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController palindromeController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    bool isPalindrome() {
      String reverse = palindromeController.text.split('').reversed.join();
      if (reverse == palindromeController.text) {
        return true;
      }
      return false;
    }

    showSnackBar({required String message, required Color color}) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: color,
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    handleCheckPalindrome() {
      if (isPalindrome()) {
        showSnackBar(message: "isPalinDrom", color: primaryColor);
        return true;
      } else {
        showSnackBar(message: "not palindrome", color: Colors.red);
        return false;
      }
    }

    handleNext() {
      if (nameController.text == '') {
        return showSnackBar(message: "Name is required", color: Colors.red);
      } else if (!handleCheckPalindrome()) {
        return null;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              name: nameController.text,
            ),
          ),
        );
      }
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backgroundlogin.png"),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/iconadduserCircle.png",
              width: 116,
              height: 116,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 58,
            ),
            input(
              nameController,
              marginBottom: 22,
              placeholder: 'Name',
            ),
            input(
              palindromeController,
              placeholder: "Palindrome",
              marginBottom: 45,
            ),
            button(
              label: "CHECK",
              onTap: handleCheckPalindrome,
              marginBottom: 15,
            ),
            button(label: "NEXT", onTap: handleNext)
          ],
        ),
      ),
    );
  }
}
