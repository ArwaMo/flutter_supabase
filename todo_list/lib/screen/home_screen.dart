import 'dart:math';

import 'package:flutter/material.dart';
import 'package:patterns_canvas/patterns_canvas.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/services/supabase_function.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyWidgetState();
}

bool checkSelected = false;
TextEditingController conTitle = TextEditingController();
TextEditingController conSubTitle = TextEditingController();

class _MyWidgetState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 113, 82, 198),
        actions: [
          InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Container(
                        height: 300,
                        color: const Color.fromARGB(165, 145, 170, 191),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //  const Text('Modal BottomSheet'),
                                TextField(
                                  controller: conTitle,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                              color: Colors.black45)),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                              color: Colors.black45)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Colors.black45),
                                      ),
                                      hintText: 'Enter the task title'),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextField(
                                  controller: conSubTitle,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                              color: Colors.black45)),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                              color: Colors.black45)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Colors.black45),
                                      ),
                                      hintText: 'Enter the task subtitle'),
                                ),
                                ElevatedButton(
                                  child: const Text('Add task'),
                                  onPressed: () {
                                    SupabaseFunctions().insertTask(
                                        conTitle.text, conSubTitle.text);
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Icon(Icons.add_box))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.all(30),
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: CustomPaint(
                      painter: ContainerPatternPainter(),
                      child: const SizedBox(
                        width: 600,
                        height: 630,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    bottom: 25,
                    right: 10,
                    child: SizedBox(
                      width: 310,
                      height: 600,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black)),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 80),
                          child: FutureBuilder(
                              future: SupabaseFunctions().getAllTask(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final List<Task> task = snapshot.data!;
                                  return ListView.builder(
                                    itemCount: task.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        leading: Checkbox(
                                          //  tristate: true,
                                          value: checkSelected,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              checkSelected = value!;
                                            });
                                          },
                                        ),
                                        title:
                                            Text(task[index].title.toString()),
                                        subtitle: Text(
                                            task[index].subTitle.toString()),
                                        trailing: InkWell(
                                            onTap: () {
                                              SupabaseFunctions()
                                                  .deleteTask(task[index].id!);
                                              setState(() {});
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              color: Color.fromARGB(
                                                  255, 222, 83, 73),
                                            )),
                                      );
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return const Text('Error');
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                      top: 30,
                      left: 117,
                      child: Text(
                        'TO DO LIST',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  Positioned(
                    top: 500,
                    left: 205,
                    child: Transform.rotate(
                      angle: 20 * pi / 180,
                      child: Image.asset(
                        'assets/images/umbrella.png',
                        width: 150,
                        height: 130,
                      ),
                    ),
                  )
                ])),
          ],
        ),
      ),
    );
  }
}

class ContainerPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const DiagonalStripesLight(
            bgColor: Color.fromARGB(165, 145, 170, 191),
            fgColor: Color(0xfff0b6e6))
        .paintOnWidget(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
