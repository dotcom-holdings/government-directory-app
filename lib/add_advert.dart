import 'package:flutter/material.dart';

class add_advert extends StatefulWidget{
  
  @override
  _add_advert createState() => _add_advert();
}

class _add_advert extends State<add_advert>{
  //form controllers
static TextEditingController _name_controller = new TextEditingController();
TextEditingController _physical_address_controller = new TextEditingController();
TextEditingController _postal_address_controller = new TextEditingController();
TextEditingController _telephone_number_controller = new TextEditingController();
TextEditingController _mobile_number_controller = new TextEditingController();
TextEditingController _fax_number_controller = new TextEditingController();
TextEditingController _email_address_controller = new TextEditingController();
TextEditingController _company_website_controller = new TextEditingController();
TextEditingController _about_us_controller = new TextEditingController();
TextEditingController _category_controller = new TextEditingController();
TextEditingController _province_controller = new TextEditingController();

  static final _form_key = GlobalKey<FormState>();
  var _form_view  = Container(
    //color: Colors.grey.shade300,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(8.0),
    child: SingleChildScrollView(
      child: Form(
        key: _form_key,
        child: Column(
          children: <Widget>[
            _name_field(),
            _physical_address_field(),
            _postal_address_field(),
            _telephone_number_field(),
            _mobile_number_field(),
            _fax_number_field(),
            _email_address_field(),
            _company_website_field(),
            _about_us_field(),
            _category_field(),
            _province_field(),

            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: submit_advert(),
            ),
          ],
        ),
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Add Advert'.toUpperCase(), style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.0),),
      backgroundColor: Colors.green,
      ),
      body: _form_view,
    );
  }

static RaisedButton submit_advert(){
  return RaisedButton(
    onPressed: (){},
    color: Colors.pinkAccent,
    child: Text('Submit Advert',
    style: TextStyle(
      fontSize: 16.9,
      
    ),
    ),
    textColor: Colors.white,
  );
}

static TextFormField _name_field(){
  return TextFormField(
    controller: _name_controller,
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,

    decoration: InputDecoration(
      labelText: 'Business Name',
      hintText: 'Business Name',
      icon: Icon(Icons.next_week),
      fillColor: Colors.grey
    ),
  );
}

static TextFormField _physical_address_field(){
  return TextFormField(
    controller: _name_controller,
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,

    decoration: InputDecoration(
      labelText: 'Physical Address',
      hintText: 'Physical Address',
      icon: Icon(Icons.add_location),
      fillColor: Colors.grey
    ),
  );
}

static TextFormField _postal_address_field(){
  return TextFormField(
    controller: _name_controller,
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,

    decoration: InputDecoration(
      labelText: 'Postal Address',
      hintText: 'Postal Address',
      icon: Icon(Icons.mail_outline),
      fillColor: Colors.grey
    ),
  );
}

static TextFormField _telephone_number_field(){
  return TextFormField(
    controller: _name_controller,
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,

    decoration: InputDecoration(
      labelText: 'Telephone Number',
      hintText: 'Telephone Number',
      icon: Icon(Icons.local_phone),
      fillColor: Colors.grey
    ),
  );
}

static TextFormField _mobile_number_field(){
  return TextFormField(
    controller: _name_controller,
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,

    decoration: InputDecoration(
      labelText: 'Mobile Number',
      hintText: 'Mobile Number',
      icon: Icon(Icons.phone_android),
      fillColor: Colors.grey
    ),
  );
}

static TextFormField _fax_number_field(){
  return TextFormField(
    controller: _name_controller,
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,

    decoration: InputDecoration(
      labelText: 'Fax Number',
      hintText: 'Fax Number',
      icon: Icon(Icons.print),
      fillColor: Colors.grey
    ),
  );
}

static TextFormField _email_address_field(){
  return TextFormField(
    controller: _name_controller,
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,

    decoration: InputDecoration(
      labelText: 'Email Address',
      hintText: 'Email Address',
      icon: Icon(Icons.email),
      fillColor: Colors.grey
    ),
  );
}

static TextFormField _company_website_field(){
  return TextFormField(
    controller: _name_controller,
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,

    decoration: InputDecoration(
      labelText: 'Company Website',
      hintText: 'Company Website',
      icon: Icon(Icons.web),
      fillColor: Colors.grey
    ),
  );
}

static TextFormField _about_us_field(){
  return TextFormField(
    controller: _name_controller,
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,

    decoration: InputDecoration(
      labelText: 'About Company',
      hintText: 'About Company',
      icon: Icon(Icons.info),
      fillColor: Colors.grey
    ),
  );
}

static TextFormField _category_field(){
  return TextFormField(
    controller: _name_controller,
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,

    decoration: InputDecoration(
      labelText: 'Catgory',
      hintText: 'Category',
      icon: Icon(Icons.category),
      fillColor: Colors.grey
    ),
  );
}

static TextFormField _province_field(){
  return TextFormField(
    controller: _name_controller,
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,

    decoration: InputDecoration(
      labelText: 'Province Name',
      hintText: 'Province Name',
      icon: Icon(Icons.location_city),
      fillColor: Colors.grey
    ),
  );
}
void submit_addvert(){

}
}
//Text Form Fields
//name
//physical address
//postal address
//telephone
//mobile
//fax
//email
//company website
//about us
//category
//province

//#required
//name
//addrss
//telephone
//email
//about_us
