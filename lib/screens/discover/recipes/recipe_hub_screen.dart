import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../config/app_theme.dart';
import '../../../config/app_constants.dart';
import '../../../providers/app_state.dart';
import '../../../services/mock_data.dart';

class RecipeHubScreen extends StatefulWidget {
  const RecipeHubScreen({super.key});
  @override
  State<RecipeHubScreen> createState() => _RecipeHubScreenState();
}

class _RecipeHubScreenState extends State<RecipeHubScreen> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    final filtered = _selectedCategory == 'All'
      ? MockData.recipes
      : MockData.recipes.where((r) => r.category == _selectedCategory).toList();

    return Scaffold(
      backgroundColor: AppColors.darkNavy,
      appBar: AppBar(title: Text(lang == 'mk' ? 'Рецепти' : 'Recipes')),
      body: Column(
        children: [
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: AppConstants.recipeCategories.length,
              itemBuilder: (context, i) {
                final cat = AppConstants.recipeCategories[i];
                final selected = cat == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(label: Text(cat), selected: selected,
                    onSelected: (_) => setState(() => _selectedCategory = cat),
                    backgroundColor: AppColors.darkCard, selectedColor: AppColors.gold,
                    labelStyle: TextStyle(color: selected ? AppColors.darkNavy : AppColors.lightGrey, fontSize: 12)),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 0.75),
              itemCount: filtered.length,
              itemBuilder: (context, i) {
                final recipe = filtered[i];
                return GestureDetector(
                  onTap: () => context.push('/discover/recipes/${recipe.recipeId}'),
                  child: Container(
                    decoration: BoxDecoration(color: AppColors.darkCard, borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.network(recipe.imageUrl, height: 120, width: double.infinity, fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(height: 120, color: AppColors.darkSurface, child: const Icon(Icons.restaurant, color: AppColors.grey))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(recipe.getTitle(lang), style: const TextStyle(color: AppColors.white, fontSize: 13, fontWeight: FontWeight.w600), maxLines: 2, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 4),
                              Row(children: [
                                const Icon(Icons.timer, size: 12, color: AppColors.gold),
                                const SizedBox(width: 4),
                                Text('${recipe.prepTime} min', style: const TextStyle(color: AppColors.grey, fontSize: 11)),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(color: AppColors.gold.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
                                  child: Text(recipe.difficulty, style: const TextStyle(color: AppColors.gold, fontSize: 9, fontWeight: FontWeight.w600)),
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
