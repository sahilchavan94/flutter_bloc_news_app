import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/category/ui/category_selection_view.dart';
import 'package:flutternews/home/ui/home_view.dart';
import 'package:flutternews/widgets/helpers/icon_widget.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconWidget(
                icon: Icon(
                  CupertinoIcons.home,
                  size: 18,
                ),
                navigationComponent: HomeView(),
              ),
              IconWidget(
                icon: Icon(
                  CupertinoIcons.list_bullet,
                  size: 18,
                ),
                navigationComponent: CategorySelectionView(),
              ),
              IconWidget(
                icon: Icon(
                  CupertinoIcons.globe,
                  size: 18,
                ),
              ),
              IconWidget(
                icon: Icon(
                  CupertinoIcons.heart,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
