class Message {
  final String text;
  final String userId;
  final String username;
  final String userImageUrl;

  Message({
    required this.text,
    required this.userId,
    required this.username,
    required this.userImageUrl,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        text: json['text'],
        userId: json['user_id'],
        username: json['username'],
        userImageUrl: json['user_image_url'],
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'user_id': userId,
        'username': username,
        'user_image_url': userImageUrl,
      };
}
