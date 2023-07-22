class Posts {
  final int id;
  final int userId;
  final String title;
  final String body;
  bool like = false;

  Posts({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Posts.fromMap({required Map data}) {
    return Posts(
      id: data['id'],
      userId: data['userId'],
      title: data['title'],
      body: data['body'],
    );
  }
}
