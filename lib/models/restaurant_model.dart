class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.heroImage,
    required this.rating,
    required this.eta,
    required this.deliveryFee,
    required this.categories,
    required this.isOpen,
    required this.deliveryTime, // NEW numeric field
    this.location,
    this.isFeatured = false,
    this.isFreeDelivery = false,
  });

  final String id;
  final String name;
  final String heroImage;
  final double rating;
  final String eta; // ex: "20-30 min" (UI-friendly)
  final String deliveryFee; // ex: "Free" or "Br 10"
  final List<String> categories;
  final bool isOpen;
  final int deliveryTime; // NEW numeric value (minutes)
  final String? location;

  /// Optional flags (UI convenience)
  final bool isFeatured;
  final bool isFreeDelivery;

  /// Build Restaurant from Supabase row
  factory Restaurant.fromSupabase(Map<String, dynamic> data) {
    // Parse delivery_time safely
    final rawDeliveryTime = data['delivery_time'];
    int deliveryMinutes;

    if (rawDeliveryTime is int) {
      deliveryMinutes = rawDeliveryTime;
    } else if (rawDeliveryTime is double) {
      deliveryMinutes = rawDeliveryTime.round();
    } else if (rawDeliveryTime is String) {
      deliveryMinutes = int.tryParse(rawDeliveryTime) ?? 20;
    } else {
      deliveryMinutes = 20; // fallback
    }

    // Calculate delivery fee
    final feeValue = (deliveryMinutes / 2).round();
    final feeString = feeValue == 0 ? 'Free' : 'Br $feeValue';

    return Restaurant(
      id: data['id'].toString(),
      name: data['name'] ?? '',
      heroImage:
          data['image_url'] ??
          'https://via.placeholder.com/400x300.png?text=No+Image',
      rating: (data['rating'] is int)
          ? (data['rating'] as int).toDouble()
          : (data['rating'] ?? 4.5).toDouble(),
      eta: '${deliveryMinutes - 5}-${deliveryMinutes + 5} min', // UI-friendly
      deliveryFee: feeString,
      categories: data['category'] != null
          ? [data['category'].toString()]
          : <String>[],
      isOpen: data['is_open'] ?? true,
      deliveryTime: deliveryMinutes, // numeric value for calculations
      location: data['location'],
    );
  }
}
