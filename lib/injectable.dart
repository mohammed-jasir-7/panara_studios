import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:panara_studios/injectable.config.dart';

final getIt = GetIt.instance;
@InjectableInit()
void configureDependencies() {
  getIt.registerFactory<Connectivity>(() => Connectivity());
   getIt.registerLazySingleton<FilePicker>(() => FilePicker.platform);
  getIt.init(
    environment: Environment.prod,
  );
}
