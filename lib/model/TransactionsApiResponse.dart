import './Transaction.dart';

class TransactionsApiResponse {
  final int status;
  final String message;
  final List<Transaction> transactions;

  TransactionsApiResponse(
      {required this.status,
      required this.message,
      required this.transactions});

  factory TransactionsApiResponse.fromJson(Map<String, dynamic> fetchedJson) {
    return TransactionsApiResponse(
        status: int.parse(fetchedJson['status']),
        message: fetchedJson['message'],
        transactions: List<Transaction>.from(
          fetchedJson['result']
              .map((dynamic transaction) => Transaction.fromJson(transaction)),
        ));
  }
}
