import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:government_directory/utilities/ui_data.dart';
import 'package:validate/validate.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';

//shared preferences import
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginData {
  String username = '';
  String password = '';
}
const String _logged_in_key = 'loggedin';
const String _id_key = 'id';
const String _name_key = 'name';
const String _username_key = 'username';
const String _level_key = 'level';
const String _status_key = 'status';

class _LoginPageState extends State<LoginPage> {
  bool _logged_in;
  SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    print('runned');
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      preferences = sp;
      _logged_in = preferences.getBool(_logged_in_key);
      if(_logged_in == null){
        //set init value
        _logged_in = false;
        print('init auto log in');

        _auto_log_in(_logged_in);  //init here
      }else if(_logged_in == false){
        print('user not logged in');
      }else{
        //_remove_local_data(_logged_in_key);
        print('user logged in');
        print('logged in user is ${_get_local_data(_name_key)}');
      
      Navigator.pushReplacementNamed(context, '/home');
      }
    });

  }

  //init auto log in
  void _auto_log_in(bool value){
    setState((){
      _logged_in = value;
    });
    preferences?.setBool(_logged_in_key, value);
  }

  //remove pref data
  void _remove_local_data(String key){
    preferences?.remove(key);
  }

  //set pref data
  void _set_local_data(String key, String value){
    preferences?.setString(key, value);
  }

  //get pref data
  String _get_local_data(String key){
    return preferences?.getString(key);
  }

  _LoginData _data = new _LoginData();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String account_error = '';

  bool _is_in_async_call = false;

  void _alert_user(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: new Text('Account Error'),
          content: new Text(account_error),
          actions: <Widget>[
            new FlatButton(
              child: new Text('close'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  Future _login() async{
    setState((){
      //tell the app that we are now in the async call
      _is_in_async_call = true;
    });

    var data = jsonEncode({'action':'signin', 'username': _data.username, 'password': _data.password});

    //make call
    final response = await http.post('https://government.co.za/api/account', body: data);

    setState((){
      _is_in_async_call = false;
    });

    var result = response.body;
    var user = json.decode(response.body);

    //print(result);
    //rint(user);

    if(user['id'] == 'error'){
      setState((){
        account_error = user['account'];
      });

      //
      _alert_user();
    }else{
      print(user);
      //save user data here
      //enable auto log in her
      _auto_log_in(true);
      _set_local_data(_id_key, user['id']);
      _set_local_data(_name_key, user['name']);
      _set_local_data(_username_key, user['username']);
      _set_local_data(_level_key, user['level']);
      _set_local_data(_status_key, user['status']);

      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  String _validatePassword(String value) {
    if (value.length < 5) {
      return 'The Password must be atleast 5 characters.';
    }

    return null;
  }

  String _validateusername(String value) {
    if(value.length < 3){
      return 'username too short';
    }

    return null;
  }

  void submit() {
    //first validate form here
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();

      _login();

      print('printing the login data');
      print('username: ${_data.username}');
      print('Password: ${_data.password}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ModalProgressHUD(
        child: Center(
        child: login_body(),
       ),
       inAsyncCall: _is_in_async_call,
       opacity: 0.5,
       progressIndicator: CircularProgressIndicator(),
      ),
      
    );
  }

  login_body() => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[login_header(), login_fields()],
        ),
      );

  login_header() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            'assets/logo.png',
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            'Welcome to ${UiData.app_name}',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w200,
              color: Colors.green,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            'Sign in to continue',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      );

  login_fields() => Container(
        child: new Form(
          key: this._formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
                child: new TextFormField(
                  validator: this._validateusername,
                  onSaved: (String value) {
                    this._data.username = value;
                  },
                  maxLines: 1,
                  decoration: InputDecoration(
                      hintText: 'Enter Your username', labelText: 'Username'),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                child: new TextFormField(
                  validator: this._validatePassword,
                  onSaved: (String value) {
                    this._data.password = value;
                  },
                  maxLines: 1,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Password',
                    labelText: 'Password',
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                width: double.infinity,
                child: RaisedButton(
                  padding: EdgeInsets.all(12.0),
                  // shape: StadiumBorder(),
                  child: Text(
                    'SIGN IN',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.green,
                  onPressed: this.submit,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              new GestureDetector(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => SignUpPage()));
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                child: Text(
                  'SIGN UP FOR AN ACCCOUNT',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      );
}