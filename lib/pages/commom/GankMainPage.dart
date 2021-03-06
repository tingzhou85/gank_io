import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gank_io/api/HttpManager.dart';
import 'package:gank_io/eventbus/HttpErrorEvent.dart';
import 'package:gank_io/pages/dailyNews/DailyNewsPage.dart';
import 'package:gank_io/pages/free_time_news/FreeTimeNewsPage.dart';
import 'package:gank_io/pages/home/MyHomePage.dart';
import 'package:gank_io/pages/welfare/WelfarePage.dart';

class GankMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GankMainPageState();
}

class _GankMainPageState extends State<GankMainPage> {
  StreamSubscription errorSubscription;
  static const _titles = <String>['每日干货', '闲读新闻', '美女福利', '我的主页'];
  var _currentTitle = _titles[0];
  var _currentIndex = 0;

  PageController pageController;
  //底部tab控件list
  final List<BottomNavigationBarItem> _bottomTabs = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text(_titles[0]),
        backgroundColor: Colors.lightBlue),
    BottomNavigationBarItem(
        icon: Icon(Icons.phone_iphone),
        title: Text(_titles[1]),
        backgroundColor: Colors.lightBlue),
    BottomNavigationBarItem(
        icon: Icon(Icons.image),
        title: Text(_titles[2]),
        backgroundColor: Colors.lightBlue),
    BottomNavigationBarItem(
        icon: Icon(Icons.person),
        title: Text(_titles[3]),
        backgroundColor: Colors.lightBlue)
  ];

  @override
  void initState() {
    super.initState();
    pageController = new PageController(initialPage: _currentIndex);
    errorSubscription =
        HttpManager.eventBus.on<HttpErrorEvent>().listen((event) {
      Fluttertoast.showToast(msg: event.message);
    });
  }

  @override
  void dispose() {
    ///要在父类方法之前执行
    pageController.dispose();
    errorSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            _currentTitle,
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: PageView(
          controller: pageController,
          children: <Widget>[
            DailyNewsPage(),
            FreeTimeNewsPage(),
            WelfarePage(),
            MyHomePage(),
          ],
          onPageChanged: _onPageChanged,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: _bottomTabs,
          currentIndex: _currentIndex,
          //默认 tab数量等于3 BottomNavigationBarType.fixed
          //否则BottomNavigationBarType.shifting
          type: BottomNavigationBarType.fixed,
          //点击改变底部tab选中状态
          onTap: (int index) {
            pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          },
        ));
  }

  ///底部tab改变调用该方法
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          _currentTitle = _titles[0];
          break;
        case 1:
          _currentTitle = _titles[1];
          break;
        case 2:
          _currentTitle = _titles[2];
          break;
        case 3:
          _currentTitle = _titles[3];
          break;
      }
    });
  }
}
