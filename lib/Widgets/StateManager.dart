import 'package:flutter/material.dart';

class StateManager extends ChangeNotifier {
  late String walletAddress;
  bool isConnected = false;

  void setAddress(String newAddress) {
    walletAddress = newAddress;
    isConnected = newAddress.isNotEmpty;
    notifyListeners();
  }
}
