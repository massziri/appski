import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../config/app_theme.dart';
import '../../../providers/app_state.dart';
import '../../../services/mock_data.dart';

class OrganisationListScreen extends StatelessWidget {
  const OrganisationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    return Scaffold(
      backgroundColor: AppColors.warmBg,
      appBar: AppBar(title: Text(lang == 'mk' ? 'Организации' : 'Organisations')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: MockData.organisations.length,
        itemBuilder: (context, i) {
          final org = MockData.organisations[i];
          return GestureDetector(
            onTap: () => context.push('/discover/organisations/${org.organisationId}'),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(color: AppColors.warmCard, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                    child: Image.network(org.imageUrl, width: 100, height: 100, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(width: 100, height: 100, color: AppColors.warmSurface, child: const Icon(Icons.people, color: AppColors.lightGrey))),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(org.getName(lang), style: const TextStyle(color: AppColors.darkText, fontSize: 14, fontWeight: FontWeight.w600), maxLines: 2),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: AppColors.info.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
                            child: Text(org.type, style: const TextStyle(color: AppColors.info, fontSize: 10, fontWeight: FontWeight.w600)),
                          ),
                          const SizedBox(height: 4),
                          Text('${org.suburb}, ${org.state}', style: const TextStyle(color: AppColors.lightGrey, fontSize: 11)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
