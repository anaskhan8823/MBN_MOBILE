class CountryModel {
  int? id;
  String? name;
  String? countryCode;

  CountryModel({this.id, this.name, this.countryCode});

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryCode = json['dial_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['dial_code'] = countryCode;
    return data;
  }
}
