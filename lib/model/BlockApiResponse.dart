class BlockApiResponse {
  final int status;
  final String message;
  final int block;

  BlockApiResponse(
      {required this.status, required this.message, required this.block});

  factory BlockApiResponse.fromJson(Map<String, dynamic> json) {
    return BlockApiResponse(
      status: int.parse(json['status']),
      message: json['message'],
      block: int.parse(json['result']),
    );
  }
}
