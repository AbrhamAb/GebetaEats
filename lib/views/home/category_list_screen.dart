import 'package:flutter/material.dart';

import '../../models/mock_data.dart';
import '../../theme.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key, required this.categoryLabel});

  final String categoryLabel;

  @override
  Widget build(BuildContext context) {
    final List<Category> items =
        categoryLabel == 'Fast Food' ? fastFoodSubcategories : [];

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryLabel),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: items.isEmpty
          ? Center(
              child: Text(
                'No subcategories for $categoryLabel yet',
                style: const TextStyle(color: AppColors.muted),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final c = items[index];
                  return GestureDetector(
                    onTap: () {
                      // open aggregated dishes for this subcategory
                      Navigator.of(context).pushNamed(
                        '/category/dishes',
                        arguments: c.label,
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 72,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: c.imageUrl != null
                              ? Image.network(
                                  c.imageUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(color: Colors.grey.shade300),
                                )
                              : Container(
                                  color: Colors.grey.shade200,
                                  child: const Icon(Icons.fastfood, color: AppColors.primary, size: 36),
                                ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          c.label,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.text),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
