import 'package:flutter/material.dart';
import 'models/GovCategory.dart';
import 'gov_cat.dart';

class GovCategory_list_tile extends StatelessWidget{
  final List<GovCategory> gov_categories;

  GovCategory_list_tile({
    Key key, this.gov_categories
  }) : super(key : key);

  @override
  Widget build(BuildContext context){
    return Container(
      child: ListView.builder(
        itemCount: gov_categories.length,
        padding: const EdgeInsets.all(0.0),
        itemBuilder: (context, position){
          return Column(
            children: <Widget>[
              Divider(
                height: 10.0,
              ),
              ListTile(
                title: 
                Text(
                  '${gov_categories[position].name.toUpperCase()}',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w900,
                    //color: Colors.grey,
                    
                  ),
                  textAlign: TextAlign.left,
                ),
                onTap: () => _show_category(context, gov_categories[position]),
              )
            ],
          );
        },
      ),
    );
  }

  void _on_category_tap(BuildContext context, GovCategory category){
    Scaffold
    .of(context)
    .showSnackBar(new SnackBar(content: new Text(category.name + ' clicked'),));
  }

  void _show_category(BuildContext context, GovCategory category) async{
    print(category.id);
    Map result = await Navigator.push(context, MaterialPageRoute(builder: (context) => gov_cat(govCategory: category)));
  }
}