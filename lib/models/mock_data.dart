class Dish {
  Dish({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
}

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

class OnboardingPageData {
  OnboardingPageData({required this.imageUrl, required this.title});

  final String imageUrl;
  final String title;
}

final List<OnboardingPageData> onboardingPages = <OnboardingPageData>[
  OnboardingPageData(
    imageUrl:
        'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=800&q=80',
    title: 'Discover local restaurants and dishes easily.',
  ),
  OnboardingPageData(
    imageUrl:
        'https://images.unsplash.com/photo-1582468734752-7d2dfbb3626b?auto=format&fit=crop&w=800&q=80',
    title: 'Fast, reliable, and friendly delivery to your door.',
  ),
];

final List<String> categories = <String>[
  'Fast Food',
  'Drinks',
  'Traditional Food',
  'Desserts',
];

final List<RestaurantData> restaurants = <RestaurantData>[
  RestaurantData(
    id: 'ethiopian_flavors',
    name: 'Ethiopian Flavors',
    heroImage:
        'https://images.unsplash.com/photo-1604908177225-6c5b3c0c3a5b?auto=format&fit=crop&w=1200&q=80',
    rating: 4.9,
    eta: '20-30 min',
    deliveryFee: 'Free',
    categories: <String>['Traditional Food'],
    isFeatured: true,
    isFreeDelivery: true,
  ),
  RestaurantData(
    id: 'italian_bistro',
    name: 'Italian Bistro',
    heroImage:
        'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?auto=format&fit=crop&w=1200&q=80',
    rating: 4.6,
    eta: '30-45 min',
    deliveryFee: '\$3.00',
    categories: <String>['Pasta', 'Pizza'],
    isFeatured: true,
  ),
  RestaurantData(
    id: 'healthy_greens',
    name: 'Healthy Greens',
    heroImage:
        'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?auto=format&fit=crop&w=1200&q=80',
    rating: 4.7,
    eta: '15-25 min',
    deliveryFee: 'Free',
    categories: <String>['Salads'],
    isFreeDelivery: true,
    isOpen: false,
  ),
  RestaurantData(
    id: 'seafood_sensation',
    name: 'Seafood Sensation',
    heroImage:
        'https://images.unsplash.com/photo-1498654896293-37aacf113fd9?auto=format&fit=crop&w=1200&q=80',
    rating: 4.3,
    eta: '45-60 min',
    deliveryFee: '\$4.50',
    categories: <String>['Seafood'],
  ),
];

final Map<String, List<Dish>> restaurantMenus = <String, List<Dish>>{
  'ethiopian_flavors': <Dish>[
    Dish(
      id: 'spicy_beef_stirfry',
      name: 'Spicy Beef Stir-fry',
      description:
          'Tender beef slices wok-fried with crisp bell peppers, onions, and spicy chili sauce.',
      price: 15.99,
      imageUrl:
          'https://images.unsplash.com/photo-1512058564366-18510be2db19?auto=format&fit=crop&w=900&q=80',
    ),
    Dish(
      id: 'vegan_lentil_soup',
      name: 'Vegan Lentil Soup',
      description:
          'A rich and creamy lentil soup with carrots, celery, and aromatic spices.',
      price: 9.50,
      imageUrl:
          'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=900&q=80',
    ),
    Dish(
      id: 'chicken_caesar_salad',
      name: 'Chicken Caesar Salad',
      description:
          'Fresh romaine lettuce, grilled chicken, croutons, and Parmesan with Caesar dressing.',
      price: 12.75,
      imageUrl:
          'https://images.unsplash.com/photo-1481391032119-d89fee407e44?auto=format&fit=crop&w=900&q=80',
    ),
    Dish(
      id: 'classic_margherita_pizza',
      name: 'Classic Margherita Pizza',
      description:
          'Traditional Neapolitan pizza with fresh mozzarella, basil, and ripe tomato sauce.',
      price: 14.00,
      imageUrl:
          'https://images.unsplash.com/photo-1548366086-7e45b3f6b90c?auto=format&fit=crop&w=900&q=80',
    ),
    Dish(
      id: 'thai_tom_yum',
      name: 'Thai Tom Yum Goong',
      description:
          'Spicy and sour Thai soup with shrimp, lemongrass, galangal, and kaffir lime leaves.',
      price: 16.50,
      imageUrl:
          'https://images.unsplash.com/photo-1612874472278-5c1b4b4da614?auto=format&fit=crop&w=900&q=80',
    ),
  ],
};
