import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutternews/category/bloc/category_bloc.dart';
import 'package:flutternews/home/bloc/home_bloc.dart';
import 'package:flutternews/init_dependencies.dart';
import 'package:flutternews/providers/route_provider.dart';
// import 'package:flutternews/category/ui/category_article_view.dart';
import 'package:flutternews/splash/ui/splash_view.dart';
import 'package:provider/provider.dart';

void main() async {
  initBlocs();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<HomeBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<CategoryBloc>(),
      ),
      ChangeNotifierProvider(
        create: (_) => serviceLocator<RouteProvider>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),
    );
  }
}
