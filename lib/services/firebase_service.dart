import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final buckets = FirebaseStorage.instanceFor(bucket: "gs://my-custom-bucket");

FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;

Future<bool> addBandejaDeEntrada(
    String name, String email, String message) async {
  Map<String, dynamic> conversion = {
    "nombre": name,
    "email": email,
    "mensaje": message
  };

  try {
    await db.collection("Bandeja de entrada").add(conversion);
    //print('Operación exitosa: Mensaje enviado correctamente');
    return true;
  } catch (e) {
    //print('Error al enviar el mensaje: $e');
    return false;
  }
}

Future<List> getSection(String folder) async {
  List documentList = [];

  CollectionReference collectionReference = db.collection(folder);

  QuerySnapshot querySnapshot = await collectionReference.get();

  for (var documento in querySnapshot.docs) {
    documentList.add(documento.data());
  }

  return documentList;
}



