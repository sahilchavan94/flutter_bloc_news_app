import 'package:flutter/material.dart';
import 'package:flutternews/category/ui/category_selection_view.dart';
import 'package:flutternews/home/ui/home_view.dart';
import 'package:flutternews/providers/route_provider.dart';
import 'package:provider/provider.dart';

class IconWidget extends StatelessWidget {
  final Icon icon;
  final dynamic navigationComponent;
  const IconWidget({super.key, required this.icon, this.navigationComponent});

  @override
  Widget build(BuildContext context) {
    return Consumer<RouteProvider>(
      builder: (context, routeProvider, child) {
        //i know this login and approach is not good, but this make things work
        return IconButton(
          onPressed: () {
            // log("${navigationComponent is HomeView}");
            // log("${routeProvider.currentRouteIndex}");

            if (navigationComponent == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No route added yet'),
                  duration: Durations.extralong4,
                ),
              );
              return;
            }

            if (routeProvider.currentRouteIndex == 1 &&
                navigationComponent is HomeView) {
              return;
            }
            if (routeProvider.currentRouteIndex == 2 &&
                navigationComponent is CategorySelectionView) {
              return;
            }

            if (navigationComponent is HomeView) {
              routeProvider.setRouteIndex(1);
              // log("current is ${routeProvider.currentRouteIndex.toString()}");
            }
            if (navigationComponent is CategorySelectionView) {
              routeProvider.setRouteIndex(2);
              // log("current is ${routeProvider.currentRouteIndex.toString()}");
            }

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => navigationComponent,
              ),
            );
          },
          icon: icon,
        );
      },
    );
  }
}
