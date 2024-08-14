import 'package:flutter/material.dart';

class Help_center extends StatefulWidget {
  const Help_center({super.key});

  @override
  State<Help_center> createState() => _Help_centerState();
}

class _Help_centerState extends State<Help_center> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(
            "IBE - Portal do Candidatos",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color.fromARGB(255, 34, 88, 236),
          actions: <Widget>[
            IconButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Ajuda e Suporte'),
                  content: const Text('Seção com perguntas frequentes e respostas, e Informações de contato para suporte técnico e administrativo. Clique OK para continuar'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Help_center()),
                          );
                        },
                        child: const Text('OK'),
                      ),

                  ],
                ),
              ),
              icon: Icon(Icons.help, color: Colors.white))
          ],
          iconTheme: IconThemeData(color: Colors.blue[900]),
        ),
        body: ListView(
      children: [
        Text("FAQ e Suporte",  style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold)),
        Column(
          
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [ 
                  Text("Contacte - nos:", style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ),
              Card(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.email, color: Colors.blue[900],),
                        Text("secretaria@ibe.gov.mz")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.phone, color: Colors.blue[900],),
                        Text("(+258) 21488826")
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [ 
                  Text("Ou escreva", style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ),
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: TextFormField(
              //controller: _emailController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Mensagem:"),
                icon: Icon(Icons.message, color: Colors.blue[900]),
                hintText: "Escreva a Mensagem",
              ),
            ),
          ),

           Container(
            padding: EdgeInsets.all(40),
            child: ElevatedButton(
              onPressed: () {
                //Navigator.pushNamed(context, "/cadastro");
              },
              child: Text(
                "Enviar",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
              ),
            ),
          ),
        
      ],
    ),
    );  
  }
}