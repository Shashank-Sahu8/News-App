import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Bottom%20nav/Accounts.dart';
import 'package:news_app/Bottom%20nav/bookmark.dart';
import 'package:news_app/Bottom%20nav/discover.dart';
import 'package:news_app/Bottom%20nav/home.dart';
import 'package:news_app/Theme/theme.dart';
import 'package:news_app/Theme/themeprovider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import 'notifications.dart';


PersistentTabController _controller= PersistentTabController(initialIndex: 0);
class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {

  List<Widget> _buildScreens() {
    return [
      home(),
      discover(),
      bookmark(),
      accounts(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: Theme.of(context).colorScheme.tertiary,
        inactiveColorPrimary: Colors.blueGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.globe),
        title: ("Discover"),
        activeColorPrimary: Theme.of(context).colorScheme.tertiary,
        inactiveColorPrimary: Colors.blueGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.bookmark),
        title: ("Bookmark"),
        activeColorPrimary: Theme.of(context).colorScheme.tertiary,
        inactiveColorPrimary: Colors.blueGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("Profile"),
        activeColorPrimary: Theme.of(context).colorScheme.tertiary,
        inactiveColorPrimary: Colors.blueGrey,
      ),
    ];
  }

  NotificationServices notificationServices=NotificationServices();
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Theme.of(context).colorScheme.background,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style14,
    );
  }
}














