import 'package:flutter/material.dart';
import 'package:validate/validate.dart';

//importing the helpers or utilities
import 'utilities/ui_data.dart';

//importing login page here
import 'pages/login_page.dart';

void main() => runApp(new MaterialApp(
      title: "Flutter",
      home: new LoginPage(),
    ));

class LoginPageq extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginData {
  String email = '';
  String password = '';
}

class _LoginPageState extends State<LoginPageq> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _LoginData _data = new _LoginData();

  String _validateEmail(String value) {
    try {
      Validate.isEmail(value);
    } catch (e) {
      return 'The E-mail address must be valid';
    }

    return null;
  }

  String _validatePassword(String value) {
    if (value.length < 5) {
      return 'The Password must be atleast 5 characters.';
    }

    return null;
  }

  void submit() {
    //first validate form here
    if (this._formKey.currentState.validate()) {
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
      
      //remove appbar here
      // appBar: new AppBar(
      //   title: new Text('login'),
      // ),

      // body: new Container(
      //   padding: new EdgeInsets.all(20.0),
      //   child: new Form(
      //     key: this._formKey,
      //     child: new ListView(
      //       children: <Widget>[
      //         new TextFormField(
      //             keyboardType: TextInputType.emailAddress,
      //             decoration: new InputDecoration(
      //                 hintText: 'you@example.com', labelText: 'E-mail Address'),
      //             validator: this._validateEmail,
      //             onSaved: (String value) {
      //               this._data.email = value;
      //             }),
      //         new TextFormField(
      //           obscureText: true,
      //             decoration: new InputDecoration(
      //                 hintText: 'Password', labelText: 'Enter your password'),
      //             validator: this._validatePassword,
      //             onSaved: (String value) {
      //               this._data.password = value;
      //             }),
      //             new Container(
      //               width: screenSize.width,
      //               child: new RaisedButton(
      //                 child: new Text(
      //                   'Login',
      //                   style: new TextStyle(
      //                     color: Colors.white
      //                   ),
      //                 ),
      //                 onPressed: this.submit,
      //                 color: Colors.blue,
      //               ),
      //               margin: new EdgeInsets.only(
      //                 top: 20.0
      //               ),
      //             )
      //       ],
      //     ),
      //   ),
      // ),

      body: Center(
        child: login_body(),
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
      FlutterLogo(
        colors: Colors.green,
        size: 80.0,
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        'Welcome to ${UiData.app_name}',
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
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
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
          child: TextField(
            maxLines: 1,
            decoration: InputDecoration(
              hintText: 'enter your email',
              labelText: 'email'
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
          child: TextField(
            maxLines: 1,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'enter your password',
              labelText: 'password',
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
            onPressed: (){},
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          'SIGN UP FOR AN ACCCOUNT',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    ),
  );
}
