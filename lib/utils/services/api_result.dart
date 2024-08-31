class APIResult<T> {
  String status;
  T recordList;

  APIResult({
    required this.status,
    required this.recordList,
  });

  factory APIResult.fromJson(Map<String, dynamic> json, T _recordList) =>
      new APIResult(
        status: json["status"].toString(),
        recordList: _recordList,
      );
}

class ErrorAPIResult<T> {
  Error? error;
  String? status;
  T? recordList;

  ErrorAPIResult({this.error, this.status, this.recordList});

  ErrorAPIResult.fromJson(Map<String, dynamic> json, recordList2) {
    error = json['error'] != null ? Error.fromJson(json['error']) : null;
    status = json['status'].toString();
    recordList = recordList2;
  }
}

class Error {
  String? apiName;
  String? apiType;
  String? fileName;
  dynamic functionName;
  dynamic lineNumber;
  dynamic typeName;
  String? stack;
  List<String>? contactNo;

  Error(
      {this.apiName,
      this.apiType,
      this.fileName,
      this.functionName,
      this.lineNumber,
      this.typeName,
      this.stack,
      this.contactNo});

  factory Error.fromJson(Map<String, dynamic> json) => Error(
      apiName: json["apiName"],
      apiType: json["apiType"],
      fileName: json["fileName"],
      functionName: json["functionName"],
      lineNumber: json["lineNumber"],
      typeName: json["typeName"],
      stack: json["stack"],
      contactNo: json['contactNo'].cast<String>());
}
