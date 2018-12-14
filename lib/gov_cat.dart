import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'models/GovCategory.dart';
import 'models/company.dart';
import 'package:http/http.dart' as http;
import 'company_list_tile.dart';

class gov_cat extends StatelessWidget{
  final GovCategory govCategory;

  gov_cat({
    Key key, this.govCategory
  }): super(key : key);

  Future<List<Company>> get_companies_by_category(http.Client client) async{
    final response = await client.get('https://government.co.za/api/get_companies_by_category/${govCategory.id}');
    print(response.body);
    print('that was a list of companies');
    return compute(parse_companies, response.body);
  }

  static List<Company> parse_companies(String response_body){
    final parsed_data = json.decode(response_body).cast<Map<String, dynamic>>();

    return parsed_data.map<Company>((json) => Company.fromjson(json)).toList();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: new Text('${govCategory.name.toUpperCase()}', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.0),),
      ),
      body: FutureBuilder<List<Company>>(
        future: get_companies_by_category(http.Client()),
        builder: (context, snapshot){
          if(snapshot.hasError)
            print(snapshot.error);
          
          return snapshot.hasData
            ? company_list_tile(companies: snapshot.data)
            : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}