import 'package:get_it/get_it.dart';

import '../screens/home/home_screen_manager.dart';

var getit = GetIt.instance;
void setupGetIt() async {
  getit.registerLazySingleton<HomeManager>(() => HomeManager());
}
