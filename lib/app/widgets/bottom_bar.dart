import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:my_souaq/app/screens/account_screen.dart';
import 'package:my_souaq/app/screens/cart_screen.dart';
import 'package:my_souaq/app/screens/home_screen.dart';
import 'package:my_souaq/app/styles/colors.dart';
class BottomBar extends StatefulWidget
{
  static const String routeName ='/bar-home';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}
int page = 0;
double nbWidth = 42;
class _BottomBarState extends State<BottomBar>
{
  void updateBadge(int badge)
  {
    setState((){
      page = badge;
    });
  }
  List<Widget> pages=
  [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];

  @override
  Widget build(BuildContext context)
  {
    return  Scaffold(
      body: pages[page],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: page,
        selectedItemColor: Declarations.selectedNavBarColor,
        unselectedItemColor: Declarations.unselectedNavBarColor,
        backgroundColor: Declarations.backgroundColor,
        iconSize: 28,
        items:
         [
          getNavBottom(
              icon: Icons.home_outlined,
              title: 'Home',
            index: 0,
              ifCart: false
          ),
           getNavBottom(
             icon: Icons.person_outline,
             title: 'Account',
               index: 1,
               ifCart: false
           ),
           getNavBottom(
             icon: Icons.shopping_cart,
             title: 'Cart',
               index: 2,
               ifCart: true
           ),
        ],
        onTap: updateBadge,

      ),
    );
  }
}


BottomNavigationBarItem getNavBottom({required IconData icon , required String title,required int index,required bool ifCart})
{
  return BottomNavigationBarItem(
    icon: Container(
      width: nbWidth,
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                color: page == index ? Declarations.selectedNavBarColor
                    :Declarations.backgroundColor,
                width: 2,
              )
          )
      ),
      child:  ifCart ? badges.Badge(
          badgeContent:const Text('2'),
          badgeStyle: const badges.BadgeStyle(
            elevation: 0,
            badgeColor: Colors.green,
          ),
          child: Icon(icon)
      )
          : Icon(icon)
    ),
    label: title,
  );

}