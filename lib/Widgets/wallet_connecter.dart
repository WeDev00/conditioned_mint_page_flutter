// ignore_for_file: avoid_print
// ignore: avoid_web_libraries_in_flutter
import 'dart:js_util';
import 'package:b_mint_page/Widgets/StateManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3_provider/ethereum.dart';
import 'package:provider/provider.dart';

class WalletConnectingButton extends StatefulWidget {
  const WalletConnectingButton({super.key});

  @override
  State<WalletConnectingButton> createState() => _WalletConnectingButtonState();
}

class _WalletConnectingButtonState extends State<WalletConnectingButton> {
  late StateManager stateManager;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    stateManager = Provider.of<StateManager>(context, listen: true);
    super.didChangeDependencies();
  }

  Future<void> onWalletConnect() async {
    if (ethereum != null) {
      Future<dynamic> promiseWallet =
          ethereum!.request(RequestParams(method: 'eth_requestAccounts'));

      dynamic ethAccount = await promiseToFuture(promiseWallet);
      String stringedEthAccount = ethAccount.toString();
      stateManager.setAddress(
          stringedEthAccount.substring(1, stringedEthAccount.length - 1));
    } else {
      print("Install Metamask");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[200],
            foregroundColor: Colors.green[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            )),
        onPressed: stateManager.isConnected ? () => {} : onWalletConnect,
        child: Text(
          stateManager.isConnected
              ? (stateManager.walletAddress.length > 18
                  ? '${stateManager.walletAddress.substring(0, 15)}...'
                  : stateManager.walletAddress)
              : 'Connect Wallet',
          style: const TextStyle(
            color: Colors.black,
          ),
        ));
  }
}
