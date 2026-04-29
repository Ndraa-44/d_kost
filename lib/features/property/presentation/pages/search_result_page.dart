import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/property_list_card.dart';
import '../../data/datasources/property_local_datasource.dart';
import '../../domain/entities/property.dart';

/// Search results page — shows properties filtered by category & location.
class SearchResultPage extends StatefulWidget {
  final String location;
  final String category;

  const SearchResultPage({
    super.key,
    required this.location,
    required this.category,
  });

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Property> _results = [];

  @override
  void initState() {
    super.initState();
    _filterProperties();
  }

  void _filterProperties() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _results = PropertyLocalDataSource.properties.where((p) {
        final matchCategory =
            p.category.toLowerCase() == widget.category.toLowerCase();
        final matchLocation =
            p.location.toLowerCase() == widget.location.toLowerCase();
        final matchQuery = query.isEmpty ||
            p.name.toLowerCase().contains(query) ||
            p.location.toLowerCase().contains(query);
        return matchCategory && matchLocation && matchQuery;
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('${widget.category} di ${widget.location}'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search input
          Container(
            color: AppColors.primary,
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.xl - 4,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => _filterProperties(),
                decoration: InputDecoration(
                  hintText: AppStrings.searchPropertyHint,
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.grey.shade400),
                ),
              ),
            ),
          ),
          // Info bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md - 4,
            ),
            color: Colors.white,
            child: Text(
              AppStrings.propertiesFound(_results.length),
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Divider(height: 1),
          // Results
          Expanded(
            child: _results.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    itemCount: _results.length,
                    itemBuilder: (context, index) {
                      return PropertyListCard(
                        property: _results[index],
                        onTap: () => context.push(
                          AppRouter.propertyDetailPath,
                          extra: _results[index],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: AppSpacing.md),
          Text(
            AppStrings.noResultFound(widget.category, widget.location),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
          ),
          const SizedBox(height: AppSpacing.lg),
          OutlinedButton.icon(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_rounded),
            label: const Text(AppStrings.changeSearch),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md - 4,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
