import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ibe_candidaturas/config.dart';

Dio dio = Dio();

/*
void uploadFiles(String email, File bi, File nuit, File certificado, File foto) async {

    try {
      String url = 'http://$IP/api/Upload/upload?email$email'; // Substitua com o URL da sua API

      FormData formData = FormData.fromMap({
        'bi': await MultipartFile.fromFile(bi.path, filename: "bi"),
        'nuit': await MultipartFile.fromFile(nuit.path, filename: "nuit"),
        'certificado': await MultipartFile.fromFile(certificado.path, filename: "certificado"),
        'foto': await MultipartFile.fromFile(foto.path, filename: "foto"),
        'email': email,
      });
       await dio.post(url, data: formData, onSendProgress: (int sent, int total) {
        print("tota: ${total} sent: ${sent}");
      });
    } catch (e) {
      print(e);
    }
  }*/