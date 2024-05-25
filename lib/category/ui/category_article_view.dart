import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutternews/category/bloc/category_bloc.dart';
import 'package:flutternews/theme/mythemes.dart';
import 'package:flutternews/widgets/components/bottom_navigation_widget.dart';
import 'package:flutternews/widgets/helpers/loading_animation_widget.dart';
import 'package:flutternews/widgets/tiles/news_article_tile_widget.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class CategoryArticleView extends StatefulWidget {
  final String categoryName;
  const CategoryArticleView({super.key, required this.categoryName});

  @override
  State<CategoryArticleView> createState() => _CategoryArticleViewState();
}

class _CategoryArticleViewState extends State<CategoryArticleView> {
  @override
  void initState() {
    //pass the loading state as soon as the page gets loaded
    context
        .read<CategoryBloc>()
        .add(CategoryDataLoadingEvent(categoryName: widget.categoryName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
      //listener to perform operation other than ui building
      listener: (context, state) {},

      //builder to build the ui
      builder: (context, state) {
        switch (state.runtimeType) {
          //state when the category data is loading
          case CategoryDataLoadingState:
            return const LoadingWidget();

          //state when the category data is loaded
          case CategoryDataLoadedState:
            final categoryDataLoadedState = state as CategoryDataLoadedState;

            return Scaffold(
              appBar: AppBar(
                centerTitle: false,
                leadingWidth: 25,
                toolbarHeight: 70,
                elevation: 0,
                surfaceTintColor: Colors.white,
                shadowColor: Colors.black38,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GradientText(
                      "${widget.categoryName} related articles",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      colors: [
                        MyTheme.myTheme.colorScheme.primary,
                        MyTheme.myTheme.colorScheme.secondary,
                        MyTheme.myTheme.colorScheme.tertiary,
                      ],
                    ),

                    // Text
                  ],
                ),
              ),
              bottomNavigationBar: const BottomNavigation(),
              body: SafeArea(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // Column children
                      children: [
                        // Text

                        //mapping the articles
                        SizedBox(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                categoryDataLoadedState.articleList.length,
                            itemBuilder: (context, index) {
                              // Return your news article tile widget here based on index
                              return NewsArticleTile(
                                      author: categoryDataLoadedState
                                          .articleList[index].author,
                                      title: categoryDataLoadedState
                                          .articleList[index].title,
                                      date: categoryDataLoadedState
                                          .articleList[index].publishedAt,
                                      imageUrl: categoryDataLoadedState
                                          .articleList[index]
                                          .imageUrl, //imageUrl
                                      articleUrl: categoryDataLoadedState
                                          .articleList[index].articleUrl)

                                  //adding the required animations at the end
                                  .animate()
                                  .slideX(
                                      begin: -10,
                                      end: 0,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.fastEaseInToSlowEaseOut,
                                      delay:
                                          Duration(milliseconds: 200 * index));
                            },
                          ),
                        ),
                      ]),
                ),
              )),
            );

          // default container to be returned
          default:
            return Container();
        }
      },
    );
  }
}
