import 'package:flutter/material.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  final TextEditingController _amountController = TextEditingController(text: '1');
  String _fromCurrency = 'AUD';
  String _toCurrency = 'MKD';

  static const Map<String, double> _rates = {
    'AUD': 1.0,
    'MKD': 37.5,
    'EUR': 0.60,
    'USD': 0.65,
  };

  String get _result {
    final amount = double.tryParse(_amountController.text) ?? 0;
    final fromRate = _rates[_fromCurrency] ?? 1;
    final toRate = _rates[_toCurrency] ?? 1;
    final converted = amount * toRate / fromRate;
    return converted.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF8B7B6B), Color(0xFFA08070), Color(0xFFB08878), Color(0xFF9E6B5E)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(children: [
                  IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.white), onPressed: () => Navigator.of(context).pop()),
                  const Text('☀', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                  const Text('Currency Converter', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ]),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.currency_exchange, color: Colors.white, size: 60),
                      const SizedBox(height: 24),
                      TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white, fontSize: 24),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                          hintText: 'Amount',
                          hintStyle: const TextStyle(color: Colors.white54),
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(child: _currencyDropdown(_fromCurrency, (v) => setState(() => _fromCurrency = v!))),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: IconButton(
                              icon: const Icon(Icons.swap_horiz, color: Colors.white, size: 32),
                              onPressed: () => setState(() {
                                final temp = _fromCurrency;
                                _fromCurrency = _toCurrency;
                                _toCurrency = temp;
                              }),
                            ),
                          ),
                          Expanded(child: _currencyDropdown(_toCurrency, (v) => setState(() => _toCurrency = v!))),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        '$_result $_toCurrency',
                        style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _currencyDropdown(String value, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<String>(
        value: value,
        dropdownColor: const Color(0xFF8B7B6B),
        style: const TextStyle(color: Colors.white, fontSize: 18),
        underline: const SizedBox(),
        isExpanded: true,
        items: _rates.keys.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
