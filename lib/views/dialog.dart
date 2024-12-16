import 'package:flutter/material.dart';


   void _showForm(BuildContext context) {
    
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
                Text("Informação", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10), // Space between title and content
                Text("Caro candidato, preencha todos os campos, e certifique se todos dados forma preenchidos correctamente antes de submeter"),
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

