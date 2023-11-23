import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
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
  final List _images = [];

  String _selectCategoria = "0";

  TextEditingController? _descripcionController;

  TextEditingController? _tituloController;

  final _formKey = GlobalKey<FormState>();

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Registrar Alerta Temprana'),
        ),
        elevation: 10,
      ),
      body: Container(
        padding: EdgeInsetsDirectional.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    choceImageGallery();
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
                          ],
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    //Navigator.pop(context);
                    choceImageCamare();
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
                            const Text('Camera'),
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
            TextFormField(),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Cancel');
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
    );
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

  choceImageCamare() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      // final String fileName = pickedFile.path.split('/').last;
      // final urlImage = await reclamoService.uploadDenunciaStorage(
      //     File(pickedFile.path), fileName);
      // urlFotos.add(urlImage);
      // setState(() {
      //   _imagesPath.add(pickedFile.path);
      //   _images.add(File(pickedFile.path));
      // });
    }
  }
}
