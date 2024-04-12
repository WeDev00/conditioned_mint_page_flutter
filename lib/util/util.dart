import 'package:b_mint_page/model/BlockApiResponse.dart';
import 'package:b_mint_page/model/TransactionsApiResponse.dart';
import '../model/Transaction.dart';
import 'dart:convert';
import 'package:flutter_web3_provider/ethers.dart';
import 'package:flutter_web3_provider/ethereum.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter_ethers/flutter_ethers.dart' as ethers;

String buildGetBlockEndpoint() {
  const startString =
      "https://api.etherscan.io/api?module=block&action=getblocknobytime&timestamp=";
  const endString = "&closest=before&apikey=23MMB13RF76FJWX7D8621T4Z3K5S9EXVPV";
  DateTime now = DateTime.now();
  int millisecondsSinceEpoch = now.millisecondsSinceEpoch;
  double timestamp = (millisecondsSinceEpoch - 86400000) / 1000;
  int floorTimestamp = timestamp.floor();
  return startString + floorTimestamp.toString() + endString;
}

String buildGetTransactionEndpoint(int block, String address) {
  final startString =
      "https://api.etherscan.io/api?module=account&action=txlist&address=$address&startblock=";
  const endString =
      "&endblock=99999999&page=1&offset=10&sort=asc&apikey=23MMB13RF76FJWX7D8621T4Z3K5S9EXVPV";

  return startString + block.toString() + endString;
}

Future<int> fetchBlockByTimestamp() async {
  final String apiUrl = buildGetBlockEndpoint();
  final response = await http.get(Uri.parse(apiUrl));
  final jsonResponse = jsonDecode(response.body);
  BlockApiResponse blockApiResponse = BlockApiResponse.fromJson(jsonResponse);

  return blockApiResponse.block;
}

Future<List<Transaction>> fetchTransactions(int block,
    {String address = "0xAF429255F21BC80104fcC0e0Fdb1Bf45b48f86Bd"}) async {
  final endpoint = buildGetTransactionEndpoint(block, address);
  final response = await http.get(Uri.parse(endpoint));
  final jsonResponse = jsonDecode(response.body);
  TransactionsApiResponse transactionsApiResponse =
      TransactionsApiResponse.fromJson(jsonResponse);
  return transactionsApiResponse.transactions;
}

bool validateTransactions(List<Transaction> transactions) {
  if (transactions.isEmpty) return false;
  final uniswapRouterV2Address =
      "0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D".toLowerCase();
  transactions
      .removeWhere((element) => !identical(element.to, uniswapRouterV2Address));
  return transactions.isNotEmpty;
}

void mint() async {
  print("Sono nel mint");
}
