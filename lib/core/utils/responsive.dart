
import 'package:flutter/material.dart';
import 'dart:math' as math;


class Responsive {
  double _width = 20, _height = 200, _diagonal = 200;
  bool _isTablet=false;

  double get width => _width;
  double get height => _height;
  double get diagonal => _diagonal;
  bool get isTablet => _isTablet;

  static Responsive of(BuildContext context) => Responsive(context);

  Responsive(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _width = size.width;
    _height = size.height;
    _diagonal = math.sqrt(math.pow(_width, 2) + math.pow(_height, 2));

    //get que retorne el menor valor de las magnitudes, sea ancho o altura. Calcula ancho y alto y dice cuál es más pequeño
   _isTablet = size.shortestSide>=600;


  }

  double wp(double percent) => _width * percent / 100;

  double hp(double percent) => _height * percent / 100;

  double dp(double percent) => _diagonal * percent / 100;
}