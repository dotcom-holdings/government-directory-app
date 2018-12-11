import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:government_directory/utilities/ui_data.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:validate/validate.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpData {
  String name;
  String user_name;
  String cellphone;
  String email;
  String password;
  String confirm_password;
}

class _SignUpPageState extends State<SignUpPage> {
  _SignUpData _data = new _SignUpData();
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

    Future _signup() async{
    setState((){
      //tell the app that we are now in the async call
      _is_in_async_call = true;
    });

    var data = jsonEncode({'action':'signup', 'username': _data.user_name, 'name': _data.name, 'email' : _data.email, 'phonenumber': _data.cellphone, 'password':_data.password});

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
        account_error = user['error'];
      });

      //
      _alert_user();
    }else{
      print(user);
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  String _validatePassword(String value) {
    if (value.length < 5) {
      this._data.password = value;

      return 'The Password must be atleast 5 characters.';
    }
    this._data.password = value;

    return null;
  }

  String _validateUsername(String value) {
    if(value.length < 1){
      return "UserName can't be empty";
    }

    return null;
  }

  String _validateName(String value) {
    if(value.length < 1){
      return "Name can't be empty";
    }

    return null;
  }

  String _validatePhoneNumber(String value) {
    if(value.length < 1){
      return "Phonenumber can't be empty";
    }
    return null;
  }

  String _validateConfirmPasssword(String value) {
    //print(this._data.password);
    if(value == ''){
      //print(this._data.password.toString());
      return 'Please confirm password';
    }else{
      if(this._data.password != value){
        return 'passwords are not the same';
      }else{
        return null;
      }
    }

    // if(value != ''){
    //   print('confirm password is not null');
    // }
    // if(this._data.password != value){
    //   return "Passwords are not the same";
    // }

    //return null;
  }

  String _validateEmail(String value) {
    try { 
      Validate.isEmail(value);
    } catch (e) {
      return 'The E-mail address must be valid';
    }

    return null;
  }

  void submit() {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();

      _signup();

      print('printing sign up datat');
      print('password ${_data.password}');
      print('confirm-password ${_data.confirm_password}');

    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ModalProgressHUD(
        child: Center(
        child: sign_up_body(),
      ),
      inAsyncCall: _is_in_async_call,
      opacity: 0.5,
      progressIndicator: CircularProgressIndicator(),
      )
    );
  }

  sign_up_body() => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[sign_up_header(), sign_up_fields()],
        ),
      );

  sign_up_header() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: 50.0,
          ),
          // FlutterLogo(
          //   colors: Colors.grey,
          //   size: 80.0,
          // ),
          Image.asset(
            'assets/logo.png',
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            'Welcome To ${UiData.app_name}',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w200,
              //color: Colors.green,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            'Create Account To Continue',
            //style: TextStyle(color: Colors.blueGrey),
          ),
        ],
      );

  sign_up_fields() => Container(
        child: new Form(
          key: this._formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                  //vertical: 8.0,
                  horizontal: 30.0,
                ),
                child: new TextFormField(
                  validator: this._validateName,
                  onSaved: (String value) {
                    this._data.name = value;
                  },
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Name',
                    labelText: 'Name',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  //vertical: 8.0,
                  horizontal: 30.0,
                ),
                child: new TextFormField(
                  validator: this._validateUsername,
                  onSaved: (String value) {
                    this._data.user_name = value;
                  },
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Enter UserName',
                    labelText: 'UserName',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  //vertical: 8.0,
                  horizontal: 30.0,
                ),
                child: new TextFormField(
                  validator: this._validatePhoneNumber,
                  onSaved: (String value) {
                    this._data.cellphone = value;
                  },
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Enter Phonenumber',
                    labelText: 'Phonenumber',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  //vertical: 8.0,
                  horizontal: 30.0,
                ),
                child: new TextFormField(
                  validator: this._validateEmail,
                  onSaved: (String value) {
                    this._data.email = value;
                  },
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  //vertical: 8.0,
                  horizontal: 30.0,
                ),
                child: new TextFormField(
                  obscureText: true,
                  validator: this._validatePassword,
                  onSaved: (String value) {
                    this._data.password = value;
                  },
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    labelText: 'Password',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  //vertical: 8.0,
                  horizontal: 30.0,
                ),
                child: new TextFormField(
                  obscureText: true,
                  validator: this._validateConfirmPasssword,
                  onSaved: (String value) {
                    this._data.confirm_password = value;
                  },
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Re-enter Password',
                    labelText: 'Confirm Password',
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                width: double.infinity,
                child: RaisedButton(
                  padding: EdgeInsets.all(12.0),
                  // shape: StadiumBorder(),
                  child: Text(
                    'CREATE ACCOUNT',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.purple,
                  onPressed: this.submit,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              new GestureDetector(
                onTap: (){
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text(
                'ALREADY HAVE AN ACCOUNT?',
                style: TextStyle(color: Colors.grey),
              ),
              ),
            ],
          ),
        ),
      );
}
