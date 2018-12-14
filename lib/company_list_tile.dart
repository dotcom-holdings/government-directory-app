import 'package:flutter/material.dart';
import 'models/company.dart';
import 'company_page.dart';
class company_list_tile extends StatelessWidget{
  final List<Company> companies;

  company_list_tile({
    Key key, this.companies
  }) : super(key : key);

  @override
  // Widget build(BuildContext context){
  //   return Container(
  //     child: ListView.builder(
  //       itemCount: companies.length,
  //       padding: const EdgeInsets.all(0.0),
  //       itemBuilder: (context, position){
  //         return Column(
  //           children: <Widget>[
  //             Divider(
  //               height: 10.0,
  //             ),
  //             ListTile(
  //               title: Text(
  //                 '${companies[position].name.toUpperCase()}',
  //                 style: TextStyle(
  //                   fontSize: 15.0,
  //                   color: Colors.grey
  //                 ),
  //                 textAlign: TextAlign.center,
  //               ),
  //               onTap: () {
  //                 print(companies[position].id + ' ' + companies[position].name);
  //                 _show_company(context, companies[position]);
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget build(BuildContext context){
    return Container(
      child: ListView.builder(
        itemCount: companies.length,
        itemBuilder: (context, position){
          return Column(
            children: <Widget>[
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new GestureDetector(
                    onTap: (){
                      print(companies[position].name);
                      _show_company(context, companies[position]);
                    },
                    child: 
                                      new Container(
                    padding: const EdgeInsets.all(1.0),
                    width: MediaQuery.of(context).size.width*0.8,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                       Padding(
                         padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                         child: 
                         Text(
                         companies[position].name,
                          style: TextStyle(
                           fontSize: 15.0, 
                             fontWeight: FontWeight.w900,
                          ),
                         ),
                       ),
                                              Padding(
                       padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                         child: Text(
                           companies[position].address,
                           style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
                         ),
                      ),
                      ],
                    ),
                  ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('5m',style: TextStyle(color: Colors.grey),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.star_border,
                             size: 35.0, color: Colors.grey,),
                        )
                      ],
                    ),
                  ),
                  
                ],
              ),

              Divider(
                height: 2.0,
                color: Colors.grey,
              )
            ],
            
          );
        },
      ),
    );
  }

  void _show_company(BuildContext context, Company company) async{
    print(company.name);
    Map result = await Navigator.push(context, MaterialPageRoute(builder: (context) => company_page(company: company, old_context: context,)));
  }
}