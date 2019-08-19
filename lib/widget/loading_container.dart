import 'package:flutter/material.dart';

//进入首页加载进度条组件
class LoadingContainer extends StatelessWidget {
  //显示进度条亦或者是显示自己的内容
  final Widget child;
  final bool isLoading;

  //是否覆盖再child之上
  final bool cover;

  const LoadingContainer(
      {Key key,
      @required this.isLoading,
      this.cover = false,
      @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //如果不是cover的情况，如果不是loading的情况下：就显示这个child，否则就显示_loadingView
    return !cover
        ? isLoading ? child : _loadingView
        : Stack(
            children: <Widget>[child, isLoading ? _loadingView : null],
          );
  }

  Widget get _loadingView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
