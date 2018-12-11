import 'package:flutter/material.dart';
import 'models/GovCategory.dart';
class gov_cat extends StatelessWidget{
  final GovCategory govCategory;

  gov_cat({
    Key key, this.govCategory
  }): super(key : key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: new Text('${govCategory.name.toUpperCase()}', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.0),),
      ),
      body: new Text(
        'test'
      ),
    );
  }
}