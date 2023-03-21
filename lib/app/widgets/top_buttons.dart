import 'package:flutter/material.dart';
import 'package:my_souaq/app/screens/admin_screen.dart';
import 'package:my_souaq/app/services/auth_services.dart';
import 'package:my_souaq/app/widgets/account_button.dart';
import 'package:my_souaq/components/utils.dart';
import 'package:my_souaq/provider/user_provider.dart';
import 'package:provider/provider.dart';
class TopButtons extends StatefulWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  final AuthServices authService = AuthServices();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: "wish list",
              onClick: () {},
            ),
            AccountButton(
              text: "log out",
              onClick: () {
                showAlertDialog(
                    context, () {
                  authService.logOut(context);
                },
                    'Stop',
                    'Do you want to log out ?'
                );
              },
            )
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            AccountButton(
              text: "admin Tools",
              onClick: () {
                if (user.type == "admin") {
                  Navigator.pushNamed(context, AdminScreen.routeName);
                } else {
                  showAlertDialog2(
                      context, 'Stop', 'you don\'t have an access permission');
                }
              },
            )
          ],
        ),
      ],
    );
  }
}


