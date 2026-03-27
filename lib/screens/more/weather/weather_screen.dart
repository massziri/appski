import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/app_theme.dart';
import '../../../config/app_constants.dart';
import '../../../providers/app_state.dart';
import '../../../services/mock_data.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String _selectedCity = 'Skopje';

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    final weather = MockData.getWeather(_selectedCity.toLowerCase());

    return Scaffold(
      backgroundColor: AppColors.darkNavy,
      appBar: AppBar(title: Text(lang == 'mk' ? 'Временска Прогноза' : 'Weather')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // City selector
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: AppConstants.weatherCities.length,
              itemBuilder: (context, i) {
                final city = AppConstants.weatherCities[i];
                final selected = city == _selectedCity;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(label: Text(city), selected: selected,
                    onSelected: (_) => setState(() => _selectedCity = city),
                    backgroundColor: AppColors.darkCard, selectedColor: AppColors.gold,
                    labelStyle: TextStyle(color: selected ? AppColors.darkNavy : AppColors.lightGrey, fontSize: 12)),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          // Current weather
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.darkCard, AppColors.info.withOpacity(0.1)]),
              borderRadius: BorderRadius.circular(20)),
            child: Column(children: [
              Text(_selectedCity, style: const TextStyle(color: AppColors.lightGrey, fontSize: 14)),
              const SizedBox(height: 8),
              Text(weather.icon, style: const TextStyle(fontSize: 64)),
              const SizedBox(height: 8),
              Text('${weather.currentTemp.round()}°C', style: const TextStyle(color: AppColors.white, fontSize: 48, fontWeight: FontWeight.bold)),
              Text(weather.condition, style: const TextStyle(color: AppColors.lightGrey, fontSize: 16)),
              const SizedBox(height: 8),
              Text(lang == 'mk' ? '⚠️ Ова се примери за тестирање' : '⚠️ This is sample data for testing',
                style: const TextStyle(color: AppColors.grey, fontSize: 10)),
            ]),
          ),
          const SizedBox(height: 20),
          // 5 day forecast
          Text(lang == 'mk' ? '5-Дневна Прогноза' : '5-Day Forecast', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          ...weather.dailyForecast.map((day) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(color: AppColors.darkCard, borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              SizedBox(width: 40, child: Text(day.day, style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w600))),
              Text(day.icon, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 12),
              Expanded(child: Text(day.condition, style: const TextStyle(color: AppColors.lightGrey, fontSize: 13))),
              Text('${day.high.round()}°', style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w600)),
              const SizedBox(width: 8),
              Text('${day.low.round()}°', style: const TextStyle(color: AppColors.grey)),
            ]),
          )),
        ],
      ),
    );
  }
}
