import 'dart:ui';

class Dimensions{

  static double screenWidth = window.physicalSize.shortestSide;
  static double screenHeight = window.physicalSize.longestSide;

  static double pageViewContainer = screenHeight/3.84;
  static double pageViewTextContainer = screenHeight/7.03;
  static double pageView = screenHeight/2.64;

  //dynamic height padding and margin
  static double height10 = screenHeight/84.4;
  static double height15 = screenHeight/56.27;
  static double height20 = screenHeight/42.2;
  static double height30 = screenHeight/28.13;
  static double height45 = screenHeight/18.76;
  //dynamic width padding and margin
  static double width10 = screenHeight/84.4;
  static double width15 = screenHeight/56.27;
  static double width20 = screenHeight/42.2;
  static double width30 = screenHeight/28.13;
  static double width45 = screenHeight/18.76;

  //font size
  static double font16 = screenHeight/52.75;
  static double font20 = screenHeight/42.2;
  static double font26 = screenHeight/32.46;

  //radius
  static double radius1 = screenHeight/95.55;
  static double radius5 = screenHeight/85.55;
  static double radius10 = screenHeight/68.27;
  static double radius15 = screenHeight/56.27;
  static double radius20 = screenHeight/42.2;
  static double radius30 = screenHeight/28.13;

  //icon size
  static double iconSize24 = screenHeight/35.17;
  static double iconSize16 = screenHeight/52.75;
  static double iconSize10 = screenHeight/60.17;

  //list view size
  static double listViewImgSize = screenWidth / 3.25;
  static double listViewTextContSize = screenWidth / 3.9;

  //popular food
  static double popularFoodImgSize = screenHeight / 2.41;

  //bottom height
  static double bottomHeightBar = screenHeight/7.03;

  static double size20 = screenHeight / 34.15;
  static double size25 = screenHeight / (screenHeight / 25);

  //splash screen dimensions
  static double splashImg = screenHeight / 3.38;

}