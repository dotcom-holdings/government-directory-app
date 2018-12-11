import 'package:flutter/material.dart';
import 'models/company.dart';
class company_list_tile extends StatelessWidget{
  final List<Company> companies;

  company_list_tile({
    Key key, this.companies
  }) : super(key : key);

  @override
  Widget build(BuildContext context){
    return Container(
      child: ListView.builder(
        itemCount: companies.length,
        padding: const EdgeInsets.all(0.0),
        itemBuilder: (context, position){
          return Column(
            children: <Widget>[
              Divider(
                height: 10.0,
              ),
              ListTile(
                title: Text(
                  '${companies[position].name.toUpperCase()}',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  print(companies[position].id + ' ' + companies[position].name);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}