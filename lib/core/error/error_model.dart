class ErrorModel {
  ErrorModel({this.property, this.errors});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    final List<String> errorList = [];
    if (json['errors'] != null) {
      for (var v in json['errors'] as List) {
        errorList.add(v.toString());
      }
    }
    property = json['property'] as String?;
    errors = errorList;
  }

  String? property;
  List<String>? errors;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['property'] = property;
    data['errors'] = errors;
    return data;
  }

  @override
  String toString() {
    return 'ErrorModel(property: $property, error $errors)';
  }
}
