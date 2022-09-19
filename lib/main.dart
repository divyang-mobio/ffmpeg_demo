import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo Home Page')),
      body: Center(
        child: MaterialButton(
            onPressed: () {
              ffmpegTest();
            },
            child: const Text("FFMPEG")),
      ),
    );
  }
}

ffmpegTest() async {
  String audio = '/storage/emulated/0/Download/audio.mp3';
  String video = '/storage/emulated/0/Download/video.mp4';
  String image = '/storage/emulated/0/Download/image.jpg';
  // String output = '/storage/emulated/0/Download/output.mp4';

  await Permission.storage.request();
  var status = await Permission.storage.status;
  if (status.isGranted) {
    String command = '-i $audio -vf fps=30 $image -hide_banner';

    FFmpegKit.executeAsync(command).then((session) async {
      final returnCode = await session.getReturnCode();
      print(returnCode);
    });
  }
}
