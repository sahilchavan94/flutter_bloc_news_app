import 'package:flutter/cupertino.dart';

class RouteProvider extends ChangeNotifier {
  int currentRouteIndex = 1;

  void setRouteIndex(int newIndex) {
    currentRouteIndex = newIndex;

    notifyListeners();
  }
}
