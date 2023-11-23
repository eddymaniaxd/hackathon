import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:topicos_proy/src/models/denuncia.dart';
import 'package:topicos_proy/src/util/Files.dart';

class DenunciaRepository {
  DenunciaRepository();

  final CollectionReference _denuncia =
      FirebaseFirestore.instance.collection('denuncia');

  CollectionReference get denuncia => _denuncia;

  List _allDatasDenuncia = [];
  List get allDatasDenuncia => _allDatasDenuncia;

  Future<void> create(Map<String, dynamic> data) async {
    await _denuncia.add(data);
  }

  Future<void> createWithImage(Map<String, dynamic> data, String uid) async {
    print("DATA FIRESTORE ${data}");
    await _denuncia.doc(uid).set(data);
  }

  Future<List<Denuncia>> getAll() async {
    QuerySnapshot querySnapshot = await _denuncia.get();
    return _convertDocumentToModel(querySnapshot.docs);
  }

  uploadDataFirestore(Map<String, dynamic> dataFirestore, String uid) {
    createWithImage(dataFirestore, uid);
  }

  uploadDataStorage(List<Map<String, dynamic>> dataStorage) {
    dataStorage.forEach((element) {
      // print(element);
      Files.upLoadImage(
          element["path_img"], element["name_img"], element["file"]);
    });
  }

  _convertDocumentToModel(List<DocumentSnapshot> snapshots) {
    List<Denuncia> denuncias = [];
    for (var data in snapshots) {
      Denuncia denuncia = Denuncia.fromJson({
        "description": data["description"],
        "greenhouse": data["greenhouse"],
        "date": data["date"],
        "hour": data["hour"],
      });
      denuncias.add(denuncia);
    }

    return denuncias;
  }
}
