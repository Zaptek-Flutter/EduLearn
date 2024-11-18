import 'package:edulearn/application/widgets/home_header.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SafeArea(child: HomeHeader(),),

        // Posts Tile

      ],) 
    );
  }
}