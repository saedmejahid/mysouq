import 'package:flutter/material.dart';
import 'package:my_souaq/app/screens/start_screen.dart';
import 'package:my_souaq/app/services/auth_services.dart';
import 'package:my_souaq/app/styles/theme.dart';
import 'package:my_souaq/app/widgets/bottom_bar.dart';
import 'package:my_souaq/provider/user_provider.dart';
import 'package:my_souaq/router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  static void setLocale(BuildContext context, Locale newLocal) {
    _MyAppState? state = context.findRootAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocal);
  }

}
class _MyAppState extends State<MyApp>
{
  final AuthServices  authServices = AuthServices();
  Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
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
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
        // onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context)
          .user
          .token
          .isNotEmpty
          ? const BottomBar()
          : const StartScreen()
    );
  }
}
