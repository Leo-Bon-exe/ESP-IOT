import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sdp_1/main_page_socket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
       return  const MaterialApp(
          title: 'SDP-1',
          home: MainPageSocket(),
        );
      },
    );
  }
}
