import 'package:flutter/material.dart';
import 'package:government_directory/utilities/ui_data.dart';
import 'package:validate/validate.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginData {
  String username = '';
  String password = '';
}

class _LoginPageState extends State<LoginPage> {
  _LoginData _data = new _LoginData();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

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

      print('printing the login data');
      print('username: ${_data.username}');
      print('Password: ${_data.password}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: login_body(),
      ),
      backgroundColor: Colors.white,
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