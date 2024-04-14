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
  const String deployedNftContractAddress =
      "0x052943BD44E2B1a9c24DA60B8c24c5952707FA53";
  const String tideNftAbi =
      '[{"inputs":[{"internalType":"uint256","name":"_tokenCounter","type":"uint256"}],"stateMutability":"nonpayable","type":"constructor"},{"inputs":[{"internalType":"address","name":"sender","type":"address"},{"internalType":"uint256","name":"tokenId","type":"uint256"},{"internalType":"address","name":"owner","type":"address"}],"name":"ERC721IncorrectOwner","type":"error"},{"inputs":[{"internalType":"address","name":"operator","type":"address"},{"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"ERC721InsufficientApproval","type":"error"},{"inputs":[{"internalType":"address","name":"approver","type":"address"}],"name":"ERC721InvalidApprover","type":"error"},{"inputs":[{"internalType":"address","name":"operator","type":"address"}],"name":"ERC721InvalidOperator","type":"error"},{"inputs":[{"internalType":"address","name":"owner","type":"address"}],"name":"ERC721InvalidOwner","type":"error"},{"inputs":[{"internalType":"address","name":"receiver","type":"address"}],"name":"ERC721InvalidReceiver","type":"error"},{"inputs":[{"internalType":"address","name":"sender","type":"address"}],"name":"ERC721InvalidSender","type":"error"},{"inputs":[{"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"ERC721NonexistentToken","type":"error"},{"inputs":[{"internalType":"address","name":"owner","type":"address"}],"name":"OwnableInvalidOwner","type":"error"},{"inputs":[{"internalType":"address","name":"account","type":"address"}],"name":"OwnableUnauthorizedAccount","type":"error"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"owner","type":"address"},{"indexed":true,"internalType":"address","name":"approved","type":"address"},{"indexed":true,"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"Approval","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"owner","type":"address"},{"indexed":true,"internalType":"address","name":"operator","type":"address"},{"indexed":false,"internalType":"bool","name":"approved","type":"bool"}],"name":"ApprovalForAll","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"previousOwner","type":"address"},{"indexed":true,"internalType":"address","name":"newOwner","type":"address"}],"name":"OwnershipTransferred","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"from","type":"address"},{"indexed":true,"internalType":"address","name":"to","type":"address"},{"indexed":true,"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"Transfer","type":"event"},{"inputs":[{"internalType":"address","name":"to","type":"address"},{"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"approve","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"owner","type":"address"}],"name":"balanceOf","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"burn","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"getApproved","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"owner","type":"address"},{"internalType":"address","name":"operator","type":"address"}],"name":"isApprovedForAll","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"to","type":"address"}],"name":"mint","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"name","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"ownerOf","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"renounceOwnership","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"from","type":"address"},{"internalType":"address","name":"to","type":"address"},{"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"safeTransferFrom","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"from","type":"address"},{"internalType":"address","name":"to","type":"address"},{"internalType":"uint256","name":"tokenId","type":"uint256"},{"internalType":"bytes","name":"data","type":"bytes"}],"name":"safeTransferFrom","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"operator","type":"address"},{"internalType":"bool","name":"approved","type":"bool"}],"name":"setApprovalForAll","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes4","name":"interfaceId","type":"bytes4"}],"name":"supportsInterface","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"symbol","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"tokenCounter","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"tokenURI","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"from","type":"address"},{"internalType":"address","name":"to","type":"address"},{"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"transferFrom","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"stateMutability":"nonpayable","type":"function"}]';
  List<String> tideNftAbiListed =
      tideNftAbi.substring(2, tideNftAbi.length - 1).split(',{');
  for (int i = 0; i < tideNftAbiListed.length; i++) {
    tideNftAbiListed[i] =
        tideNftAbiListed[i].substring(0, tideNftAbiListed[i].length - 1);
  }
  final Web3Provider provider = Web3Provider(ethereum!);
  final Signer signer = provider.getSigner();
  print(signer);
  final Contract contract =
      Contract(deployedNftContractAddress, tideNftAbiListed, signer);
  final symbol = await contract.symbol();
  print(symbol);
}
