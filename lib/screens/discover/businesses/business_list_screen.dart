import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../config/app_theme.dart';
import '../../../config/app_constants.dart';
import '../../../providers/app_state.dart';
import '../../../services/mock_data.dart';
import '../../../widgets/business_card.dart';

class BusinessListScreen extends StatefulWidget {
  const BusinessListScreen({super.key});
  @override
  State<BusinessListScreen> createState() => _BusinessListScreenState();
}

class _BusinessListScreenState extends State<BusinessListScreen> {
  String _selectedCategory = 'All';
  String _selectedState = 'All States';
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    final filtered = MockData.businesses.where((b) {
      final matchCategory = _selectedCategory == 'All' || b.category == _selectedCategory;
      final matchState = _selectedState == 'All States' || b.state == _selectedState;
      final matchSearch = _searchQuery.isEmpty || b.getName(lang).toLowerCase().contains(_searchQuery.toLowerCase());
      return matchCategory && matchState && matchSearch;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.warmBg,
      appBar: AppBar(title: Text(lang == 'mk' ? 'Бизниси' : 'Businesses')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: lang == 'mk' ? 'Пребарај бизниси...' : 'Search businesses...',
                prefixIcon: const Icon(Icons.search, color: AppColors.lightGrey),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: AppConstants.businessCategories.length,
              itemBuilder: (context, i) {
                final cat = AppConstants.businessCategories[i];
                final selected = cat == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(cat),
                    selected: selected,
                    onSelected: (_) => setState(() => _selectedCategory = cat),
                    backgroundColor: AppColors.darkCard,
                    selectedColor: AppColors.macedonianRed,
                    labelStyle: TextStyle(color: selected ? AppColors.white : AppColors.lightGrey, fontSize: 12),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: AppConstants.australianStates.length,
              itemBuilder: (context, i) {
                final st = AppConstants.australianStates[i];
                final selected = st == _selectedState;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(st),
                    selected: selected,
                    onSelected: (_) => setState(() => _selectedState = st),
                    backgroundColor: AppColors.darkCard,
                    selectedColor: AppColors.gold,
                    labelStyle: TextStyle(color: selected ? AppColors.darkNavy : AppColors.lightGrey, fontSize: 12),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: filtered.isEmpty
              ? Center(child: Text(lang == 'mk' ? 'Нема резултати' : 'No results found', style: const TextStyle(color: AppColors.lightGrey)))
              : ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, i) => BusinessCard(
                    business: filtered[i],
                    lang: lang,
                    onTap: () => context.push('/discover/businesses/${filtered[i].businessId}'),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
