// config.dart
library config;
import 'package:connectivity_plus/connectivity_plus.dart';
//final String IP = "192.168.10.110:5285";
final String IP = "5.189.138.20:8999";
//final String IP = "localhost:5289";


Future<NetworkCheckResponse> isConnected() async {
  final connectivityResult = await Connectivity().checkConnectivity();
  
  print('Connectivity Result: $connectivityResult'); // Debug print

  if (connectivityResult == ConnectivityResult.none) {
    return new NetworkCheckResponse(
      state: false,
      mesg: "Não conectado à rede",
    );
  } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.vpn || connectivityResult == ConnectivityResult.other) {
    return new NetworkCheckResponse(
      state: true,
      mesg: "Conectado à rede: ${connectivityResult.toString()}",
    );
  } else {
    // Handle other possible connectivity results if needed
    return new NetworkCheckResponse(
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