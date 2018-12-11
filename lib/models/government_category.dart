import 'dart:convert';

Post postFromJson(String str){
final jsonData = json.decode(str);
return Post.fromjson(jsonData);
}

String postToJson(Post data){
  final dyn = data.toJson();
  return json.encode(dyn);
}

List<Post> allPostsFromJson(String str){
  final jsonData = json.decode(str);
  return new List<Post>.from(jsonData.Map((x) => Post.fromjson(x)));
  }

String allPostToJson(List<Post> data){
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Post {
  int userId;
  int id;
  String title;
  String body;

  Post({
    this.userId, 
    this.id, 
    this.title, 
    this.body
    });

  factory Post.fromjson(Map<String, dynamic> json) => new Post(
    userId: json['userId'],
    id: json['id'],
    title: json['title'],
    body: json['body'],
  );
  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id":id,
    "title":title,
    "body":body
  };
}