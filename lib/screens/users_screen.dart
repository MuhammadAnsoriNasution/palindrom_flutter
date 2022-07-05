import 'package:flutter/material.dart';
import 'package:palindrome_flutter/models/user_model.dart';
import 'package:palindrome_flutter/providers/user_providers.dart';
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
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text("Users"),
        ),
        body: listViewSUers(
          scrollController,
          userProvider,
          fetchData,
          () {
            setState(() {
              page = 1;
            });
          },
        ));
  }
}
