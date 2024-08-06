class ChatModel {
  const ChatModel({
    required this.id,
    required this.createdAt,
    required this.createdBy,
  });

  final String id;
  final DateTime createdAt;
  final String createdBy;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'createdBy': createdBy,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      createdBy: map['createdBy'] as String,
    );
  }
}
