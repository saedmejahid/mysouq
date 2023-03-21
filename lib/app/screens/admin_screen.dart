import 'package:flutter/material.dart';
import 'package:my_souaq/app/screens/admin_order_screen.dart';
import 'package:my_souaq/app/screens/analytics_screen.dart';
import 'package:my_souaq/app/screens/posts_screen.dart';
import 'package:my_souaq/app/styles/colors.dart';
import 'package:my_souaq/app/widgets/bottom_bar.dart';
class AdminScreen extends StatefulWidget
{
  const AdminScreen({Key? key}) : super(key: key);
  static const String routeName = "/admin-screen";

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}
class _AdminScreenState extends State<AdminScreen>
{
  @override
  Widget build(BuildContext context)
  {
    List<Widget> pages=
    [
      const PostScreen(),
      const AnalyticsScreen(),
      const AdminOrdersScreen(),
    ];
    void updateBadge(int badge)
    {
      setState((){
        page = badge;
      });
    }
    return  Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: Declarations.appBarGradient
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
          [
            Container(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/images/logo.png',
                width: 95,
                height: 45,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 15,
                  right: 15
              ),
              child: Row(
                children:
                const
                [
                   Text(
                    'Admin Penal',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
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
              icon: Icons.control_point_sharp,
              title: 'Post',
              index: 0,
          ),
          getNavBottom(
              icon: Icons.analytics,
              title: 'Analytics',
              index: 1,
          ),
          getNavBottom(
              icon: Icons.category,
              title: 'Orders',
              index: 2,
          ),
        ],
        onTap: updateBadge,

      ),
    );
  }
}

BottomNavigationBarItem getNavBottom({required IconData icon , required String title,required int index,})
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
        child: Icon(
            icon,
        )
    ),
    label: title,
  );

}

