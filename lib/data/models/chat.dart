class ChatRoomModel {
  final String senderId;
  final String senderImageUrl;
  final String content;
  final String dateTime;

  ChatRoomModel({
    required
     this.senderId,
    required this.senderImageUrl,
    required this.content,
    required this.dateTime,
  });

factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
  return 

  

  
  ChatRoomModel(senderId: senderId, senderImageUrl: senderImageUrl, content: content, dateTime: dateTime)
}

}