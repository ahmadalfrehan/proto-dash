import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proto_dashbord/getx/app-binding.dart';
import 'package:proto_dashbord/getx/app-controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBinding(),
      debugShowCheckedModeBanner: false,
      home: const MyHome(),
    );
  }
}

class MyHome extends GetView<AppController> {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {

    return Obx(
      () => controller.isLoading.value
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : Scaffold(
              appBar: AppBar(
                leading: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: InkWell(
                      onTap: () {
                        if (controller.fileId.value == "11037c1ef2f0") {
                          controller.fileId.value = "b74989954456";
                          controller.requestModelList.clear();
                          controller.getHttp();
                        } else {
                          controller.fileId.value = "11037c1ef2f0";
                          controller.requestModelList.clear();
                          controller.getHttp();
                        }
                      },
                      child: const Icon(Icons.swipe_vertical_rounded)),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: InkWell(
                        onTap: () {
                          controller.requestModelList.value = controller
                              .requestModelList.value.reversed
                              .toList();
                        },
                        child: const Icon(Icons.refresh)),
                  )
                ],
                backgroundColor: const Color.fromRGBO(2, 32, 40, 1),
                elevation: 0,
                title: Text(
                    'Visitors: ${controller.requestModelList.value.length}'),
              ),
              body: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 15);
                  },
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.requestModelList.value.length,
                  itemBuilder: (context, index) {
                    String? imageUrl = "";
                    RegExp exp = RegExp(
                        r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
                    Iterable<RegExpMatch> matches = exp.allMatches(controller
                        .requestModelList.value[index].number
                        .toString());
                    matches.forEach((match) {
                      if (controller.requestModelList.value[index].number!
                          .substring(match.start, match.end)
                          .contains('https')) {
                        imageUrl = controller
                            .requestModelList.value[index].number
                            ?.substring(match.start, match.end);
                      }
                      print(controller.requestModelList.value[index].number
                          ?.substring(match.start, match.end));
                    });
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(2, 32, 40, 1),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.21),
                                spreadRadius: 0,
                                blurRadius: 16,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.black12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: Get.width,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.greenAccent,
                                      border: Border.all(color: Colors.white),
                                      image: DecorationImage(
                                      fit: BoxFit.fill,
                                        image: NetworkImage(imageUrl ?? ""),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              controller.requestModelList.value[index].key
                                  .toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            const Divider(),
                            Text(
                                controller.requestModelList.value[index].number
                                    .toString(),
                                style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
    );
  }
}

