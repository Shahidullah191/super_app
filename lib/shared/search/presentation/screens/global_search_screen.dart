import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class GlobalSearchScreen extends StatefulWidget {
  const GlobalSearchScreen({super.key});

  @override
  State<GlobalSearchScreen> createState() => _GlobalSearchScreenState();
}

class _GlobalSearchScreenState extends State<GlobalSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _allResults = [
    {'title': 'Burger King', 'type': 'Food', 'icon': Icons.restaurant},
    {'title': 'Fresh Apples', 'type': 'Grocery', 'icon': Icons.shopping_basket},
    {
      'title': 'Napa Extend',
      'type': 'Pharmacy',
      'icon': Icons.medical_services,
    },
    {'title': 'AC Repair', 'type': 'Service', 'icon': Icons.build},
    {'title': 'Pizza Hut', 'type': 'Food', 'icon': Icons.restaurant},
    {'title': 'Organic Milk', 'type': 'Grocery', 'icon': Icons.shopping_basket},
  ];
  List<Map<String, dynamic>> _filteredResults = [];

  @override
  void initState() {
    super.initState();
    _filteredResults = _allResults;
  }

  void _filterResults(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredResults = _allResults;
      } else {
        _filteredResults = _allResults
            .where(
              (item) =>
                  item['title'].toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'search_hint'.tr,
            border: InputBorder.none,
          ),
          onChanged: _filterResults,
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                _filterResults('');
              },
            ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_searchController.text.isEmpty) _buildRecentSearches(),
          Expanded(
            child: _filteredResults.isEmpty
                ? _buildNoResults()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: _filteredResults.length,
                    itemBuilder: (_, i) =>
                        _buildResultTile(_filteredResults[i]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSearches() {
    final recent = ['Burger', 'Medicine', 'Milk', 'Electrician'];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Searches',
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: recent
                .map(
                  (s) => ActionChip(
                    label: Text(s),
                    onPressed: () {
                      _searchController.text = s;
                      _filterResults(s);
                    },
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildResultTile(Map<String, dynamic> item) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(item['icon'], color: AppColors.primary, size: 20),
      ),
      title: Text(
        item['title'],
        style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(item['type'], style: AppTextStyles.bodySmall),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: () {
        // Navigate based on type
      },
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off,
            size: 64,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 16),
          Text('No results found', style: AppTextStyles.bodyLarge),
          Text(
            'Try searching for something else',
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }
}
