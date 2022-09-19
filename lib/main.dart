import 'dart:io';

// import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

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
  String audio = 'assets/Bhool_Bhulaiyaa_2.mp3';
  String image = 'assets/castle.jpg';
  String video = 'assets/file_example.mp4';
  String output = '/storage/emulated/0/Download/output.mp3';

  await Permission.storage.request();
  var status = await Permission.storage.status;
  if (status.isGranted) {
    edit(video);

    //   // String command = '-i $video -vf "drawtext="fontfile=TiktokFont.ttf:text=\'Stack Overflow\':fontcolor=white:fontsize=24:box=1:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)/2:y=(h-text_h)/2"" -codec:a copy $output';
    //
    // // String command ="-i $video -r 1 -f image2 $output";//"-i $audio -ss 00:01:54 -to 00:02:53 -c copy $output"; // '-i $audio -vf fps=30 $image -hide_banner';
    // String command = "\$ ffmpeg -i $video";
    final appDirectory = await getExternalStorageDirectory();
    var cmd = "-i $video -i $audio -c copy ${appDirectory?.path}/output.mp4";
    //

    // await fFmpeg.execute(cmd).then((rc) {
    //   debugPrint("FFmpeg process exited with re: $rc");
    // });

    // // var data = ["-ss", "00:00:00" + ".00", "-t", "2:01:00" + ".00", "-noaccurate_seek", "-i", video, "-codec", "copy", "-avoid_negative_ts", "1", output];
    //   FFmpegKit.execute(cmd).then((session) async {
    //     final returnCode = await session.getReturnCode();
    //     print(returnCode);
    //   });
  }
}

edit(String videoPath) async {
  FlutterFFmpeg fFmpeg = FlutterFFmpeg();
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String outputPath = (appDocDir.absolute.path + '/o.mp4').toString();
  String command = '-i $videoPath -vf curves=vintage -y $outputPath';
  await fFmpeg.execute(command).then((rc) {
    debugPrint("FFmpeg process exited with re: $rc");
  });
  debugPrint(outputPath);
}
