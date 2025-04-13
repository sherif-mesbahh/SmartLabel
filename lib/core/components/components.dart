import 'package:flutter/material.dart';

// 1. Slide from Right to Left
PageRouteBuilder slideRightToLeft(Widget page) => PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) => SlideTransition(
        position: Tween(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.ease)),
        child: child,
      ),
    );

PageRouteBuilder slideLeftToRigth(Widget page) => PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) => SlideTransition(
        position: Tween(
          begin: const Offset(-1.0, 0.0), // 👈 from left
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.ease,
        )),
        child: child,
      ),
    );

// 2. Slide from Bottom to Top
PageRouteBuilder slideBottomToTop(Widget page) => PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.ease)),
        child: child,
      ),
    );

// 3. Fade Transition
PageRouteBuilder fadeTransition(Widget page) => PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) => FadeTransition(
        opacity: animation,
        child: child,
      ),
    );

// 4. Scale Transition
PageRouteBuilder scaleTransition(Widget page) => PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) => ScaleTransition(
        scale: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: child,
      ),
    );
void pushNavigator(BuildContext context, Widget page,
    PageRouteBuilder Function(Widget) animation) {
  Navigator.push(context, animation(page));
}

void navigatorReplacement(BuildContext context, Widget page,
    PageRouteBuilder Function(Widget) animation) {
  Navigator.pushReplacement(context, animation(page));
}

void navigatorAndRemove(BuildContext context, Widget page,
    PageRouteBuilder Function(Widget) animation) {
  Navigator.pushAndRemoveUntil(context, animation(page), (route) => false);
}

void popNavigator(BuildContext context) => Navigator.pop(context);
