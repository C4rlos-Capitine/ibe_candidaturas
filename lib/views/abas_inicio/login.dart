import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/config.dart';
import 'package:ibe_candidaturas/controllers/AuthController.dart';
import 'package:ibe_candidaturas/controllers/EmailSendig.dart';
import 'package:ibe_candidaturas/controllers/candidatoController.dart';
import 'package:ibe_candidaturas/http_response/http_response.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:flutter/gestures.dart';
import 'dart:async';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _senha = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController codigo_authController = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = true;



  final List<String> images = [
    'assets/images/graduate.png',
    'assets/images/graduados.jpg',
  ];

  late PageController _pageController;
  late Timer _timer;
    int _seconds = 120;
    int _currentPage = 0;
    String texto_tempo = "";

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

   void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if(_seconds==1){
        _stopTimer();
      }
      setState(() {
        _seconds--;
        texto_tempo = "faltam $_seconds segundos";
        print(_seconds);
      });
    });
    }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _seconds = 120;
    });
  }

   void _showAuthForm(BuildContext context) {
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 300, // Set your desired width
            height: 350, // Set your desired height
            padding: EdgeInsets.all(16.0), // Add some padding
            child: Column(
              mainAxisSize: MainAxisSize.min, // Use min size to wrap content
              children: [
                Text("Código de autenticação", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10), // Space between title and content
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: codigo_authController,
                        decoration: InputDecoration(
                          labelText: 'Insira o Código enviado para o seu email aqui',
                          labelStyle: TextStyle(color: Colors.blueAccent),
                          border: InputBorder.none,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo Vázio, escreva o código';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          // _firstInputValue = value!;
                        },
                      ),
                      SizedBox(height: 20), // Space between input and button
                      ElevatedButton(
                        onPressed: () async{
                          ResquestResponse response  = await SecoundAtuthentication(_email.text, codigo_authController.text);
                          if(response.success){
                            _stopTimer();
                            _finishLogIn(_email.text, _senha.text);
                          }else{
                             ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${response.message}'),
                                backgroundColor: Color.fromARGB(255, 235, 77, 3),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                        ),
                        child: Text(
                          "Entrar",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Não recebeu o email com o codigo? ',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                              text: 'Tente novamente',
                              style: TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  SendAuthRequest(_email.text);
                                }),
                        ]),
                      ),
                    ),
                              ],
                  ),
                ),
                SizedBox(height: 10), // Space between content and actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text("Close", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );

      },
    );
  }

  Future<void> _handleLogin() async {
    // Validação dos campos
    if (_email.text.isEmpty || _senha.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Preencha todos os campos'),
          backgroundColor: Color.fromARGB(255, 235, 77, 3),
        ),
      );
      return;
    }

    RegExp emailRegExp = RegExp(
        r'^[^@]+@[^@]+\.[^@]+',
      );

      if (emailRegExp.hasMatch(_email.text)) {
        print("Email válido.");
      } else {
        print("Email inválido.");
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('email deve conter @'),
          backgroundColor: Color.fromARGB(255, 235, 77, 3),
        ),
      );
         return;
      }

    // Verificar a conexão com a internet
    bool connected = await _checkNetworkStatus();
    if (!connected) {
      // Mostrar mensagem de erro se não estiver conectado
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verifique se o wifi ou dados estão ligados'),
          backgroundColor: Color.fromARGB(255, 235, 77, 3),
        ),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // Tentar fazer login via internet
    bool internetLoginSuccess = false;
    Candidato? candidato;

    try {
      internetLoginSuccess = await login(_email.text, _senha.text);
      if(internetLoginSuccess){
        SendAuthRequest(_email.text);
        _startTimer();
        _showAuthForm(context);
        return;
      }else {
        candidato = await attemptLocalLogin(_email.text, _senha.text);
        if (candidato == null) {
          PanaraInfoDialog.showAnimatedGrow(
            context,
            title: "Mensagem de Erro",
            message: "Dados incorretos.",
            buttonText: "Okay",
            color: Colors.white,
            onTapDismiss: () {
              Navigator.pop(context);
            },
            panaraDialogType: PanaraDialogType.error,
          );
        }
      }
    } catch (e) {
      print('Error during internet login: $e');
    }


  }

  Future <void> _finishLogIn(String email, String senha) async{
    Candidato? candidato;
    candidato = await getData(email, senha);
    if (candidato != null) {
      Navigator.pushNamed(context, "/home", arguments: candidato);
    }
        // Ocultar carregamento
    setState(() {
      _isLoading = false;
    });

  }

  Future<bool> _checkNetworkStatus() async {
    try {
      final response = await isConnected();
      return response.state;
    } catch (error) {
      print('Error: $error');
      return false;
    }
  }

  void _startImageSlider() {
    _timer = Timer.periodic(Duration(seconds: 15), (Timer timer) {
      if (_currentPage < images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startImageSlider();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
              padding: EdgeInsets.symmetric(vertical: 1),
              child: Image.asset('assets/images/logotipo_header.png'),
            ),
            SizedBox(height: 15),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _email,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  label: Text("Email"),
                  icon: Icon(Icons.mail_outline, color: Colors.blue[900]),
                  hintText: "Email",
                  labelStyle: TextStyle(color: Colors.blue[900]),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _senha,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  label: Text("Senha"),
                  icon: Icon(Icons.key_outlined, color: Colors.blue[900]),
                  hintText: "Senha",
                  labelStyle: TextStyle(color: Colors.blue[900]),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.blue[900],
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _handleLogin,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[900],
                              fixedSize: Size(300, 50)),
                          child: Text(
                            "Entrar",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Perdeu sua senha? ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                      text: 'Recupere clicando aqui',
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Recovery process
                        }),
                ]),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),

      // Use the `bottomNavigationBar` property for the bottom bar
      bottomNavigationBar: Container(
        color: Colors.white,  // Set any color for the bar
        height: 30.0,            // Height of the bar
        child: Center(
          child: Text(
            'Copyright © 2024 | Quidgest',
            style: TextStyle(color: Colors.blue[900]),
          ),
        ),
      ),
    );
  }
}
