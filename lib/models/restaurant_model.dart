class RestaurantData {
  RestaurantData({
    required this.id,
    required this.name,
    required this.heroImage,
    required this.rating,
    required this.eta,
    required this.deliveryFee,
    required this.categories,
    this.isFeatured = false,
    this.isFreeDelivery = false,
    this.isOpen = true,
  });

  final String id;
  final String name;
  final String heroImage;
  final double rating;
  final String eta;
  final String deliveryFee;
  final List<String> categories;
  final bool isFeatured;
  final bool isFreeDelivery;
  final bool isOpen;
}
