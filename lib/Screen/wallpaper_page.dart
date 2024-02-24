
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
//
//
// import 'package:quotes_app/Screen/wallpaper_page.dart';
//
// class WallpaperPage extends StatelessWidget {
//   final String quote;
//
//   const WallpaperPage({Key? key, required this.quote}) : super(key: key);
//
//   get FlutterWallpaperManager => null;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Set Wallpaper'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             await _setQuoteAsWallpaper(context, quote);
//           },
//           child: Text('Set as Wallpaper'),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _setQuoteAsWallpaper(BuildContext context, String quote) async {
//     // Convert the quote text to an image
//     final recorder = ui.PictureRecorder();
//     final canvas = Canvas(recorder);
//     final textStyle = TextStyle(fontSize: 24, color: Colors.black);
//     final textSpan = TextSpan(text: quote, style: textStyle);
//     final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
//     textPainter.layout(minWidth: 0, maxWidth: double.infinity);
//     textPainter.paint(canvas, Offset.zero);
//     final picture = recorder.endRecording();
//     final img = await picture.toImage(textPainter.width.toInt(), textPainter.height.toInt());
//     final pngBytes = await img.toByteData(format: ui.ImageByteFormat.png);
//
//     // Save the image locally
//     final directory = (await getTemporaryDirectory()).path;
//     final file = File('$directory/quote_wallpaper.png');
//     await file.writeAsBytes(pngBytes!.buffer.asUint8List());
//
//     // Set the saved image as wallpaper
//     try {
//       final result = await FlutterWallpaperManager.setWallpaperFromFile(
//         file.path,
//         WallpaperManager.HOME_SCREEN,
//         wallpaperType: WallpaperManager.HOME_SCREEN,
//       );
//
//       if (result == WallpaperManager.SUCCESS) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Wallpaper set successfully')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to set wallpaper')),
//         );
//       }
//     } on PlatformException catch (e) {
//       print("Failed to set wallpaper: '${e.message}'.");
//     }
//   }
// }
//
//
