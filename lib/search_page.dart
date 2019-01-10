import 'package:flutter/material.dart';
import 'package:material_search/material_search.dart';

class search_page extends StatefulWidget{

  @override
  _search_page_state createState() => _search_page_state();
}

class _search_page_state extends State<search_page>{
  final _names = const[
    'sanele hlabisa',
    'anele hlabisa',
    'nothando hlabisa',
    'simphiwe hlabisa'
  ];
  //String _selected;
  String _name = 'no one';
  final _formKey = new GlobalKey<FormState>();

  _buildMaterialSearchPage(BuildContext context){
    return new MaterialPageRoute<String>(
      settings: new RouteSettings(
        name: 'material_search',
        isInitialRoute: false,
      ),
      builder: (BuildContext context){
        return new Material(
          child: new MaterialSearch<String>(
            placeholder: 'search',
            results: _names.map((String v) => new MaterialSearchResult<String>(
              icon: Icons.compare,
              value: v,
              text: 'mr(s), $v',
            )).toList(),
            filter: (dynamic value, String criteria){
              return value.toLowerCase().trim().contains(new RegExp(r'' + criteria.toLowerCase().trim()+''));
            },
            onSelect: (dynamic value) => Navigator.of(context).pop(value),
            onSubmit: (String value) => Navigator.of(context).pop(value),
          ),
        );
      }
    );
  }

  _showMaterialSearch(BuildContext context){
    Navigator.of(context).push(_buildMaterialSearchPage(context)).then((dynamic value) {
      setState(() => _name = value as String);
    });
  }
 @override
 Widget build(BuildContext context){
   return new Scaffold(
     appBar: new AppBar(
       title: new Text('search app'),
       actions: <Widget>[
         new IconButton(
           onPressed: (){
             _showMaterialSearch(context);
           },
           tooltip: 'search',
           icon: new Icon(Icons.search),
         )
       ],
     ),
     body: new Center(
       child: new Column(
         mainAxisAlignment: MainAxisAlignment.start,
         children: <Widget>[
           new Padding(
             padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 50.0),
             child: new Text("you foud: ${_name ?? 'No one'}"),
           ),
           new Padding(
             padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
             child: new Form(
               key: _formKey,
               child: new Column(
                 children: <Widget>[
                   new MaterialSearchInput<String>(
                     placeholder: 'name',
                     results: _names.map((String v) => new MaterialSearchResult<String>(
                       icon: Icons.person,
                       value: v,
                       text: "Mr(s). $v",
                     )).toList(),
                     filter: (dynamic value, String criteria){
                       return value.toLowerCase().trim().contains(new RegExp(r'' + criteria.toLowerCase().trim() + ''));
                     },
                     onSelect: (dynamic v){
                       print(v);
                     },
                     validator: (dynamic value) => value == null ? 'required field' : null,
                     formatter: (dynamic v) => 'hello, $v',
                   ),
                   new MaterialButton(
                     child: new Text('validate'),
                     onPressed: (){
                       _formKey.currentState.validate();
                     },
                   )
                 ],
               ),
             ),
           )
         ],
       ),
     ),
     floatingActionButton: new FloatingActionButton(
       onPressed: (){
         _showMaterialSearch(context);
       },
       tooltip: 'search',
       child: new Icon(Icons.search),
     ),
   );
 }
}