import 'package:flutternews/category/bloc/category_bloc.dart';
import 'package:flutternews/home/bloc/home_bloc.dart';
import 'package:flutternews/providers/route_provider.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void initBlocs() async {
  //register the home bloc
  serviceLocator.registerLazySingleton(() => HomeBloc());
  serviceLocator.registerLazySingleton(() => CategoryBloc());
  serviceLocator.registerLazySingleton(() => RouteProvider());
}
