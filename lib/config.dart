// config.dart
library config;

import 'package:connectivity_plus/connectivity_plus.dart';

final String IP = "109.123.241.5:8084";
//final String IP = "5.189.138.20:8999";
//final String IP = "localhost:5287";

Future<NetworkCheckResponse> isConnected() async {
  try {
    //final connectivityResult = await Connectivity().checkConnectivity();
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    print('Connectivity Result: $connectivityResult'); // Debug print

    if (connectivityResult.contains(ConnectivityResult.none)) {
      return NetworkCheckResponse(
        state: false,
        mesg: "Não conectado à rede",
      );
    } else if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return NetworkCheckResponse(
        state: true,
        mesg: "Conectado à rede móvel",
      );
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return NetworkCheckResponse(
        state: true,
        mesg: "Conectado à rede Wi-Fi",
      );
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      return NetworkCheckResponse(
        state: true,
        mesg: "Conectado à rede Ethernet",
      );
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      return NetworkCheckResponse(
        state: true,
        mesg: "Conectado através de VPN",
      );
    } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
      return NetworkCheckResponse(
        state: true,
        mesg: "Conectado através de Bluetooth",
      );
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
      return NetworkCheckResponse(
        state: true,
        mesg: "Conectado a uma rede desconhecida",
      );
    } else {
      return NetworkCheckResponse(
        state: false,
        mesg: "Estado de rede desconhecido",
      );
    }
  } catch (e) {
    // Handle possible exceptions (e.g., no permission to access connectivity)
    return NetworkCheckResponse(
      state: false,
      mesg: "Erro ao verificar a conectividade: ${e.toString()}",
    );
  }
}

class NetworkCheckResponse {
  late bool state;
  late String mesg;
  NetworkCheckResponse({required this.state, required this.mesg});
}
