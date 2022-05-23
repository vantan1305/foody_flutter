import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody_flutter/data/controller/detailController.dart';
import 'package:foody_flutter/data/controller/recommended_product_controller.dart';
import 'package:foody_flutter/home/main_page.dart';
import 'package:foody_flutter/pages/cart_history.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageCount = 0;
  late PersistentTabController _controller;
  List pages = [
    MainPage(),
    Container(
      child: Center(
        child: Text('One Page'),
      ),
    ),
    Container(
      child: Center(
        child: Text('Two Page'),
      ),
    ),
    Container(
      child: Center(
        child: Text('Three Page'),
      ),
    ),
  ];

  void onTapNav(int index) {
    setState(() {
      _pageCount = index;
    });
  }

  void initState() {
    super.initState();

    _controller = PersistentTabController(initialIndex: 0);
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        // filter:ImageFiltered(imageFilter: Image.asset('')),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.archive),
        title: ("History"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.shopping_cart),
        title: ("Cart"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Acount"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [
      MainPage(),
      Container(
        child: Center(
          child: Text('One Page'),
        ),
      ),
      CartHistory(),
      Container(
        child: Center(
          child: Text('Three Page'),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: pages[_pageCount],
  //     bottomNavigationBar: BottomNavigationBar(
  //         selectedItemColor: Color.fromARGB(255, 33, 182, 150),
  //         unselectedItemColor: Colors.black87,
  //         showSelectedLabels: false,
  //         showUnselectedLabels: false,
  //         selectedFontSize: 0.0,
  //         unselectedFontSize: 0.0,
  //         currentIndex: _pageCount,
  //         onTap: onTapNav,
  //         items: const [
  //           BottomNavigationBarItem(
  //               icon: Icon(
  //                 Icons.home_outlined,
  //               ),
  //               label: 'Home'),
  //           BottomNavigationBarItem(
  //               icon: Icon(
  //                 Icons.archive,
  //               ),
  //               label: 'History'),
  //           BottomNavigationBarItem(
  //               icon: Icon(
  //                 Icons.shopping_cart,
  //               ),
  //               label: 'ShoppingCart'),
  //           BottomNavigationBarItem(
  //               icon: Icon(
  //                 Icons.person,
  //               ),
  //               label: 'MyAcount'),
  //         ]),
  //   );
  // }
}
