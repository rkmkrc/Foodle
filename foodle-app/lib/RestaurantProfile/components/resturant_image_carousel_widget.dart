import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

CarouselSlider RestaurantImageCarouselWidget(List<String> imgPaths) {
    return CarouselSlider(
          options: CarouselOptions(scrollPhysics: BouncingScrollPhysics()),
          items: imgPaths.map((imgPath) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 0.8),
                    child: Image.asset(imgPath, fit: BoxFit.cover,));
              },
            );
          }).toList(),
        );
  }