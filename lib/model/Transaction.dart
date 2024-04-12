class Transaction {
  final int blockNumber;
  final int timeStamp;
  final String hash;
  final int nonce;
  final String blockHash;
  final int transactionIndex;
  final String from;
  final String to;
  final int value;
  final int gas;
  final int gasPrice;
  final bool isError;
  final int txreceiptStatus;
  final String input;
  final String contractAddress;
  final int cumulativeGasUsed;
  final int gasUsed;
  final int confirmations;
  final String methodId;
  final String functionName;

  Transaction(
      {required this.blockNumber,
      required this.timeStamp,
      required this.hash,
      required this.nonce,
      required this.blockHash,
      required this.transactionIndex,
      required this.from,
      required this.to,
      required this.value,
      required this.gas,
      required this.gasPrice,
      required this.isError,
      required this.txreceiptStatus,
      required this.input,
      required this.contractAddress,
      required this.cumulativeGasUsed,
      required this.gasUsed,
      required this.confirmations,
      required this.methodId,
      required this.functionName});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    /*json.keys.forEach((element) =>
        print('$element:' + json[element] + "\n\n-----------------"));*/
    return Transaction(
        blockNumber: int.parse(json['blockNumber']),
        timeStamp: int.parse(json['timeStamp']),
        hash: json['hash'],
        nonce: int.parse(json['nonce']),
        blockHash: json['blockHash'],
        transactionIndex: int.parse(json['transactionIndex']),
        from: json['from'],
        to: json['to'],
        value: int.parse(json['value']),
        gas: int.parse(json['gas']),
        gasPrice: int.parse(json['gasPrice']),
        isError: int.parse(json['isError']) != 0,
        txreceiptStatus: int.parse(json['txreceipt_status']),
        input: json['input'],
        contractAddress: json['contractAddress'],
        cumulativeGasUsed: int.parse(json['cumulativeGasUsed']),
        gasUsed: int.parse(json['gasUsed']),
        confirmations: int.parse(json['confirmations']),
        methodId: json['methodId'],
        functionName: json['functionName']);
  }

  /*factory Transaction.fromJsonList(Map<String, dynamic> json) {}
  List<Transaction> fromJson(){

  }*/
}
