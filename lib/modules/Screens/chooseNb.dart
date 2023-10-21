import 'package:beezar/modules/Screens/choose_category/category.dart';
import 'package:beezar/modules/Screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../constants.dart';
import 'category/category.dart';
import 'home/homePage.dart';

class chooseNavicationBar extends StatefulWidget {
  const chooseNavicationBar({super.key});

  @override
  State<chooseNavicationBar> createState() => _chooseNavicationBarState();
}

class _chooseNavicationBarState extends State<chooseNavicationBar> {
  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ChooseCategory(),
    Profile(),
  ];
  int _selectedIndex = 0;

  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: GNav(
            rippleColor:
                Colors.grey.shade600, // tab button ripple color when pressed
            hoverColor: btnBglight, // tab button hover color
            haptic: true, // haptic feedback
            tabBorderRadius: 10,
            curve: Curves.easeOutExpo, // tab animation curves
            duration: Duration(milliseconds: 900), // tab animation duration
            gap: 8, // the tab button gap between icon and text
            color: Colors.grey[800], // unselected icon color
            activeColor: mainColor, // selected icon and text color
            iconSize: 30, // tab button icon size
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'الرئيسية',
              ),
              GButton(
                icon: Icons.add_circle,
                text: 'أضف إعلان',
              ),
              GButton(
                icon: Icons.person,
                text: 'بروفايلي',
              )
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ));
  }
}
