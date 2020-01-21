import 'package:flutter/material.dart';
import 'dart:ui';

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

class _MyHomePageState extends State<MyHomePage> {
  String _routePath;
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
        child: _widgetRoute(_routePath!=null?_routePath:widget.initParams),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Change',
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            if (_routePath == "/route1") {
              _routePath = "/route2";
            }else {
              _routePath = "/route1";
            }
          });
        },
      ),
    );
  }

  void _pushNextPage() {
    Navigator.of(context).push(
      new MaterialPageRoute(
          builder: (context) {
            return MyHomePage(initParams: "/route2");
            return new Scaffold(
              appBar: new AppBar(
                title: new Text('Saved Suggestions'),
              ),
              body: Center (
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
    return Center(
      child: Text(
        "this is route1Widget",
        style: TextStyle(color: Colors.red, fontSize: 20),
      ),
    );
  }

  Widget route2Widget() {
    return Center(
      child: Text(
        "this is route2Widget",
        style: TextStyle(color: Colors.blue, fontSize: 20),
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





