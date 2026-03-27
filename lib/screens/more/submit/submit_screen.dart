import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/app_theme.dart';
import '../../../providers/app_state.dart';

class SubmitScreen extends StatefulWidget {
  const SubmitScreen({super.key});
  @override
  State<SubmitScreen> createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {
  String _type = 'business';
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    return Scaffold(
      backgroundColor: AppColors.darkNavy,
      appBar: AppBar(title: Text(lang == 'mk' ? 'Поднеси Листинг' : 'Submit a Listing')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(lang == 'mk' ? 'Тип на листинг' : 'Listing Type', style: const TextStyle(color: AppColors.lightGrey, fontSize: 13)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(color: AppColors.darkCard, borderRadius: BorderRadius.circular(12)),
            child: DropdownButton<String>(
              value: _type, isExpanded: true,
              dropdownColor: AppColors.darkCard,
              style: const TextStyle(color: AppColors.white),
              underline: const SizedBox(),
              items: [
                DropdownMenuItem(value: 'business', child: Text(lang == 'mk' ? 'Бизнис' : 'Business')),
                DropdownMenuItem(value: 'organisation', child: Text(lang == 'mk' ? 'Организација' : 'Organisation')),
                DropdownMenuItem(value: 'event', child: Text(lang == 'mk' ? 'Настан' : 'Event')),
                DropdownMenuItem(value: 'general', child: Text(lang == 'mk' ? 'Општо' : 'General')),
              ],
              onChanged: (v) => setState(() => _type = v!),
            ),
          ),
          const SizedBox(height: 16),
          _field(lang == 'mk' ? 'Ваше Име' : 'Your Name', _nameController),
          _field(lang == 'mk' ? 'Е-пошта' : 'Email', _emailController),
          _field(lang == 'mk' ? 'Телефон' : 'Phone', _phoneController),
          _field(lang == 'mk' ? 'Детали' : 'Details', _detailsController, maxLines: 5),
          const SizedBox(height: 24),
          SizedBox(width: double.infinity, child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(lang == 'mk' ? 'Поднесокот е испратен! Ќе биде прегледан.' : 'Submission sent! It will be reviewed.'),
                backgroundColor: AppColors.success,
              ));
            },
            child: Text(lang == 'mk' ? 'Поднеси' : 'Submit'),
          )),
        ],
      ),
    );
  }

  Widget _field(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(controller: controller, maxLines: maxLines,
        decoration: InputDecoration(labelText: label)),
    );
  }
}
