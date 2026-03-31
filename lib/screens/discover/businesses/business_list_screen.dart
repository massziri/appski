import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../config/app_theme.dart';

import '../../../providers/app_state.dart';
import '../../../services/mock_data.dart';
import '../../../widgets/business_card.dart';

class BusinessListScreen extends StatefulWidget {
  const BusinessListScreen({super.key});
  @override
  State<BusinessListScreen> createState() => _BusinessListScreenState();
}

class _BusinessListScreenState extends State<BusinessListScreen> {
  String? _selectedCity;

  // Cities matching the original app screenshots (Australian cities)
  static const List<_CityEntry> _cities = [
    _CityEntry(name: 'Sydney', state: 'NSW'),
    _CityEntry(name: 'Melbourne', state: 'VIC'),
    _CityEntry(name: 'Newcastle', state: 'NSW'),
    _CityEntry(name: 'Perth', state: 'WA'),
    _CityEntry(name: 'Adelaide', state: 'SA'),
    _CityEntry(name: 'Brisbane/Gold Coast', state: 'QLD'),
    _CityEntry(name: 'Canberra/Queanbeyan', state: 'ACT'),
    _CityEntry(name: 'Wollongong', state: 'NSW'),
  ];

  int _getBusinessCount(String state) {
    return MockData.businesses.where((b) => b.state == state).length;
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;

    if (_selectedCity != null) {
      return _buildBusinessesForCity(lang);
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
              Color(0xFF1A1A2E),
              Color(0xFF3D1A3A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              Padding(
                padding: const EdgeInsets.all(8),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              // Title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Business Listings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // City list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _cities.length,
                  itemBuilder: (context, index) {
                    final city = _cities[index];
                    final count = _getBusinessCount(city.state);
                    // Staggered alignment like screenshot
                    final leftPadding = (index % 3) * 16.0;

                    return Padding(
                      padding: EdgeInsets.only(left: leftPadding, bottom: 12),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedCity = city.state),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white.withOpacity(0.2)),
                            color: Colors.white.withOpacity(0.05),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                city.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                count == 0
                                    ? 'No businesses yet'
                                    : '$count business${count > 1 ? 'es' : ''}',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBusinessesForCity(String lang) {
    final filtered = MockData.businesses.where((b) => b.state == _selectedCity).toList();
    final cityName = _cities.firstWhere((c) => c.state == _selectedCity, orElse: () => const _CityEntry(name: 'City', state: '')).name;

    return Scaffold(
      backgroundColor: AppColors.warmBg,
      appBar: AppBar(
        title: Text(cityName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => setState(() => _selectedCity = null),
        ),
      ),
      body: filtered.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.store, color: AppColors.lightGrey, size: 64),
                  const SizedBox(height: 16),
                  Text(
                    lang == 'mk' ? 'Нема бизниси' : 'No businesses yet',
                    style: const TextStyle(color: AppColors.lightGrey, fontSize: 16),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, i) => BusinessCard(
                business: filtered[i],
                lang: lang,
                onTap: () => context.push('/discover/businesses/${filtered[i].businessId}'),
              ),
            ),
    );
  }
}

class _CityEntry {
  final String name;
  final String state;
  const _CityEntry({required this.name, required this.state});
}
