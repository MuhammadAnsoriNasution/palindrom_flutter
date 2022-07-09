import 'package:flutter/material.dart';
import 'package:palindrome_flutter/providers/user_providers.dart';
import 'package:palindrome_flutter/maps.dart';
import 'package:palindrome_flutter/them.dart';
import 'package:palindrome_flutter/widgets.dart';
import 'package:provider/provider.dart';

class Userscreen extends StatefulWidget {
  const Userscreen({Key? key}) : super(key: key);

  @override
  State<Userscreen> createState() => _UserscreenState();
}

class _UserscreenState extends State<Userscreen> {
  int page = 1;
  ScrollController scrollController = ScrollController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool modeList = false;

  @override
  void initState() {
    super.initState();
    fetchData(page);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    scaffoldKey.currentState?.dispose();
  }

  fetchData(int page) {
    Provider.of<UserProvider>(context, listen: false).getusers(page: page);
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (page <= userProvider.totalPage) {
          setState(() {
            page++;
          });
          userProvider.loading = true;
          fetchData(page);
        }
      }
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: whiteColor,
        title: Text(
          "Users",
          style: TextStyle(color: primaryColor),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                modeList = !modeList;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Image.asset(
                modeList ? "assets/show_map.png" : 'assets/ic_show_list.png',
                height: 24,
                width: modeList ? 18 : 24,
              ),
            ),
          ),
        ],
      ),
      body: modeList
          ? listViewSUers(scrollController, userProvider, fetchData, () {
              setState(() {
                page = 1;
              });
            })
          : const Maps(),
    );
  }
}
