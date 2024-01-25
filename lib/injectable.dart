import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:panara_studios/injectable.config.dart';


final getIt=GetIt.instance;
@InjectableInit()
void configureDependencies(){
  getIt.registerFactory<Connectivity>(() => Connectivity());
  getIt.init(  environment: Environment.prod,);}
