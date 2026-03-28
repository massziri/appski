import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/app_theme.dart';
import '../../../providers/app_state.dart';

class NameDayLookupScreen extends StatefulWidget {
  const NameDayLookupScreen({super.key});
  @override
  State<NameDayLookupScreen> createState() => _NameDayLookupScreenState();
}

class _NameDayLookupScreenState extends State<NameDayLookupScreen> {
  final _controller = TextEditingController();
  String _result = '';

  final Map<String, String> _nameDays = {
    'Stefan': 'December 27 / January 9 - St. Stephen',
    'Стефан': '27 Декември / 9 Јануари - Св. Стефан',
    'Maria': 'August 15 / August 28 - Dormition of the Theotokos',
    'Марија': '15 Август / 28 Август - Успение на Богородица',
    'Nikola': 'December 6 / December 19 - St. Nicholas',
    'Никола': '6 Декември / 19 Декември - Св. Никола',
    'Petko': 'October 14 / October 27 - St. Petka',
    'Петко': '14 Октомври / 27 Октомври - Св. Петка',
    'Ilija': 'July 20 / August 2 - St. Elijah (Ilinden)',
    'Илија': '20 Јули / 2 Август - Св. Илија (Илинден)',
    'Dimitar': 'October 26 / November 8 - St. Demetrius',
    'Димитар': '26 Октомври / 8 Ноември - Св. Димитриј',
    'Georgi': 'April 23 / May 6 - St. George',
    'Ѓорѓи': '23 Април / 6 Мај - Св. Ѓорѓи',
  };

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    return Scaffold(
      backgroundColor: AppColors.warmBg,
      appBar: AppBar(title: Text(lang == 'mk' ? 'Пребарај Именден' : 'Name Day Lookup')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: lang == 'mk' ? 'Внесете име...' : 'Enter a name...',
                prefixIcon: const Icon(Icons.person_search, color: AppColors.gold),
                suffixIcon: IconButton(icon: const Icon(Icons.search, color: AppColors.gold),
                  onPressed: _search),
              ),
              onSubmitted: (_) => _search(),
            ),
            const SizedBox(height: 24),
            if (_result.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.warmCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.gold.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    const Text('🎉', style: TextStyle(fontSize: 32)),
                    const SizedBox(height: 12),
                    Text(_result, style: const TextStyle(color: AppColors.darkText, fontSize: 14), textAlign: TextAlign.center),
                  ],
                ),
              ),
            if (_result.isEmpty && _controller.text.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: AppColors.warmCard, borderRadius: BorderRadius.circular(16)),
                child: Text(
                  lang == 'mk' ? 'Нема резултати. Пробајте друго име.' : 'No results. Try another name.',
                  style: const TextStyle(color: AppColors.lightGrey), textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 30),
            Text(lang == 'mk' ? 'Примери: Stefan, Maria, Nikola, Ilija' : 'Examples: Stefan, Maria, Nikola, Ilija',
              style: const TextStyle(color: AppColors.lightGrey, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  void _search() {
    final name = _controller.text.trim();
    setState(() {
      _result = _nameDays[name] ?? '';
      for (final entry in _nameDays.entries) {
        if (entry.key.toLowerCase() == name.toLowerCase()) {
          _result = entry.value;
          break;
        }
      }
    });
  }
}
