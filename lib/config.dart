// config.dart
library config;
import 'package:connectivity_plus/connectivity_plus.dart';
final String IP = "192.168.10.162:5287";
//final String IP = "192.168.10.162:5286";


Future<NetworkCheckResponse> isConnected() async {
  final connectivityResult = await Connectivity().checkConnectivity();
  
  print('Connectivity Result: $connectivityResult'); // Debug print

  if (connectivityResult == ConnectivityResult.none) {
    return NetworkCheckResponse(
      state: false,
      mesg: "Não conectado à rede",
    );
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.vpn || connectivityResult == ConnectivityResult.other) {
    return NetworkCheckResponse(
      state: true,
      mesg: "Conectado à rede: ${connectivityResult.toString()}",
    );
  } else {
    // Handle other possible connectivity results if needed
    return NetworkCheckResponse(
      state: false,
      mesg: "Estado de rede desconhecido",
    );
  }
}

class NetworkCheckResponse{
  late bool state;
  late  String mesg;
  NetworkCheckResponse({required this.state,required this.mesg});
}