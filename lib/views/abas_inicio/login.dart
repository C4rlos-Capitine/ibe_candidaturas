import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/config.dart';
import 'package:ibe_candidaturas/controllers/EmailSendig.dart';
import 'package:ibe_candidaturas/controllers/candidatoController.dart';
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
  bool _isLoading = false;
  bool _obscureText = true;

  final List<String> images = [
    'assets/images/graduate.png',
    'assets/images/graduados.jpg',
  ];

  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

   void _showAuthForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 300, // Set your desired width
            height: 250, // Set your desired height
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
                        decoration: InputDecoration(
                          labelText: 'Insira o Código aqui',
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
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          // _firstInputValue = value!;
                        },
                      ),
                      SizedBox(height: 20), // Space between input and button
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                        ),
                        child: Text(
                          "Entrar",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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


    // Mostrar carregamento
    setState(() {
      _isLoading = true;
    });

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
      if (internetLoginSuccess) {
        candidato = await getData(_email.text, _senha.text);
       
      }
    } catch (e) {
      print('Error during internet login: $e');
    }

    // Se o login via internet falhar, tentar login local
    if (!internetLoginSuccess) {
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

    // Navegar para a tela inicial se o login for bem-sucedido
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
      body: ListView(
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
                  //onPressed: _handleLogin,
                  onPressed: () {
                    _showAuthForm(context);
                  },
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
                        PanaraInfoDialog.showAnimatedGrow(
                          context,
                          title: "Aviso",
                          message: "Um email com nova senha será enviado para o ." +
                              _email.text,
                          buttonText: "Okay",
                          color: Colors.white,
                          onTapDismiss: () async {
                            bool recovery = await recoverPassword(_email.text);
                            if (recovery == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Senha alterada. Verifique sua caixa de emails'),
                                  backgroundColor: Color.fromARGB(255, 20, 212, 24),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Erro ao alterar a senha'),
                                  backgroundColor: Color.fromARGB(255, 235, 77, 3),
                                ),
                              );
                            }
                            Navigator.pop(context);
                          },
                          panaraDialogType: PanaraDialogType.normal,
                        );
                      }),
              ]),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 300,
            height: 300,
            padding: EdgeInsets.symmetric(vertical: 1),
            child: PageView.builder(
              controller: _pageController,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
