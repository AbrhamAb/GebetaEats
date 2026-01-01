import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseClient client = Supabase.instance.client;

  /// -------------------- INIT --------------------
  static Future<void> init() async {
    await Supabase.initialize(
      url: 'https://zpkwotscerynwuvsvqms.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inpwa3dvdHNjZXJ5bnd1dnN2cW1zIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjcwMTc2MDksImV4cCI6MjA4MjU5MzYwOX0.p2B9lQI3cF8XGvnPKvY9r5F0nNgZZCZXsjG2QZ2XE3c',
    );
    print('Supabase initialized!');
  }

  /// -------------------- TEST CONNECTION --------------------
  static Future<void> testConnection() async {
    try {
      final response = await client.from('users').select().maybeSingle();
      print('Supabase test succeeded! Data: $response');
    } catch (error) {
      print('Supabase test failed: $error');
    }
  }

  /// =========================================================
  ///                     AUTH SECTION
  /// =========================================================
  static Future<User?> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final res = await client.auth.signUp(email: email, password: password);

      if (res.user == null) {
        throw AuthException(
          'Registration failed. Please check your email and password.',
        );
      }

      await createUserProfile(id: res.user!.id, name: name, email: email);

      return res.user;
    } on AuthException catch (e) {
      print('SignUp error: ${e.message}');
      rethrow;
    } catch (e) {
      print('SignUp unexpected error: $e');
      throw AuthException(
        'Registration failed. Make sure your password is at least 6 characters, email is valid, and not already registered.',
      );
    }
  }

  static Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final res = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return res.user;
    } catch (e) {
      print("SignIn error: $e");
      return null;
    }
  }

  static Future<void> signOut() async {
    await client.auth.signOut();
  }

  static User? get currentUser => client.auth.currentUser;

  /// =========================================================
  ///                     USERS TABLE
  /// =========================================================
  static Future<void> createUserProfile({
    required String id,
    required String name,
    required String email,
    String? address,
  }) async {
    try {
      await client.from('users').insert({
        'id': id,
        'name': name,
        'email': email,
        'address': address ?? '',
      });
      print('User profile created for $email');
    } catch (e) {
      print('Failed to create user profile: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>?> getCurrentUserProfile() async {
    try {
      if (currentUser == null) return null;

      final res = await client
          .from('users')
          .select()
          .eq('id', currentUser!.id)
          .maybeSingle();

      return res;
    } catch (e) {
      print("Error getting user profile: $e");
      return null;
    }
  }

  static Future<void> updateUserProfile({
    required String name,
    required String email,
    required String address,
  }) async {
    if (currentUser == null) throw AuthException('No user logged in');

    try {
      if (currentUser!.email != email) {
        await client.auth.updateUser(UserAttributes(email: email));
      }

      await client
          .from('users')
          .update({'name': name, 'email': email, 'address': address})
          .eq('id', currentUser!.id);
    } catch (e) {
      print('Error updating user profile: $e');
      rethrow;
    }
  }

  static Future<void> updateUserPassword(String newPassword) async {
    if (currentUser == null) throw AuthException('No user logged in');

    try {
      await client.auth.updateUser(UserAttributes(password: newPassword));
    } catch (e) {
      print('Error updating password: $e');
      rethrow;
    }
  }

  /// =========================================================
  ///                     RESTAURANTS
  /// =========================================================
  static Future<List<Map<String, dynamic>>> getRestaurants() async {
    try {
      final res = await client.from('restaurants').select();

      return List<Map<String, dynamic>>.from(res);
    } catch (e) {
      print("Error fetching restaurants: $e");
      return [];
    }
  }

  /// =========================================================
  ///                     FOOD ITEMS
  /// =========================================================
  static Future<List<Map<String, dynamic>>> getFoodByRestaurant(
    String restaurantId,
  ) async {
    try {
      final res = await client
          .from('food_items')
          .select()
          .eq('restaurant_id', restaurantId);

      return List<Map<String, dynamic>>.from(res);
    } catch (e) {
      print("Error fetching food: $e");
      return [];
    }
  }

  /// =========================================================
  ///                     ORDERS
  /// =========================================================
  /// Place order in Supabase (orders + order_items)
  static Future<String?> placeOrderInSupabase(
    List<Map<String, dynamic>> cartItems,
    double total,
  ) async {
    if (currentUser == null) return null;

    try {
      // 1️⃣ Insert order
      final orderRes = await client.from('orders').insert({
        'user_id': currentUser!.id,
        'total': total,
        'status': 'pending', // default
      }).select();

      if (orderRes is List && orderRes.isNotEmpty) {
        final orderId = (orderRes.first as Map<String, dynamic>)['id'];

        // 2️⃣ Insert order_items
        final itemsToInsert = cartItems.map((item) {
          return {
            'order_id': orderId,
            'food_id': item['food_id'],
            'quantity': item['quantity'],
          };
        }).toList();

        await client.from('order_items').insert(itemsToInsert);

        return orderId.toString();
      }

      return null;
    } catch (e) {
      print("Error placing order in Supabase: $e");
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>> getOrders() async {
    try {
      if (currentUser == null) return [];

      final res = await client
          .from('orders')
          .select()
          .eq('user_id', currentUser!.id)
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(res);
    } catch (e) {
      print("Error fetching orders: $e");
      return [];
    }
  }
}
