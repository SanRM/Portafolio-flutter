import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<bool> addBandejaDeEntrada(
    String name, String email, String message) async {
  Map<String, dynamic> conversion = {
    "nombre": name,
    "email": email,
    "mensaje": message
  };

  try {
    await db.collection("Bandeja de entrada").add(conversion);
    print('Operación exitosa: Mensaje enviado correctamente');
    return true;
  } catch (e) {
    print('Error al enviar el mensaje: $e');
    return false;
  }
}

Future<List> getProjects() async {
  List projects = [];

  CollectionReference collectionReference = db.collection("Lista de proyectos");

  QuerySnapshot querySnapshot = await collectionReference.get();

  querySnapshot.docs.forEach((documento) {
    projects.add(documento.data());
  });

  return projects;
}




