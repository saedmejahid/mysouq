import 'package:flutter/material.dart';
import 'package:my_souaq/app/models/category_model.dart';
import 'package:my_souaq/app/screens/category_deal_screen.dart';
class TopCategories extends StatelessWidget
{
  const TopCategories({Key? key}) : super(key: key);
  void toCategoryPage(BuildContext context,String category)
  {
    Navigator.pushNamed(context, CategoryDeal.routeName,arguments: category);
  }
  @override
  Widget build(BuildContext context)
  {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemCount: Components.catImages.length,
        itemExtent: 75,
        scrollDirection: Axis.horizontal,
          itemBuilder: (context,index)
          {
            return GestureDetector(
              onTap: ()
              {
                toCategoryPage(
                  context,
                    Components.catImages[index]['title']!
                );
              },
              child: Column(
                children:
                [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Image.asset(
                      Components.catImages[index]['image']!,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                      Components.catImages[index] ['title']!
                  ),
                ],
              ),
            );
          },
      ),
    );
  }
}
