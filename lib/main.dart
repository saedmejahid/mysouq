import 'package:flutter/material.dart';
import 'package:my_souaq/app/screens/admin_screen.dart';
import 'package:my_souaq/app/screens/auth_screen.dart';
import 'package:my_souaq/app/services/auth_services.dart';
import 'package:my_souaq/app/styles/theme.dart';
import 'package:my_souaq/app/widgets/bottom_bar.dart';
import 'package:my_souaq/provider/user_provider.dart';
import 'package:my_souaq/router.dart';
import 'package:provider/provider.dart';
void main()
{
  runApp(MultiProvider(providers:
  [
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ], child: const MyApp()));
}
class MyApp extends StatefulWidget
{
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp>
{
  final AuthServices  authServices = AuthServices();
  @override
  void initState()
  {
    super.initState();
    authServices.getUserDate(context);
  }
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Souq',
      theme: appTheme,
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context)
          .user
          .token
          .isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'
          ? const BottomBar()
          :const AdminScreen()
          : const AuthScreen()
    );
  }
}
