import 'package:flutter/material.dart';
import 'package:my_souaq/app/models/language_model.dart';
import 'package:my_souaq/app/screens/search_screen.dart';
import 'package:my_souaq/app/styles/colors.dart';
import 'package:my_souaq/app/widgets/address_bar.dart';
import 'package:my_souaq/app/widgets/carousel_iamge.dart';
import 'package:my_souaq/app/widgets/deal_of_day.dart';
import 'package:my_souaq/app/widgets/top_categories.dart';
import 'package:my_souaq/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/home';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{
  void searchForProduct(String textSearch)
  {
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: textSearch);
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: Declarations.appBarGradient
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: searchForProduct,
                        decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(Icons.search, color: Colors.black,
                                    size: 23),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(top: 10),
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    7)),
                                borderSide: BorderSide.none
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    7)),
                                borderSide: BorderSide(
                                    color: Colors.black38,
                                    width: 1
                                )
                            ),
                            hintText: AppLocalizations.of(context)!.searchInMySouq
                        ),
                      ),
                    )
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                child: DropdownButton<Language>(
                  underline: const SizedBox(),
                  icon: const Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                  onChanged: (Language? language)  {
                    if (language != null) {
                      MyApp.setLocale(context, Locale(language.languageCode, ''));
                    }
                  },
                  items: Language.languageList()
                      .map<DropdownMenuItem<Language>>(
                        (e) => DropdownMenuItem<Language>(
                      value: e,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            e.flag,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ).toList(),
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              AddressBar(),
              SizedBox(height: 10,),
              TopCategories(),
              SizedBox(height: 10,),
              CarouselImage(),
              SizedBox(height: 10,),
              DealOfDay()
            ],
          ),
        )
    );
  }
}
