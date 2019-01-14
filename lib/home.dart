import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:government_directory/add_advert.dart';
import 'package:government_directory/search_page.dart';
import 'models/government_category.dart';
import 'package:http/http.dart' as http;
import 'services/post_service.dart';
import 'list_view_posts.dart';
import 'models/GovCategory.dart';
import 'GovCategory_list_tile.dart';
//shared preferences import
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget{

@override
_HomePageState createState() => _HomePageState();
}
const String _logged_in_key = 'loggedin';
class _HomePageState extends State<HomePage>{
    bool _logged_in;

    final GlobalKey<ScaffoldState> _scaffold_key = new GlobalKey<ScaffoldState>();
  
  SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    print('runned');
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      preferences = sp;
    });
  }

  callApi(){
    Post post = Post(
      body: 'i am simphiwe hlabisa',
      title: 'sshlabisa'
    );

    createPost(post).then((response){
      if(response.statusCode > 200){
        print(response.body);
      }else{
        print(response.statusCode);
      }
    }).catchError((error){
      print('error : $error');
    });
  }

  Future<List<Post>> get_all_posts(http.Client client) async{
    final response = await client.get('https://jsonplaceholder.typicode.com/posts');
    return compute(parsePosts, response.body);
  }

  static List<Post> parsePosts(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Post>((json) => Post.fromjson(json)).toList();
  }

  //get all government posts from api call
  Future<List<GovCategory>> get_all_categories(http.Client client) async{
    final response = await client.get('https://government.co.za/api/government_categories');
    print(response.body);
    
    return compute(parse_category, response.body);
  }

  static List<GovCategory> parse_category(String responseBody){
    final parsed_data = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed_data.map<GovCategory>((json) => GovCategory.fromjson(json)).toList();
  }
    //remove pref data
  void _remove_local_data(String key){
    preferences?.remove(key);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(

      // appBar: AppBar(
      //   title: Text('Home'),
      // ),
      // body: Center(
      //   child: Text('welcome home'),
      // ),
      key: _scaffold_key,
      body: NestedScrollView(
        
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.green,
              expandedHeight: 100.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text('GOVERNMENT DIRECTORY',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  fontSize: 16.0,
                ),),
                // background: Image.network(
                //   "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                //   fit: BoxFit.cover,
                // ),
              ), 
            )
          ];
        },
        //for getting posts
        // body: FutureBuilder<List<Post>>(
        //   future: get_all_posts(http.Client()),
          body: FutureBuilder<List<GovCategory>>(
            
          future: get_all_categories(http.Client()),
          builder: (context, snapshot){
            //callApi();
              if(snapshot.hasError){
                print(snapshot.error);
              }
              //for posts
              // return snapshot.hasData
              //     ? ListViewPosts(posts: snapshot.data)
              //     : Center(child: CircularProgressIndicator());
                  return snapshot.hasData
                  ? GovCategory_list_tile(gov_categories : snapshot.data)
                  : Center(child: CircularProgressIndicator());
          },
        ),
        // Center(
        //   child: Text('welcome home'),
        ),
        bottomNavigationBar: new BottomAppBar(
          //color: Colors.green,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new IconButton(icon: new Icon(Icons.menu),onPressed: (){
                // showModalBottomSheet<void>(
                //   context: context,
                //   builder: (BuildContext context) => const _appDrawer(),
                // );

                _app_menu(context);
              },),
              new IconButton(icon: new Icon(Icons.search),onPressed: (){
                print('home search pressed');
                //Map result = await Navigator.push(context, MaterialPageRoute(builder: (context) => company_page(company: company, old_context: context,)));
                //Navigator.pushNamed(context, '/search');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => search_page(old_context: context)));
              },),
            ],
          ),
        ),
    );
  }

  void _app_menu(BuildContext context){
      showModalBottomSheet<void>(
      
      context: context,
      builder: (BuildContext context){
           return    new   Column(
             mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // ListTile(
          //   leading: Icon(Icons.favorite),
          //   title: Text('Favourites'),
          //   onTap: (){
          //     print('favourites tabed');
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.videocam),
            title: Text('Video Channel'),
            onTap: (){
              print('video channel tabbed');
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add a free adds'),
            onTap: (){
              print('add free add tabed');
              Navigator.push(context, MaterialPageRoute(builder: (context) => add_advert()));

            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: (){
              print('log out tabed');
              _remove_local_data(_logged_in_key);
              Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
              //exit(0);
            },
          )
        ],
      );
      },


    );
  }
}

class _appDrawer extends StatelessWidget{
  const _appDrawer();

  @override
  Widget build(BuildContext context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
            child: Container(
        color: Colors.green,
        child:       Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favourites'),
            onTap: (){
              print('favourites tabed');
            },
          ),
          ListTile(
            leading: Icon(Icons.videocam),
            title: Text('Video Channel'),
            onTap: (){
              print('video channel tabbed');
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add a free adds'),
            onTap: (){
              print('add free add tabed');
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: (){
              print('log out tabed');
            },
          )
        ],
      ),
      );
      },


    );
  }
}