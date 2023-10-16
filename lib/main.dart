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
                          controller.fileId.value = "5950f706448f";
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
                backgroundColor: const Color.fromRGBO(37, 45, 52, 1),
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
                  // reverse: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(37, 45, 52, 1),
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

