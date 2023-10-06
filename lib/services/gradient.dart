import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Patch {
  Container a = Container(
    height: 450,
    width: 450,
    child: Image.asset('assets/images/Ellipse 2.png'),
    // decoration: BoxDecoration(
    //   shape: BoxShape.circle,
    //   gradient: RadialGradient(
    //     colors: [
    //       Color.fromARGB(255, 175, 223, 167).withOpacity(0.15),
    //       Colors.white
    //     ],
    //     radius: 0.45,
    //     tileMode: TileMode.clamp,
    //   ),
    // ),
    // child: BackdropFilter(
    //     blendMode: BlendMode.softLight,
    //     filter: ImageFilter.blur(sigmaX: 48, sigmaY: 48)),
  );

  Container b = Container(
    height: 406,
    width: 406,
    child: Image.asset('assets/images/Ellipse 1.png'),
    // decoration: BoxDecoration(
    //   //shape: BoxShape.circle,
    //   gradient: RadialGradient(
    //     colors: [
    //       Color.fromARGB(255, 175, 223, 167).withOpacity(0.05),
    //       Colors.white
    //     ],
    //     radius: 0.45,
    //     tileMode: TileMode.clamp,
    //   ),
    // ),
    // child: BackdropFilter(
    //     blendMode: BlendMode.softLight,
    //     filter: ImageFilter.blur(sigmaX: 112, sigmaY: 112)),
  );

  Container c = Container(
    height: 536,
    width: 536,
    child: Image.asset('assets/images/Ellipse 7.png'),
    // decoration: BoxDecoration(
    //   shape: BoxShape.circle,
    //   gradient: RadialGradient(colors: [
    //     Color.fromARGB(255, 175, 223, 167).withOpacity(0.10),
    //     Colors.white
    //   ], radius: 0.45, tileMode: TileMode.clamp),
    // ),
    // child: BackdropFilter(
    //     blendMode: BlendMode.softLight,
    //     filter: ImageFilter.
    //     blur(sigmaX: 112, sigmaY: 112)),
  );
}
