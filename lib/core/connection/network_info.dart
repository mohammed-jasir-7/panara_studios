

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

abstract class NetworkInfo {
  ///if have internet connection it return true
  ///otherwise return false
  Future<bool>? get isConnected;
}
@Injectable(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected async {
var result =await connectionChecker.checkConnectivity();
return result==ConnectivityResult.none?false:true;
  }
}
