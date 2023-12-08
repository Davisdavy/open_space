import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:on_space/features/location_history/models/location.dart';


class MarkerFuture{




  Future<Uint8List> _getBytesFromUrl(String url, int width, int height) async {
    final response = await http.get(Uri.parse(url));
    final imageBytes = response.bodyBytes;

    final completer = Completer<Uint8List>();

    await ui
        .instantiateImageCodec(imageBytes, targetWidth: width,
        targetHeight: height,)
        .then((codec) => codec.getNextFrame())
        .then((frame) {
      final image = frame.image;
      image.toByteData(format: ui.ImageByteFormat.png).then((byteData) {
        final resizedBytes = byteData!.buffer.asUint8List();
        completer.complete(resizedBytes);
      });
    })
        .catchError((error) {
      completer.completeError('Failed to resize image: $error');
    });

    return completer.future;
  }
}
