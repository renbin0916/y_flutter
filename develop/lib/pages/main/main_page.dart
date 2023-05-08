import 'package:develop/component/y_button.dart';
import 'package:develop/pages/discovery/discovery_page.dart';
import 'package:develop/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final double _tabBarHeight = 40;
  final _tabBarButtons = <YButton>[];

  @override
  void initState() {
    super.initState();
    _createTabBarButtons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.yellow,
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomePage(),
          DiscoveryPage(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.yellow,
        shape: const CircularNotchedRectangle(),
        notchMargin: 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _tabBarButtons,
        ),
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: () {},),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _createTabBarButtons() {
    final btn1 = YButton.create(
      // height: _tabBarHeight,
      buttonStyle: YButtonStyle.iconAndTitleTToB,
      iconWidget: const Icon(Icons.home_outlined),
      selectIconWidget: const Icon(Icons.home),
      titleWidget: const Text(
        '我的',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
      ),
      selectTitleWidget: const Text(
        '我的',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      onPress: () {
        _tabBarButtonSelected(0);
      },
    );
    _tabBarButtons.add(btn1);

    final btn2 = YButton.create(
      // height: _tabBarHeight,
      buttonStyle: YButtonStyle.iconAndTitleTToB,
      iconWidget: const Icon(Icons.search),
      selectIconWidget: const Icon(Icons.search_off),
      titleWidget: const Text(
        '发现',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
      ),
      selectTitleWidget: const Text(
        '发现',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      onPress: () {
        _tabBarButtonSelected(1);
      },
    );
    _tabBarButtons.add(btn2);
  }

  void _tabBarButtonSelected(int index) {
    _currentIndex = index;
    setState(() {});
    for (int i = 0; i < _tabBarButtons.length; i++) {
      final btn = _tabBarButtons[i];
      YButtonStatus buttonStatus;
      if (i == index) {
        buttonStatus = YButtonStatus.selected;
      } else {
        buttonStatus = YButtonStatus.normal;
      }
      btn.changeButtonStatus(buttonStatus);
    }
  }

}
