import 'package:flutter/material.dart';
import 'package:my_souaq/components/components.dart';
class TopCategories extends StatelessWidget {
  const TopCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemCount: Components.catImages.length,
        itemExtent: 75,
        scrollDirection: Axis.horizontal,
          itemBuilder: (context,index)
          {
            return Column(
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
            );
          },
      ),
    );
  }
}
