import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'weidget.dart';
import 'package:flutter_app/home/home.dart';
import 'package:flutter_app/home/search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app/login/login.dart';
import 'package:flutter_app/common/tool/EventBus.dart';
import 'package:flutter_app/mine/mine.dart';
import 'package:flutter_app/common/tool/ZSTools.dart';
import 'package:flutter_app/task/task.dart';
import 'package:flutter_app/task/chart.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      routes: {
        'new_page': (context) => NewRoute(),
        'test-wedget': (context) => TestWidget(),
        'search': (context) => SearchPage(),
        'login': (context) => LoginPage(),
        'main': (context) => MainPage(),
        'chart': (context) => ChartPage(),
      },
      home: MainPage(),//MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }

}


class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
//    注册全局事件
    bus.on(kNeedLogin, (e){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return LoginPage();
      },fullscreenDialog: true));
    });
    sureLogin(context);
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          HomePage(),//MyHomePage(title: 'Flutter Demo Home Page'),
          TaskPage(),
          MinePage()
        ],
      ),
//      TabBarView(
//        children: <Widget>[
//          MyHomePage(title: 'Flutter Demo Home Page'),
//          NewRoute(),
//          TestWidget()
//        ],
//        controller: tabController,
//        physics: NeverScrollableScrollPhysics(),
//      ),
      bottomNavigationBar: BottomNavigationBar( // 底部导航
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Image.asset('assets/ic_nav_home.png',width: 25),
              activeIcon: Image.asset('assets/ic_nav_home_disabled.png',width: 25), title: Text('首页')),
          BottomNavigationBarItem(icon: Image.asset('assets/ic_nav_task.png',width: 25),
              activeIcon: Image.asset('assets/ic_nav_task_disabled.png',width: 25), title: Text('任务')),
          BottomNavigationBarItem(icon: Image.asset('assets/ic_nav_my.png',width: 25),
              activeIcon: Image.asset('assets/ic_nav_my_disabled.png',width: 25), title: Text('我的')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  sureLogin(context) async {
    bool isLogin = await ZSTool.getInstance().isLogin();
    if (isLogin == false) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return LoginPage();
      },fullscreenDialog: true));
    }
  }
}

//--------------------------测试widget--------------------------
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      print(_counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            FlatButton(
              child: Text("open new router"),
              textColor: Colors.red,
              onPressed: () {
//                Navigator.push(context,
//                    new MaterialPageRoute(builder: (context) {
//                  return new NewRoute();
//                }));
//                Navigator.pushNamed(context, 'new_page');
              Navigator.of(context).pushNamed('new_page', arguments: "hi");
              },
            ),
            RandomWordsWidget(),
            Image(
              image: NetworkImage(
                  "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4"),
              width: 100.0,
            )
//            Image(
//              image: AssetImage('assets/addImg.png'),
//              width: 100,
//            )
//            Image.asset('assets/addImg.png')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final wordPair =new WordPair.random();
    return Padding(
      padding: EdgeInsets.all(0),
      child: Text(wordPair.toString()),
    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var args=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('新的路由'),
      ),
      body: Center(
        child: Text('这是新的路由哦$args'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context,'test-wedget');
        },
        child: Icon(Icons.arrow_right),
        backgroundColor: Colors.green,
      )
    );
  }
}