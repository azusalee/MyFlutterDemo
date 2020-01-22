import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'tab_page.dart';

void main() => runApp(MyApp(
      //通过window.defaultRouteName获取从native传递过来的参数,需要导入dart:ui包
      initParams: window.defaultRouteName,
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final String initParams;

  MyApp({Key key, this.initParams}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(initParams: initParams),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String initParams;
  const MyHomePage({Key key, this.initParams}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  String _routePath;
  AnimationController _animationController;
  Animation _myAnimation;
  int _favouriteCount = 41;
  bool _isFavourite = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _routePath = widget.initParams;
    _animationController =
        AnimationController(duration: Duration(milliseconds: 275), vsync: this);
    _myAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);
    _myAnimation.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('flutter page'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.home), onPressed: _pushNextPage)
        ],
      ),
      body: Center(
        child: _widgetRoute(_routePath),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Change',
        child: Icon(Icons.refresh),
        onPressed: () {
          if (_routePath == "/route1") {
            _routePath = "/route2";
          } else {
            _routePath = "/route1";
          }
          _animationController.forward(from: 0.0);
//          setState(() {
//            if (_routePath == "/route1") {
//              _routePath = "/route2";
//            }else {
//              _routePath = "/route1";
//            }
//          });
        },
      ),
    );
  }

  void _pushNextPage() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return MyTabPage();
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Saved Suggestions'),
            ),
            body: Center(
              child: Text(
                "next page",
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _widgetRoute(String route) {
    switch (route) {
      case "/route1":
        return route1Widget();
      case "/route2":
        return route2Widget();
      default:
        return notFoundWidget();
    }
  }

  Widget route1Widget() {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Your Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'Your Loop',
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              _isFavourite?Icons.star:Icons.star_border,
              color: Colors.red,
            ),
            onPressed: (){
              setState(() {
                _isFavourite = !_isFavourite;
                if (_isFavourite) {
                  _favouriteCount += 1;
                }else{
                  _favouriteCount -= 1;
                }
              });
            },
          ),
          Text('$_favouriteCount')
        ],
      ),
    );
    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildButtonColumn(Icons.call, 'CALL', (){
            print('Call did tap');
          }),
          buildButtonColumn(Icons.near_me, 'ROUTE', (){
            print('Route did tap');
          }),
          buildButtonColumn(Icons.share, 'SHARE',(){
            print('Share did tap');
          }),
        ],
      ),
    );

    return ListView(
      children: [
        Image.asset(
          'images/lake.jpg',
          width: 600.0,
          height: 240.0 * _animationController.value,
          fit: BoxFit.cover,
        ),
        titleSection,
        buttonSection,
      ],
    );
  }

  GestureDetector buildButtonColumn(IconData icon, String label, VoidCallback callback) {
    Color color = Theme.of(context).primaryColor;
    return GestureDetector(
        onTap: callback,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, color: color),
            Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              ),
            )
          ],
        ));
  }

  Widget route2Widget() {
    return Center(
      child: Text(
        "this is route2Widget",
        style: TextStyle(
            color: Colors.blue, fontSize: 20 + _animationController.value * 10),
      ),
    );
  }

  Widget notFoundWidget() {
    return Center(
      child: Text(
        "未匹配到路由",
        style: TextStyle(color: Colors.red, fontSize: 30),
      ),
    );
  }
}
