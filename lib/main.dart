import 'package:flutter/material.dart';
import 'package:validate/validate.dart';
void main() => runApp(new MaterialApp(
title: "Flutter",
home: new LoginPage(),
));

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
      // TODO: implement createState
      new _LoginPageState();
    }
}

class _LoginData{
  String email = '';
  String password = '';
}

class _LoginPageState extends State<LoginPage>{
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _LoginData _data = new _LoginData();

  String _validateEmail(String value){
    try{
      Validate.isEmail(value);
    }catch(e){
      return 'The E-mail address must be valid';
    }

    return null;
  }

  String _validatePassword(String value){
    if(value.length < 5){
      return 'The Password must be atleast 5 characters.';
      }

      return null;
  }

  void submit(){
    //first validate form here
    if(this._formKey.currentState.validate()){
      _formKey.currentState.save();

      print('printing the login data');
      print('Email: ${_data.email}');
      print('Password: ${_data.password}');
    }
  }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      final Size screenSize = MediaQuery.of(context).size;

      return new Scaffold(
        appBar: new AppBar(
          title: new Text('login'),
        ),
        body: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Form(
            key: this._formKey,
            child: new ListView(
              children: <Widget>[
                new TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: new InputDecoration(
                    hintText: 'you@example.com',
                    labelText: 'E-mail Address'
                  ),
                  validator: this._validateEmail,
                  onSaved: (String value){
                    this._data.email = value;
                  }
                ),
                
              ],
            ),
          ),
        ),
      );
    }


}