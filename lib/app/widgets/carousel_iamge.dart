import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_souaq/app/models/category_model.dart';
class CarouselImage extends StatelessWidget
{
  const CarouselImage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context)
  {
    return CarouselSlider(
      items: Components.carouselImages.map((element){
        return Builder(
          builder: (BuildContext context) => Image.network(
            element,
            fit: BoxFit.cover,
            height: 200,
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 200,
        aspectRatio: 16/9,
        viewportFraction: 1,
        initialPage: 1,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 1),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.easeInOut,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
