import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../config/app_theme.dart';
import '../../../providers/app_state.dart';
import '../../../services/mock_data.dart';

class OrganisationDetailScreen extends StatelessWidget {
  final String organisationId;
  const OrganisationDetailScreen({super.key, required this.organisationId});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    final org = MockData.organisations.firstWhere((o) => o.organisationId == organisationId, orElse: () => MockData.organisations.first);
    return Scaffold(
      backgroundColor: AppColors.warmBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(expandedHeight: 250, pinned: true,
            flexibleSpace: FlexibleSpaceBar(background: Image.network(org.imageUrl, fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: AppColors.warmSurface)))),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(org.getName(lang), style: Theme.of(context).textTheme.displaySmall),
                  const SizedBox(height: 8),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: AppColors.info.withOpacity(0.2), borderRadius: BorderRadius.circular(6)),
                    child: Text(org.type, style: const TextStyle(color: AppColors.info, fontSize: 12, fontWeight: FontWeight.w600))),
                  if (org.founded.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text('${lang == 'mk' ? 'Основано' : 'Founded'}: ${org.founded}', style: const TextStyle(color: AppColors.gold, fontSize: 13)),
                  ],
                  const SizedBox(height: 16),
                  Text(org.getDescription(lang), style: const TextStyle(color: AppColors.bodyText, fontSize: 14, height: 1.6)),
                  const SizedBox(height: 20),
                  if (org.president.isNotEmpty) _detailRow(Icons.person, '${lang == 'mk' ? 'Претседател' : 'President'}: ${org.president}'),
                  if (org.secretary.isNotEmpty) _detailRow(Icons.person_outline, '${lang == 'mk' ? 'Секретар' : 'Secretary'}: ${org.secretary}'),
                  _detailRow(Icons.location_on, '${org.address}, ${org.suburb} ${org.state}'),
                  _detailRow(Icons.phone, org.phone),
                  _detailRow(Icons.email, org.email),
                  if (org.membershipInfo.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text(lang == 'mk' ? 'Членство' : 'Membership', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity, padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: AppColors.warmCard, borderRadius: BorderRadius.circular(12)),
                      child: Text(org.membershipInfo, style: const TextStyle(color: AppColors.bodyText, fontSize: 13)),
                    ),
                  ],
                  const SizedBox(height: 24),
                  SizedBox(width: double.infinity, child: ElevatedButton.icon(
                    onPressed: () async { try { await launchUrl(Uri.parse('tel:${org.phone}')); } catch (_) {} },
                    icon: const Icon(Icons.phone), label: Text(lang == 'mk' ? 'Контактирајте' : 'Contact'),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(IconData icon, String text) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(children: [
        Icon(icon, size: 18, color: AppColors.gold), const SizedBox(width: 12),
        Expanded(child: Text(text, style: const TextStyle(color: AppColors.bodyText, fontSize: 13))),
      ]));
  }
}
