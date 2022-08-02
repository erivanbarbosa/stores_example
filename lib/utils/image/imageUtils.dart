import 'dart:convert';

import 'package:image_picker/image_picker.dart';

pickImage() async {
  final picker = ImagePicker();
  final PickedFile? pickedFile = await picker.getImage(source: ImageSource.gallery);
  final bytes = await pickedFile!.readAsBytes();
  String base64 = base64Encode(bytes);
  return base64;
}
