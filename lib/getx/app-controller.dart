import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/request-model.dart';

class AppController extends GetxController {
  RxString fileId = "5950f706448f".obs;
  RxBool isLoading = false.obs;
  RxList<RequestModel> requestModelList = <RequestModel>[].obs;

  @override
  onInit() {
    super.onInit();
    getHttp();
  }

  httpPostAndGet() async {
    final response = await http.post(
      Uri.parse('https://json.extendsclass.com/bin'),

      ///https://json.extendsclass.com/bin/b16614671e0f
      headers: {
        'Api-key': '7d0e1b49-f49a-11ed-8cf9-0242ac110002',
        'Security-key': 'ahmadalfrehanahmadalfrehan',
        'Private': 'true',
      },

      body: json.encode({
        'data': [for (var i in requestModelList) RequestModel().toJson(i)]
      }),
    );
    log(response.toString());
    log(response.body.toString());
    log(response.statusCode.toString());
  }

  httpPostAndPut() async {
    final response = await http.put(
      Uri.parse('https://json.extendsclass.com/bin/11037c1ef2f0'),

      ///https://json.extendsclass.com/bin/b16614671e0f
      headers: {
        'Api-key': '7d0e1b49-f49a-11ed-8cf9-0242ac110002',
        'Security-key': 'ahmadalfrehanahmadalfrehan',
        'Private': 'true',
      },

      body: json.encode({
        'data': [for (var i in requestModelList) RequestModel().toJson(i)]
      }),
    );
    log(response.toString());
    log(response.body.toString());
    log(response.statusCode.toString());
  }

  getHttp() async {
    isLoading.value = true;
    final response = await http.get(
      Uri.parse('https://json.extendsclass.com/bin/$fileId'),
      headers: {
        'Api-key': '7d0e1b49-f49a-11ed-8cf9-0242ac110002',
        'Security-key': 'ahmadalfrehanahmadalfrehan',
        'Private': 'true',
      },
    );
    log(response.toString());
    log(response.body.toString());
    log(response.statusCode.toString());
    var l = json.decode(response.body);
    for (var i in l['data']) {
      requestModelList.add(RequestModel.fromJson(i));
    }
    isLoading.value = false;
  }
}
