import 'dish.dart';
import 'restaurant_model.dart';

class OnboardingPageData {
  OnboardingPageData({required this.imageUrl, required this.title});

  final String imageUrl;
  final String title;
}

final List<OnboardingPageData> onboardingPages = [
  OnboardingPageData(
    imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=800&q=80',
    title: 'Discover local restaurants and dishes easily.',
  ),
  OnboardingPageData(
    imageUrl: 'https://images.unsplash.com/photo-1582468734752-7d2dfbb3626b?auto=format&fit=crop&w=800&q=80',
    title: 'Fast, reliable, and friendly delivery to your door.',
  ),
];

final List<String> categories = [
  'Fast Food',
  'Drinks',
  'Traditional Food',
  'Desserts',
];

final List<RestaurantData> restaurants = [
  RestaurantData(
    id: 'ethiopian_flavors',
    name: 'Ethiopian Flavors',
    heroImage: 'https://images.unsplash.com/photo-1604908177225-6c5b3c0c3a5b?auto=format&fit=crop&w=1200&q=80',
    rating: 4.9,
    eta: '20-30 min',
    deliveryFee: 'Free',
    categories: ['Traditional Food'],
    isFeatured: true,
    isFreeDelivery: true,
  ),
  RestaurantData(
    id: 'italian_bistro',
    name: 'Italian Bistro',
    heroImage: 'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?auto=format&fit=crop&w=1200&q=80',
    rating: 4.6,
    eta: '30-45 min',
    deliveryFee: '\$3.00',
    categories: ['Pasta', 'Pizza'],
    isFeatured: true,
  ),
];

final Map<String, List<Dish>> restaurantMenus = {
  'ethiopian_flavors': [
    Dish(
      id: 'spicy_beef_stirfry',
      name: 'Spicy Beef Stir-fry',
      description: 'Tender beef slices wok-fried with crisp bell peppers, onions, and spicy chili sauce.',
      price: 15.99,
      imageUrl: 'https://images.unsplash.com/photo-1512058564366-18510be2db19?auto=format&fit=crop&w=900&q=80',
    ),
    Dish(
      id: 'vegan_lentil_soup',
      name: 'Vegan Lentil Soup',
      description: 'A rich and creamy lentil soup with carrots, celery, and aromatic spices.',
      price: 9.50,
      imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=900&q=80',
    ),
  ],
};
