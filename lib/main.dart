import 'package:custom_paintin_background/painters/custom_painter.dart';
import 'package:flutter/material.dart';

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
  int isSelect = 0;
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
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelect = index;
                              });
                              if (index == 0) {
                                controller.animateTo(
                                  controller.position.minScrollExtent,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.fastOutSlowIn,
                                );
                              } else {
                                controller.animateTo(
                                  controller.position.maxScrollExtent,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.fastOutSlowIn,
                                );
                              }
                            },
                            child: Column(
                              children: [
                                Text(
                                  textHeader[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isSelect == index
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Container(
                                  height: 2,
                                  width: 25,
                                  color: isSelect == index
                                      ? Colors.black
                                      : Colors.transparent,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(
                    parent: NeverScrollableScrollPhysics()),
                controller: controller,
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
                    child: const Center(
                      child: Text(
                        'Badge is selected',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: const Color.fromRGBO(88, 190, 230, 1),
                    child: const Center(
                      child: Text(
                        'Stats is selected',
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
