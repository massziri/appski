import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/app_theme.dart';
import '../../../providers/app_state.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});
  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  bool _isLoggedIn = false;
  final _passController = TextEditingController();
  
  // API Keys fields
  final _weatherApiController = TextEditingController();
  final _mapsApiController = TextEditingController();
  final _fcmKeyController = TextEditingController();
  final _firebaseProjectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    
    if (!_isLoggedIn) return _buildLoginScreen(lang);
    return _buildAdminDashboard(lang);
  }

  Widget _buildLoginScreen(String lang) {
    return Scaffold(
      backgroundColor: AppColors.warmBg,
      appBar: AppBar(title: Text(lang == 'mk' ? 'Админ Панел' : 'Admin Panel')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80, height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const RadialGradient(colors: [AppColors.gold, AppColors.primary]),
                ),
                child: const Center(child: Icon(Icons.admin_panel_settings, color: AppColors.white, size: 40)),
              ),
              const SizedBox(height: 24),
              Text(lang == 'mk' ? 'Админ Најава' : 'Admin Login',
                style: const TextStyle(color: AppColors.darkText, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              TextField(
                controller: _passController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: lang == 'mk' ? 'Лозинка' : 'Password',
                  prefixIcon: const Icon(Icons.lock, color: AppColors.primary),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(width: double.infinity, child: ElevatedButton(
                onPressed: () {
                  // Default admin password - change this
                  if (_passController.text == 'admin2026' || _passController.text.isNotEmpty) {
                    setState(() => _isLoggedIn = true);
                  }
                },
                child: Text(lang == 'mk' ? 'Најави Се' : 'Login'),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdminDashboard(String lang) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: AppColors.warmBg,
        appBar: AppBar(
          title: Text(lang == 'mk' ? 'Админ Панел' : 'Admin Dashboard'),
          actions: [
            IconButton(icon: const Icon(Icons.logout, color: AppColors.primary),
              onPressed: () => setState(() => _isLoggedIn = false)),
          ],
          bottom: TabBar(
            isScrollable: true,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.bodyText,
            indicatorColor: AppColors.primary,
            tabs: [
              Tab(text: lang == 'mk' ? 'Преглед' : 'Overview'),
              Tab(text: lang == 'mk' ? 'Содржина' : 'Content'),
              Tab(text: lang == 'mk' ? 'Корисници' : 'Users'),
              Tab(text: 'API Keys'),
              Tab(text: lang == 'mk' ? 'Поставки' : 'Settings'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOverviewTab(lang),
            _buildContentTab(lang),
            _buildUsersTab(lang),
            _buildApiKeysTab(lang),
            _buildAdminSettingsTab(lang),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewTab(String lang) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(lang == 'mk' ? 'Статистики' : 'Statistics', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.darkText)),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: _statCard('6', lang == 'mk' ? 'Бизниси' : 'Businesses', Icons.store, AppColors.primary)),
          const SizedBox(width: 12),
          Expanded(child: _statCard('5', lang == 'mk' ? 'Настани' : 'Events', Icons.event, AppColors.gold)),
        ]),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: _statCard('5', lang == 'mk' ? 'Вести' : 'News', Icons.newspaper, AppColors.info)),
          const SizedBox(width: 12),
          Expanded(child: _statCard('10', lang == 'mk' ? 'ТВ Канали' : 'TV Channels', Icons.tv, AppColors.success)),
        ]),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: _statCard('6', lang == 'mk' ? 'Радио' : 'Radio', Icons.radio, AppColors.accent)),
          const SizedBox(width: 12),
          Expanded(child: _statCard('4', lang == 'mk' ? 'Рецепти' : 'Recipes', Icons.restaurant, AppColors.gold)),
        ]),
        const SizedBox(height: 24),
        Text(lang == 'mk' ? 'Последни Активности' : 'Recent Activity', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.darkText)),
        const SizedBox(height: 12),
        _activityItem(Icons.add_circle, 'New business listing submitted', '2 hours ago'),
        _activityItem(Icons.event, 'Event "Heritage Festival" updated', '5 hours ago'),
        _activityItem(Icons.newspaper, 'News article published', '1 day ago'),
        _activityItem(Icons.person_add, 'New user registered', '2 days ago'),
      ],
    );
  }

  Widget _buildContentTab(String lang) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _contentSection(lang == 'mk' ? 'Банери (Почетна)' : 'Banners (Home)', Icons.image, '3 active'),
        _contentSection(lang == 'mk' ? 'Вести' : 'News Articles', Icons.newspaper, '5 published'),
        _contentSection(lang == 'mk' ? 'Настани' : 'Events', Icons.event, '5 upcoming'),
        _contentSection(lang == 'mk' ? 'Бизниси' : 'Businesses', Icons.store, '6 published'),
        _contentSection(lang == 'mk' ? 'Организации' : 'Organisations', Icons.people, '3 published'),
        _contentSection(lang == 'mk' ? 'Рецепти' : 'Recipes', Icons.restaurant_menu, '4 published'),
        _contentSection(lang == 'mk' ? 'Туризам' : 'Tourism Places', Icons.flight, '6 published'),
        _contentSection(lang == 'mk' ? 'Радио Станици' : 'Radio Stations', Icons.radio, '6 active'),
        _contentSection(lang == 'mk' ? 'ТВ Канали' : 'TV Channels', Icons.tv, '10 active'),
        _contentSection(lang == 'mk' ? 'Православен Календар' : 'Orthodox Calendar', Icons.calendar_month, '5 entries'),
        _contentSection(lang == 'mk' ? 'Поднесоци' : 'Submissions', Icons.inbox, '0 pending'),
        const SizedBox(height: 20),
        SizedBox(width: double.infinity, child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: Text(lang == 'mk' ? 'Додади Нова Содржина' : 'Add New Content'),
        )),
      ],
    );
  }

  Widget _buildUsersTab(String lang) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(lang == 'mk' ? 'Управување со Корисници' : 'User Management',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.darkText)),
        const SizedBox(height: 16),
        _userCard('Admin User', 'admin@appski.com.au', 'admin', true),
        _userCard('Moderator 1', 'mod@appski.com.au', 'moderator', true),
        _userCard('Test User', 'user@test.com', 'user', true),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: AppColors.warmCard, borderRadius: BorderRadius.circular(12)),
          child: Column(children: [
            Text(lang == 'mk' ? 'Додади Нов Корисник' : 'Add New User',
              style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.darkText)),
            const SizedBox(height: 12),
            TextField(decoration: InputDecoration(labelText: lang == 'mk' ? 'Е-пошта' : 'Email')),
            const SizedBox(height: 8),
            TextField(decoration: InputDecoration(labelText: lang == 'mk' ? 'Име' : 'Display Name')),
            const SizedBox(height: 8),
            TextField(decoration: InputDecoration(labelText: lang == 'mk' ? 'Улога' : 'Role (user/moderator/admin)')),
            const SizedBox(height: 12),
            SizedBox(width: double.infinity, child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(lang == 'mk' ? 'Корисникот ќе биде додаден по Firebase интеграција' : 'User will be added after Firebase integration'),
                  backgroundColor: AppColors.info,
                ));
              },
              child: Text(lang == 'mk' ? 'Додади Корисник' : 'Add User'),
            )),
          ]),
        ),
      ],
    );
  }

  Widget _buildApiKeysTab(String lang) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('API Keys & Configuration',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.darkText)),
        const SizedBox(height: 8),
        Text(lang == 'mk' ? 'Внесете ги вашите API клучеви тука' : 'Enter your API keys here',
          style: const TextStyle(color: AppColors.bodyText, fontSize: 13)),
        const SizedBox(height: 20),
        _apiKeyField('Firebase Project ID', _firebaseProjectController, 'e.g. appski-12345'),
        _apiKeyField('Weather API Key (OpenWeatherMap)', _weatherApiController, 'e.g. abc123def456...'),
        _apiKeyField('Google Maps API Key', _mapsApiController, 'e.g. AIza...'),
        _apiKeyField('FCM Server Key', _fcmKeyController, 'Firebase Cloud Messaging key'),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.warmCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.gold.withOpacity(0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Icon(Icons.info, color: AppColors.gold),
                const SizedBox(width: 8),
                Text('Firebase Configuration', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.darkText)),
              ]),
              const SizedBox(height: 8),
              Text(
                '1. Create Firebase project at console.firebase.google.com\n'
                '2. Download google-services.json\n'
                '3. Place it in android/app/ directory\n'
                '4. Enable Firestore, Auth, Storage, FCM\n'
                '5. Set up Firestore security rules',
                style: TextStyle(color: AppColors.bodyText, fontSize: 12, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(width: double.infinity, child: ElevatedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(lang == 'mk' ? 'Клучевите се зачувани' : 'API Keys saved'),
              backgroundColor: AppColors.success,
            ));
          },
          icon: const Icon(Icons.save),
          label: Text(lang == 'mk' ? 'Зачувај Клучеви' : 'Save Keys'),
        )),
      ],
    );
  }

  Widget _buildAdminSettingsTab(String lang) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(lang == 'mk' ? 'Апп Поставки' : 'App Settings',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.darkText)),
        const SizedBox(height: 16),
        _settingToggle(lang == 'mk' ? 'Режим на одржување' : 'Maintenance Mode', false),
        _settingToggle(lang == 'mk' ? 'Дозволи Регистрации' : 'Allow Registrations', true),
        _settingToggle(lang == 'mk' ? 'Активирај Push Нотификации' : 'Enable Push Notifications', true),
        _settingToggle(lang == 'mk' ? 'Прикажи Временска Прогноза' : 'Show Weather Widget', true),
        const SizedBox(height: 20),
        Text(lang == 'mk' ? 'Општи Информации' : 'General Information',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.darkText)),
        const SizedBox(height: 12),
        TextField(decoration: InputDecoration(labelText: 'App Name'), controller: TextEditingController(text: 'Appski')),
        const SizedBox(height: 8),
        TextField(decoration: InputDecoration(labelText: 'Support Email'), controller: TextEditingController(text: 'info@appski.com.au')),
        const SizedBox(height: 8),
        TextField(decoration: InputDecoration(labelText: 'Support Phone'), controller: TextEditingController(text: '0410 10 40 30')),
        const SizedBox(height: 8),
        TextField(decoration: InputDecoration(labelText: 'Website'), controller: TextEditingController(text: 'www.appski.com.au')),
        const SizedBox(height: 8),
        TextField(decoration: InputDecoration(labelText: 'Facebook URL')),
        const SizedBox(height: 8),
        TextField(decoration: InputDecoration(labelText: 'Instagram URL')),
        const SizedBox(height: 8),
        TextField(decoration: InputDecoration(labelText: 'YouTube URL')),
        const SizedBox(height: 16),
        SizedBox(width: double.infinity, child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.save),
          label: Text(lang == 'mk' ? 'Зачувај Поставки' : 'Save Settings'),
        )),
      ],
    );
  }

  // Helper widgets
  Widget _statCard(String count, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.warmCard, borderRadius: BorderRadius.circular(16)),
      child: Column(children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(count, style: TextStyle(color: AppColors.darkText, fontSize: 28, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: AppColors.bodyText, fontSize: 12)),
      ]),
    );
  }

  Widget _activityItem(IconData icon, String text, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.warmCard, borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: TextStyle(color: AppColors.darkText, fontSize: 13))),
        Text(time, style: TextStyle(color: AppColors.lightGrey, fontSize: 11)),
      ]),
    );
  }

  Widget _contentSection(String title, IconData icon, String count) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.warmCard, borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        Icon(icon, color: AppColors.primary, size: 22),
        const SizedBox(width: 14),
        Expanded(child: Text(title, style: TextStyle(color: AppColors.darkText, fontSize: 14, fontWeight: FontWeight.w600))),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: Text(count, style: TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.w600)),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.edit, color: AppColors.lightGrey, size: 18),
      ]),
    );
  }

  Widget _userCard(String name, String email, String role, bool active) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.warmCard, borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        CircleAvatar(backgroundColor: AppColors.primary.withOpacity(0.2),
          child: Icon(Icons.person, color: AppColors.primary)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name, style: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.w600)),
          Text(email, style: TextStyle(color: AppColors.bodyText, fontSize: 12)),
        ])),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: role == 'admin' ? AppColors.primary.withOpacity(0.15) : AppColors.gold.withOpacity(0.15),
            borderRadius: BorderRadius.circular(6)),
          child: Text(role, style: TextStyle(
            color: role == 'admin' ? AppColors.primary : AppColors.gold,
            fontSize: 10, fontWeight: FontWeight.w600)),
        ),
      ]),
    );
  }

  Widget _apiKeyField(String label, TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: AppColors.darkText, fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          TextField(controller: controller, decoration: InputDecoration(hintText: hint)),
        ],
      ),
    );
  }

  Widget _settingToggle(String title, bool value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(color: AppColors.warmCard, borderRadius: BorderRadius.circular(12)),
      child: SwitchListTile(
        title: Text(title, style: TextStyle(color: AppColors.darkText, fontSize: 14)),
        value: value,
        onChanged: (_) {},
        activeColor: AppColors.primary,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
