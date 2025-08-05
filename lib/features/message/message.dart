final class Message {
  Message({required this.title, required this.body});
  final String title;
  final String body;

  factory Message.fromJson(Map<String, dynamic> data) {
    final title = data['title'] as String;
    final body = data['body'] as String;
    return Message(title: title, body: body);
  }

  Map<String, dynamic> toJson() => {'title': title, 'body': body};
}
