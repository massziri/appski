import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/app_theme.dart';
import '../../../providers/app_state.dart';
import '../../../services/mock_data.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String recipeId;
  const RecipeDetailScreen({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    final recipe = MockData.recipes.firstWhere((r) => r.recipeId == recipeId, orElse: () => MockData.recipes.first);
    return Scaffold(
      backgroundColor: AppColors.darkNavy,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(expandedHeight: 250, pinned: true,
            flexibleSpace: FlexibleSpaceBar(background: Image.network(recipe.imageUrl, fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: AppColors.darkSurface)))),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe.getTitle(lang), style: Theme.of(context).textTheme.displaySmall),
                  const SizedBox(height: 12),
                  Row(children: [
                    _badge(Icons.timer, '${recipe.prepTime} min', AppColors.gold),
                    const SizedBox(width: 12),
                    _badge(Icons.signal_cellular_alt, recipe.difficulty, AppColors.macedonianRed),
                    const SizedBox(width: 12),
                    _badge(Icons.restaurant, recipe.category, AppColors.info),
                  ]),
                  const SizedBox(height: 24),
                  Text(lang == 'mk' ? 'Состојки' : 'Ingredients', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 12),
                  ...recipe.getIngredients(lang).map((ing) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(children: [
                      Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.gold, shape: BoxShape.circle)),
                      const SizedBox(width: 12),
                      Text(ing, style: const TextStyle(color: AppColors.lightGrey, fontSize: 14)),
                    ]),
                  )),
                  const SizedBox(height: 24),
                  Text(lang == 'mk' ? 'Упатства' : 'Instructions', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 12),
                  ...recipe.getInstructions(lang).asMap().entries.map((entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 28, height: 28,
                          decoration: BoxDecoration(color: AppColors.macedonianRed.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                          child: Center(child: Text('${entry.key + 1}', style: const TextStyle(color: AppColors.macedonianRed, fontWeight: FontWeight.bold, fontSize: 13))),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(entry.value, style: const TextStyle(color: AppColors.lightGrey, fontSize: 14, height: 1.5))),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _badge(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        Icon(icon, size: 14, color: color), const SizedBox(width: 6),
        Text(text, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
      ]),
    );
  }
}
