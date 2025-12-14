class OnBoardingItem {
  final int id;
  final String image;

  OnBoardingItem({required this.id, required this.image});

  factory OnBoardingItem.fromJson(Map<String, dynamic> json) {
    return OnBoardingItem(
      id: json['id'],
      image: json['image'],
    );
  }
}
