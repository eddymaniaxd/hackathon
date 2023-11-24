import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistorialPage extends StatelessWidget {
  const HistorialPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial Denuncias:'),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('denuncia').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          var documentos = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documentos.length,
            itemBuilder: (context, index) {
              var documento = documentos[index].data() as Map<String, dynamic>;
              print(documento);
              // Aquí puedes construir la interfaz de usuario con los datos del documento
              return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text('Alerta de robo'),
                      subtitle: Text(documento['description']),
                      leading: const Icon(Icons.notification_add),
                      trailing: IconButton(
                        onPressed: () {
                          print("ver más");
                        },
                        icon: const Icon(Icons.arrow_forward_ios),
                      ),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide( width: 2 ),
                        borderRadius: BorderRadius.circular(20)
                      ),

                    ),
                  );
            },
          );
        },
      ),
    );
  }
}
