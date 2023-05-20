import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  void initState() {
    Services.getHttp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: InkWell(
                onTap: () {
                  setState(()  {
                     // Services.getHttp();
                  });
                },
                child: const Icon(Icons.refresh)),
          )
        ],
        backgroundColor: const Color.fromRGBO(37, 45, 52, 1),
        elevation: 0,
        title: Text('Visitors: ${Services.requestModelList.length}'),
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(height: 15);
          },
          physics: const BouncingScrollPhysics(),
          itemCount: Services.requestModelList.length,
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
                      Services.requestModelList[index].key.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const Divider(),
                    Text(Services.requestModelList[index].number.toString(),
                        style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class Services {
  static List<RequestModel> requestModelList = [];

  static httpPostAndGet() async {
    // var d = RequestModel().toJson(i);
    // }
    // List<>

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

  static httpPostAndPut() async {
    // var d = RequestModel().toJson(i);
    // }
    // List<>

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

  static getHttp() async {
    final response = await http.get(
      Uri.parse('https://json.extendsclass.com/bin/11037c1ef2f0'),
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
  }
}

class RequestModel {
  String? key;
  String? number;

  RequestModel({this.key, this.number});

  factory RequestModel.fromJson(Map<String, dynamic> data) {
    return RequestModel(
      key: data['key'],
      number: data['number'],
    );
  }

  Map<String, dynamic> toJson(RequestModel requestModel) {
    return {
      'key': requestModel.key,
      'number': requestModel.number,
    };
  }
}
