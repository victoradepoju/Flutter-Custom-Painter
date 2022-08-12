// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

import 'home/custom_painter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final VoidCallback? onTapped;
  const MyApp({
    Key? key,
    this.onTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List textHeader = ['Badge', 'Stats'];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              child: AspectRatio(
                aspectRatio: 1.0,
                child: BackgroundCustomPaint(
                  frontPaintColor: Colors.black,
                  backPaintColor: Color.fromRGBO(88, 190, 230, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: SizedBox(
                  height: 50,
                  child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: ((context, index) =>
                          const SizedBox(width: 150)),
                      scrollDirection: Axis.horizontal,
                      itemCount: textHeader.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Text(textHeader[index]),
                        );
                      }),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          child: const Text(
                            'Badge',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          onPressed: () => controller.animateTo(
                            controller.position.minScrollExtent,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn,
                          ),
                        ),
                        Container(
                          height: 2,
                          width: 10,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        TextButton(
                          child: const Text(
                            'Stats',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          onPressed: () => controller.animateTo(
                              controller.position.maxScrollExtent,
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastOutSlowIn),
                        ),
                        Container(
                          height: 2,
                          width: 10,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 100,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(
                    parent: NeverScrollableScrollPhysics()),
                controller: controller,
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.red,
                    child: const Center(
                      child: Text(
                        '1. This is the first list item',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue,
                    child: const Center(
                      child: Text(
                        '2. This is the second list item',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}