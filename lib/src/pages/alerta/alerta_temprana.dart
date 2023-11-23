import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:topicos_proy/src/repositories/denuncia_repository.dart';
import 'package:topicos_proy/src/util/Files.dart';
import 'package:topicos_proy/src/widget/alert_dialog.dart';
import 'dart:io'; //MANEJO DE ARCHIVOS
import 'dart:ui' as ui;

import 'package:topicos_proy/src/widget/widgets.dart';

class AlertaTemprana extends StatefulWidget {
  const AlertaTemprana({super.key});

  @override
  State<AlertaTemprana> createState() => _AlertaTempranaState();
}

class _AlertaTempranaState extends State<AlertaTemprana> {
  //VARIABLES DEFINIDAS
  List<File> _images = [];

  String _selectCategoria = "0";

  TextEditingController? _descripcionController = TextEditingController();

  TextEditingController? _tituloController;

  final _formKey = GlobalKey<FormState>();

  final picker = ImagePicker();

  DenunciaRepository denunciaRepository = DenunciaRepository();
  //Files files = Files("denuncias");
  List<Files> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    var locationSelected = ModalRoute.of(context)!.settings.arguments; //Recover location selected
    print("Location: ${locationSelected}");

    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Registrar Alerta Temprana'),
          ),
          elevation: 10,
        ),
        body: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsetsDirectional.all(20),
            child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Seleccionar Fotografia:'),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        //Navigator.pop(context);
                        choiceImage();
                      },
                      child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/img/gallery.png',
                                  height: 60,
                                  width: 60,
                                ),
                                const Text("Abrir galeria")
                              ],
                            ),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        //Navigator.pop(context);
                        choiceImageCamera();
                      },
                      child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/img/camera.png',
                                  height: 60,
                                  width: 60,
                                ),
                                const Text('Abrir Cámara'),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text('Descripción:'),
                TextFormField(
                  controller: _descripcionController,
                  validator: (value) {
                    if (value!.isEmpty) return "Campo requerido";
                    return null;
                  }
                ),
                Card(
                  
                  child: Row(
                    children: const [
                      Text("Categorías"),
                      CheckboxAlerta()
                    ],
                  )

                ),
                const SizedBox(
                  height: 30,
                ),
                _gallery(),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    //Navigator.pop(context, 'Cancel');
                    if (_formKey.currentState!.validate() &&
                        selectedImages.isNotEmpty) {
                      print(_descripcionController!.value.text);
                      for (var image in selectedImages) {
                        print(basename(image.getfile!.path));
                        print(image.getfile);
                        print(image.getPath);
                        // denunciaRepository.uploadDataStorage([
                        //   {
                        //     "name_img": basename(files.getfile!.path),
                        //     "path_img": files.getPath,
                        //     "file": files.getfile,
                        //   }
                        // ]);
                      }
                    } else {
                      Widgets.alertSnackbar(context, "Imagen no seleccionada!");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Ajusta el radio según tus necesidades
                    ),
                    minimumSize: const Size(
                        2000, 50), // Ajusta el tamaño del botón rectangular
                  ),
                  child: const Text('Registrar Alerta'),
                ),
              ],
            ),
          ),
        ));
  }

  _gallery() {
    if (selectedImages == null || selectedImages.isEmpty) {
      return const Text("");
    }

    return SizedBox(
      height: 350.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: selectedImages.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: const BorderRadius.all(Radius.circular(30.0))),
              child:
                  Image.file(selectedImages[index].getfile!, fit: BoxFit.cover),
            );
          }),
    );
  }

  Future choiceImage() async {
    try {
      var pickedImage = await picker.pickMultiImage(
          imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
      setState(() {
        if (pickedImage == null) return;
        for (var i = 0; i < pickedImage.length; i++) {
          var files = Files("denuncias");
          files.setfile = File(pickedImage[i].path);
          selectedImages.add(files);
        }
        //files.setfile = File(pickedImage.path);
      });
    } on Exception {
      print("Error");
    }
  }

  //METODOS
  choceImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          compressFormat: ImageCompressFormat.jpg,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Recortar imagen',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
            ),
          ],
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio16x9,
            CropAspectRatioPreset.ratio5x4,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.square,
          ],
          maxWidth: 1024,
          maxHeight: 800);
      // final String fileName = pickedFile.path.split('/').last;
      // final urlImage = await reclamoService.uploadDenunciaStorage(
      //     File(pickedFile.path), fileName);
      // urlFotos.add(urlImage);
      // final Uint8List bytes = data.buffer.asUint8List();
      final Uint8List bytes = await croppedFile!.readAsBytes();
      final ui.Codec codec = await ui.instantiateImageCodec(bytes);
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      if (frameInfo.image.width == 1024 && frameInfo.image.width == 800) {
        // print('La imagen debe ser de 1024x800');
        Widgets.alertSnackbar(
            context as BuildContext, "La imagen debe ser de 1024x800");
      } else {
        setState(() {
          _images.add(File(croppedFile.path));
        });
      }
    }
  }

  Future choiceImageCamera() async {
    try {
      var pickedImage = await picker.pickImage(source: ImageSource.camera);
      setState(() {
        if(pickedImage == null) return;
        var files = Files("denuncias");
            files.setfile = File(pickedImage.path);
            selectedImages.add(files);
        });
    } on Exception {
      print("Error");
    }
  }

}
