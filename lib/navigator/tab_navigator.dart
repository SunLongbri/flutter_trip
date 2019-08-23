import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/home_page.dart';
import 'package:flutter_trip/pages/my_page.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/travel_page.dart';
import 'package:oktoast/oktoast.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _controller,
            children: <Widget>[
              HomePage(),
              SearchPage(
                hideLeft: true,
              ),
              TravelPage(),
              MyPage(),
            ],
          ),
          onWillPop: exitApp),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            _singleItem(Icons.home, '首页', 0),
            _singleItem(Icons.search, '搜索', 1),
            _singleItem(Icons.camera, '旅拍', 2),
            _singleItem(Icons.account_circle, '我的', 3),
          ]),
    );
  }

  _singleItem(IconData iconData, String name, int index) {
    return BottomNavigationBarItem(
        icon: Icon(iconData, color: _defaultColor),
        activeIcon: Icon(iconData, color: _activeColor),
        title: Text(
          name,
          style: TextStyle(
              color: _currentIndex != index ? _defaultColor : _activeColor),
        ));
  }

  DateTime _lastPressedAt; //上次点击时间
  //退出app
  Future<bool> exitApp() {
    if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt) > Duration(seconds: 2)) {
      showToast("再按一次退出应用");
      //两次点击间隔超过2秒则重新计时
      _lastPressedAt = DateTime.now();
      return Future.value(false);
    }
    return Future.value(true);
//    return showDialog(
//        context: context,
//        builder: (context) => new AlertDialog(
//              content: new Text("是否退出"),
//              actions: <Widget>[
//                new FlatButton(
//                    onPressed: () => Navigator.of(context).pop(false),
//                    child: new Text("取消")),
//                new FlatButton(
//                    onPressed: () {
//                      Navigator.of(context).pop(true);
//                    },
//                    child: new Text("确定"))
//              ],
//            ));
  }
}
