import 'package:flutter/material.dart';
import 'package:ibe_candidaturas/model/Candidato.dart';

class EstadoCandidatura extends StatefulWidget {


  const EstadoCandidatura({super.key, required this.candidato});
  final Candidato candidato;
  @override
  State<EstadoCandidatura> createState() => _EstadoCandidaturaState();
}

class _EstadoCandidaturaState extends State<EstadoCandidatura> {


  @override
  Widget build(BuildContext context) {
    final candidato = widget.candidato;
    print(candidato.especialidade);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(height: 10,),
          Container(
            
            padding: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color.fromARGB(255, 34, 88, 236),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: Text("Estado da Candidatura", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color.fromARGB(255, 248, 245, 245),
              borderRadius: BorderRadius.circular(10),
            ),
            child:  Padding(
            padding: EdgeInsets.all(10),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Candidato: ", style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(candidato.nome +" "+candidato.apelido, style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
            )
          ),
        

          Card(
            color: Color.fromARGB(246, 220, 219, 224),
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              //side: BorderSide(style: BorderStyle.none, width: 1.0), // Border color and width
              borderRadius: BorderRadius.circular(5.0), // Border radius
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              child:  Padding(
              padding: EdgeInsets.all(15),
              child: Column(
              children: [
                 Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Edital", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('${candidato.edital}', style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Área:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('${candidato.area}', style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Estado", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(candidato.estado, style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Data de Submissão", style: TextStyle(fontWeight: FontWeight.bold)),
                      //Text(widget.data_submissao.substring(0, widget.data_submissao.length - 9), style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                ],
              ),
            )
            ),
          ),
          Card(
            color: Color.fromARGB(246, 220, 219, 224),
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              //side: BorderSide(style: BorderStyle.none, width: 1.0), // Border color and width
              borderRadius: BorderRadius.circular(5.0), // Border radius
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 248, 245, 245),
                borderRadius: BorderRadius.circular(10),
              ),
               child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
              
              children: [
                 Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Especialidade:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(candidato.especialidade, style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Resultado", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("", style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                ],
              ),
            ),
            ),
          ),
        ],
      ),
    );;
  }
}