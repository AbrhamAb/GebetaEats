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

// Category model used to render category tiles. `imageUrl` is optional;
// UI will show a fallback icon when the network image fails.
class Category {
  const Category({required this.label, this.imageUrl});
  final String label;
  final String? imageUrl;
}

// Main categories shown on the home screen.
final List<Category> mainCategories = [
  const Category(
    label: 'Fast Food',
    imageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=600&q=80',
  ),
  const Category(
    label: 'Drinks',
    imageUrl: 'https://images.unsplash.com/photo-1542444459-db2b9b1b4fdb?auto=format&fit=crop&w=600&q=80',
  ),
  const Category(
    label: 'Traditional Food',
    imageUrl: 'https://images.unsplash.com/photo-1603073000190-3b3a1c6f0c9a?auto=format&fit=crop&w=600&q=80',
  ),
  const Category(
    label: 'Desserts',
    imageUrl: 'https://images.unsplash.com/photo-1542827638-2c3b1b5a0f8f?auto=format&fit=crop&w=600&q=80',
  ),
];

// Subcategories for Fast Food specifically.
final List<Category> fastFoodSubcategories = [
  const Category(
    label: 'Burgers',
    imageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=400&q=80',
  ),
  const Category(
    label: 'Pizza',
    imageUrl: 'https://images.unsplash.com/photo-1548365328-9f7f0d8f6d3b?auto=format&fit=crop&w=400&q=80',
  ),
  const Category(
    label: 'Fried Chicken',
    imageUrl: 'https://images.unsplash.com/photo-1604908177225-6c5b3c0c3a5b?auto=format&fit=crop&w=400&q=80',
  ),
  const Category(
    label: 'Sandwiches',
    imageUrl: 'https://images.unsplash.com/photo-1555993539-1732f6c9a5b5?auto=format&fit=crop&w=400&q=80',
  ),
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
