class MessageModel {
  String messageId;
  String senderUsername;
  String text;
  DateTime timestamp;
  String messageType; // "sent" or "received"

  MessageModel({
    required this.messageId,
    required this.senderUsername,
    required this.text,
    required this.timestamp,
    required this.messageType,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messageId: json['messageId'],
      senderUsername: json['senderUsername'],
      text: json['text'],
      timestamp: json['timestamp'].toDate(),
      messageType: json['messageType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'senderUsername': senderUsername,
      'text': text,
      'timestamp': timestamp,
      'messageType': messageType,
    };
  }
}
