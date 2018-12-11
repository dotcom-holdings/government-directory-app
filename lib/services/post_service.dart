import 'package:government_directory/models/government_category.dart';
import 'package:http/http.dart' as http;
String url = 'https://jsonplaceholder.typicode.com/posts';

Future<List<Post>> getAllPosts() async{
  final response = await http.get(url);
  print(response.body);
  return allPostsFromJson(response.body);
}

Future<Post> getPost() async{
  final response = await http.get('$url/1');
  return postFromJson(response.body);
}

Future <http.Response> createPost(Post post) async{
  final response = await http.post('$url', 
  body: postToJson(post) 
  );
  return response;
}