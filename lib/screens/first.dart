// ignore_for_file: avoid_print
import 'package:b_mint_page/Widgets/minter.dart';
import 'package:flutter/material.dart';
import '../Widgets/wallet_connecter.dart';

class First extends StatefulWidget {
  const First({super.key, required this.title});
  final String title;
  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Scrollbar(
          controller: _scrollController,
          child: const SingleChildScrollView(
            child: SizedBox(
              height: 700,
              width: 1290,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(54),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [WalletConnectingButton()],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(32, 80, 16, 5),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: MinterButton(),
                          )
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(image: AssetImage('MpDev_logo.png')),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
