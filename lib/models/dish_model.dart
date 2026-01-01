// dish_model.dart
class Dish {
  Dish({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.restaurantId,
    this.isFeatured = false,
    this.isVegetarian = false,
  });

  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String restaurantId;

  /// Optional flags for UI convenience
  final bool isFeatured;
  final bool isVegetarian;

  /// Build Dish from Supabase row
  factory Dish.fromSupabase(Map<String, dynamic> data) {
    return Dish(
      id: data['id'].toString(),
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] is int)
          ? (data['price'] as int).toDouble()
          : (data['price'] ?? 0).toDouble(),
      imageUrl:
          data['image_url'] ??
          'https://via.placeholder.com/200x150.png?text=No+Image',
      restaurantId: data['restaurant_id'].toString(),
      isFeatured: data['is_available'] ?? false,
      isVegetarian: false,
    );
  }
}
