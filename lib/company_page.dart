import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'models/company.dart';
// class company_page extends StatelessWidget{
//   final Company company;

//   company_page({
//     Key key, this.company
//   }) : super(key : key);

//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//        appBar: AppBar(
//         title: new Text(
//           '${company.name.toUpperCase()}',
//          style: TextStyle(
//            fontWeight: FontWeight.w300,
//          ),),
//        ),
//                     body: new Text(
//         'test'
//       ),

//     );
//   }
// }

class company_page extends StatefulWidget {
  final Company company;
  final BuildContext old_context;
  company_page({Key key, this.company, this.old_context}) : super(key: key);

  @override
  _company_page_state createState() => _company_page_state(this.company, this.old_context);
}

enum AppBarBehavior { normal, pinned, floating, snapping }

class _company_page_state extends State<company_page>
    with TickerProviderStateMixin {
  final Company company;
  final old_context;

  _company_page_state(this.company, this.old_context);
  AnimationController _containerController;
  Animation<double> width;
  Animation<double> height;
  DecorationImage type;
  //List data = imageData;
  double _appBarHeight = 256.0;
  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;

  void initState() {
    _containerController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);
    super.initState();
    width = new Tween<double>(
      begin: 200.0,
      end: 220.0,
    ).animate(
      new CurvedAnimation(
        parent: _containerController,
        curve: Curves.ease,
      ),
    );

    height = new Tween<double>(
      begin: 400.0,
      end: 400.0,
    ).animate(
      new CurvedAnimation(
        parent: _containerController,
        curve: Curves.ease,
      ),
    );

    height.addListener(() {
      setState(() {
        if (height.isCompleted) {}
      });
    });
    _containerController.forward();
  }

  @override
  void dispose() {
    _containerController.dispose();
    super.dispose();
  }

  void _show_company_connection(BuildContext context, String action){
    Icon connection_icon;
    String company_connection_data;
    String title;
    bool _empty = false;
    if(action == 'phone'){
      //show company phone number
      connection_icon = new Icon(Icons.phone, color: Colors.cyan);
      title = 'company phone number';
      if(company.mobile.isEmpty){
        _empty = true;
      }else{
        _empty = false;
        company_connection_data = '${company.mobile}';
      }
    }

    if(action == 'fax'){
      //show company fax number
      connection_icon = new Icon(Icons.print, color: Colors.cyan);
      title = 'company fax number';
      if(company.fax.isEmpty){
        _empty = true;
      }else{
        _empty = false;
        company_connection_data = '${company.fax}';
      }
    }

    if(action == 'email'){
      //show company email
      connection_icon = new Icon(Icons.email, color: Colors.cyan);
      title = 'company email address';
      if(company.email.isEmpty){
        _empty = true;
      }else{
        _empty = false;
        company_connection_data = '${company.email}';
      }
    }

    if(action == 'web'){
      //show company website
      connection_icon = new Icon(Icons.web, color: Colors.cyan);
      title = 'company website';
      if(company.website.isEmpty){
        _empty = true;
      }else{
        _empty = false;
        company_connection_data = '${company.website}';
      }
    }

    if(action == 'location'){
      //show company location
      connection_icon = new Icon(Icons.location_on, color: Colors.cyan);
      title = 'company location';
      if(company.address.isEmpty){
        _empty = true;
      }else{
        _empty = false;
        company_connection_data = '${company.address}';
      }
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: connection_icon,
              title: Text(title),
            ),
            new ListTile(
              leading: new Text(''),
              title: _empty ? Text('This company has no ${title}') : Text('${company_connection_data}'),
            ),
          SizedBox(
            height: 15.0,
          ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.7;

    // Widget _fab(){
    //   return Scaffold(
    //     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    //     floatingActionButton: FloatingActionButton(
    //             onPressed: (){},
    //   tooltip: 'test',
    //   child: Icon(Icons.add),
    //   elevation: 2.0,
    //     ),
    //   );
    // }

    return Scaffold(
      body: //new Theme(
        // data: new ThemeData( 
        //   brightness: Brightness.light,
        //   primaryColor: const Color.fromRGBO(106, 94, 175, 1.0),
        //   platform: Theme.of(context).platform,
        // ),
         Container(
          //width: width.value,
          //height: height.value,
          color: Colors.white, //const Color.fromRGBO(106, 94, 175, 1.0),
          child: new Hero(
            tag: "img",
            child: new Card(
              color: Colors.transparent,
              child: new Container(
                alignment: Alignment.center,
                //width: width.value,
                //height: height.value,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  //border radius
                  //borderRadius: new BorderRadius.circular(10.0),
                ),
                child: new Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    new CustomScrollView(
                      shrinkWrap: false,
                      slivers: <Widget>[
                        new SliverAppBar(
                          elevation: 0.0,
                          forceElevated: true,
                          // leading: new IconButton(
                          //   onPressed: (){
                          //     Navigator.of(context).pop();
                          //   },
                          //   icon: new Icon(Icons.arrow_back, color: Colors.cyan,size: 30.0,),
                          // ),
                          expandedHeight: _appBarHeight,
                          pinned: _appBarBehavior == AppBarBehavior.pinned,
                          floating:
                              _appBarBehavior == AppBarBehavior.floating ||
                                  _appBarBehavior == AppBarBehavior.snapping,
                          flexibleSpace: new FlexibleSpaceBar(
                            title: new Container(
                              width: width.value,
                              child: Text('${company.name}'),
                            ),
                            background: new Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                new Container(
                                  //width: width.value,
                                  height: _appBarHeight,
                                  decoration: new BoxDecoration(
                                    //image: NetworkImage(''),
                                    image: new DecorationImage(
                                      image: new NetworkImage(
                                        company.url.isEmpty ? 'http://jlouage.com/images/intro-bg.jpg' : 'cdn.adslive.com/${company.url}'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        new SliverList(
                          delegate: new SliverChildListDelegate(<Widget>[
                            new Container(
                              color: Colors.white,
                              child: new Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Container(
                                      padding:
                                          new EdgeInsets.only(bottom: 20.0),
                                      alignment: Alignment.center,
                                      decoration: new BoxDecoration(
                                          color: Colors.white,
                                          border: new Border(
                                              bottom: new BorderSide(
                                                  color: Colors.black12))),
                                      child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          new Row(
                                            children: <Widget>[
                                              IconButton(
                                                icon: new Icon(Icons.phone,color: Colors.cyan,),
                                                onPressed: (){
                                                  print('company image ${company.url}');
                                                  _show_company_connection(context, 'phone');
                                                },
                                              ),
                                              // new Padding(
                                              //   padding: const EdgeInsets.all(8.0),
                                              //   child: new Text("10:00 am"),
                                              // )
                                            ],
                                          ),
                                          new Row(
                                            children: <Widget>[
                                                  IconButton(
                                                    icon: new Icon(
                                                      Icons.print,
                                                      color: Colors.cyan,
                                                      ),
                                                      onPressed: (){
                                                        _show_company_connection(context, 'fax');
                                                      },
                                                  ),
                                            ],
                                          ),
                                          new Row(
                                            children: <Widget>[
                                                  IconButton(
                                                    icon: new Icon(
                                                      Icons.email,
                                                      color: Colors.cyan,
                                                    ),
                                                    onPressed: (){
                                                      _show_company_connection(context, 'email');
                                                    },
                                                  ),
                                            ],
                                          ),
                                          new Row(
                                            children: <Widget>[
                                              IconButton(
                                                icon: new Icon(
                                                  Icons.web,
                                                  color: Colors.cyan,
                                                ),
                                                // onPressed: () {
                                                //   showBottomSheet<void>(
                                                //     context: context, builder: (BuildContext context) => const _drawer(),
                                                //   );

                                                  
                                                // },
                                                onPressed: (){
                                                  _show_company_connection(context,'web');
                                                },
                                              ),
                                            ],
                                          ),
                                          new Row(
                                            children: <Widget>[
                                              IconButton(
                                                icon: new Icon(
                                                  Icons.location_on,
                                                  color: Colors.cyan,
                                                ),
                                                onPressed: () {
                                                  _show_company_connection(context, 'location');
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    new Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16.0, bottom: 8.0),
                                      child: new Text(
                                        'ABOUT',
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    company.about_us.isEmpty ? Text('Company information not found') : Text('${company.about_us}'),
                                    //new Text('${company.about_us}'),
                                  ],
                                ),
                              ),
                            )
                          ]),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        icon: const Icon(Icons.view_carousel),
        label: const Text('view ad'),
        onPressed: () {
          print('hey');
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
      ),
    );

    // return new Theme(

    //   data: new ThemeData(
    //     brightness: Brightness.light,
    //     primaryColor: const Color.fromRGBO(106, 94, 175, 1.0),
    //     platform: Theme.of(context).platform,
    //   ),
    //   child: new Container(
    //     width: width.value,
    //     height: height.value,
    //     color: const Color.fromRGBO(106, 94, 175, 1.0),
    //     child: new Hero(
    //       tag: "img",
    //       child: new Card(
    //         color: Colors.transparent,
    //         child: new Container(
    //           alignment: Alignment.center,
    //           width: width.value,
    //           height: height.value,
    //           decoration: new BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: new BorderRadius.circular(10.0),
    //           ),
    //           child: new Stack(
    //             alignment: AlignmentDirectional.bottomCenter,
    //             children: <Widget>[
    //               new CustomScrollView(
    //                 shrinkWrap: false,
    //                 slivers: <Widget>[
    //                   new SliverAppBar(
    //                     elevation: 0.0,
    //                     forceElevated: true,
    //                     // leading: new IconButton(
    //                     //   onPressed: (){
    //                     //     Navigator.of(context).pop();
    //                     //   },
    //                     //   icon: new Icon(Icons.arrow_back, color: Colors.cyan,size: 30.0,),
    //                     // ),
    //                     expandedHeight: _appBarHeight,
    //                     pinned: _appBarBehavior == AppBarBehavior.pinned,
    //                     floating: _appBarBehavior == AppBarBehavior.floating || _appBarBehavior == AppBarBehavior.snapping,
    //                     flexibleSpace: new FlexibleSpaceBar(
    //                       title: //new Text('${company.name}'),
    //                       new Container(
    //                         width: width.value,
    //                         child: Text('${company.name}'),
    //                       ),
    //                       background: new Stack(
    //                         fit: StackFit.expand,
    //                         children: <Widget>[
    //                           new Container(
    //                             width: width.value,
    //                             height: _appBarHeight,
    //                             decoration: new BoxDecoration(
    //                             //image: ,

    //                             ),
    //                           )
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                   new SliverList(
    //                     delegate: new SliverChildListDelegate(<Widget>[
    //                       new Container(
    //                         color: Colors.white,
    //                         child: new Padding(
    //                           padding: const EdgeInsets.all(35.0),
    //                           child: new Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: <Widget>[
    //                               new Container(
    //                                 padding: new EdgeInsets.only(bottom: 20.0),
    //                                 alignment: Alignment.center,
    //                                 decoration: new BoxDecoration(
    //                                   color: Colors.white,
    //                                   border: new Border(
    //                                     bottom: new BorderSide(
    //                                       color: Colors.black12
    //                                     )
    //                                   )
    //                                 ),
    //                                 child: new Row(
    //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                                   children: <Widget>[
    //                                     new Row(
    //                                       children: <Widget>[new Icon(Icons.access_time, color: Colors.cyan,),
    //                                       new Padding(
    //                                         padding: const EdgeInsets.all(8.0),
    //                                         child: new Text("10:00 am"),
    //                                       )
    //                                       ],
    //                                     ),
    //                                     new Row(
    //                                       children: <Widget>[
    //                                         new Icon(Icons.map,
    //                                         color: Colors.cyan,
    //                                         ),
    //                                         new Padding(
    //                                           padding: const EdgeInsets.all(8.0),
    //                                           child: new Text('15 miles'),
    //                                         )
    //                                       ],
    //                                     )
    //                                   ],
    //                                 ),
    //                               ),
    //                               new Padding(
    //                                 padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
    //                                 child: new Text('ABOUT', style: new TextStyle(fontWeight: FontWeight.bold),
    //                                 ),
    //                               ),
    //                               new Text(
    //                                 '${company.about_us}'
    //                               ),

    //                             ],
    //                           ),
    //                         ),
    //                       )
    //                     ]),
    //                   )
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

class _drawer extends StatelessWidget{
  const _drawer();

  @override
  Widget build(BuildContext context){
    return Drawer(
      child: Column(
        children: <Widget>[
          _custom_list_tile(),
        ],
      ),
    );
  }

  Widget _custom_list_tile(){
    return ListTile(
      leading: Icon(Icons.face),
      title: Text('test'),

    );
  }
}
