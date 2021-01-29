import 'dart:async';
import 'dart:html' as html;

class WebImagePicker {
  Future<Map<String, dynamic>> pickImage() async {
    final Map<String, dynamic> data = {};
    final html.FileUploadInputElement input = html.FileUploadInputElement();
    html.document.body.children.add(input);
    input..accept = 'image/*';
    input.click();
    await input.onChange.first;
    if (input.files.isEmpty) return null;
    final reader = html.FileReader();
    reader.readAsDataUrl(input.files[0]);
    await reader.onLoad.first;
    final encoded = reader.result as String;
    final stripped =
      encoded.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
    final imageName = input.files?.first?.name;
    final imagePath = input.files?.first?.relativePath;
    data.addAll({
      'name': imageName,
      'data': stripped,
      'data_scheme': encoded,
      'path': imagePath
    });
    return data;
  }
}
