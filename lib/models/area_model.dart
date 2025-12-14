class NeighborhoodsModel {
  final List<Neighborhood> data;

  NeighborhoodsModel({required this.data});

  factory NeighborhoodsModel.fromJson(Map<String, dynamic> json) {
    return NeighborhoodsModel(
      data: (json['data'] as List? ?? [])
          .map((e) => Neighborhood.fromJson(e))
          .toList(),
    );
  }
}

class Neighborhood {
  final int id;
  final int cityId;
  final String name;
  final String? createdAt;
  final String? updatedAt;

  Neighborhood({
    required this.id,
    required this.cityId,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Neighborhood.fromJson(Map<String, dynamic> json) {
    return Neighborhood(
      id: json['id'],
      cityId: int.parse(json['city_id'].toString()),
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
