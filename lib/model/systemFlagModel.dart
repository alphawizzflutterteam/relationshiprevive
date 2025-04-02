class SystemFlag {
  SystemFlag(
      {this.id,
      required this.name,
      required this.value,this.displayName});
  int? id;
  String name;
  String value;
  String? displayName;

  factory SystemFlag.fromJson(Map<String, dynamic> json) => SystemFlag(
        id: json["id"],
        name: json["name"] ?? "",
        value: (json["value"]) ?? "",
    displayName: ((json["displayName"]) ?? "")
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "value": value,
        "displayName": displayName,
      };
}
