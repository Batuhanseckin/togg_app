// [ This is an auto generated file ]

import 'package:flutter/material.dart';
import 'package:togg_app/core/router_constants.dart';

import 'package:togg_app/views/login/login_view.dart' as view0;
import 'package:togg_app/views/map/map_view.dart' as view1;
import 'package:togg_app/views/favorites/favorites_view.dart' as view2;

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginViewRoute:
        return MaterialPageRoute(builder: (_) => view0.LoginView());
      case mapViewRoute:
        return MaterialPageRoute(builder: (_) => view1.MapView());
      case favoritesViewRoute:
        return MaterialPageRoute(builder: (_) => view2.FavoritesView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}