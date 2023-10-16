

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
