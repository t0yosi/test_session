import 'package:flutter/material.dart';
import '../utils/text_styles.dart';

class ExpandableCategoriesSection extends StatefulWidget {
  const ExpandableCategoriesSection({super.key});

  @override
  State<ExpandableCategoriesSection> createState() =>
      _ExpandableCategoriesSectionState();
}

class _ExpandableCategoriesSectionState
    extends State<ExpandableCategoriesSection> {
  bool _isExpanded = true;
  bool _isBoysSelected = false;
  bool _isGirlsSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Collapsible header
        InkWell(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (_isExpanded
                    ? const Icon(
                        Icons.chevron_left,
                        color: Colors.purple,
                        size: 32,
                      )
                    : Text(
                        'Categories',
                        style: AppTextStyles.labelLarge(context).copyWith(
                          color: Colors.grey,
                        ),
                      )),
                (_isExpanded
                    ? Expanded(
                        child: Text(
                          'Categories from this seller',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.labelLarge(context).copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : const Icon(
                        Icons.expand_more,
                        color: Colors.purple,
                        size: 32,
                      )),
              ],
            ),
          ),
        ),

        // Collapsible content
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          crossFadeState: _isExpanded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Column(
            children: [
              const Divider(height: 20),
              _buildCategoryItem('Men', '724 items'),
              const Divider(height: 20),
              _buildCategoryItem('Women', '923 items'),
              const Divider(height: 20),
              _buildCategoryItem('Kids', '541 items'),
              const Divider(height: 20),
              _buildCategoryCheckboxItem('Boys', '200 items', _isBoysSelected,
                  (val) {
                setState(() => _isBoysSelected = val!);
              }),
              const Divider(height: 20),
              _buildCategoryCheckboxItem('Girls', '341 items', _isGirlsSelected,
                  (val) {
                setState(() => _isGirlsSelected = val!);
              }),
            ],
          ),
          secondChild: const SizedBox.shrink(),
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildCategoryItem(String category, String count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(category, style: AppTextStyles.bodyMedium(context)),
              const SizedBox(width: 8),
              Text('($count)',
                  style: AppTextStyles.bodyMedium(context).copyWith(
                    color: Colors.grey,
                  )),
            ],
          ),
          const Icon(Icons.expand_more, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildCategoryCheckboxItem(
    String category,
    String count,
    bool isSelected,
    ValueChanged<bool?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(category, style: AppTextStyles.bodyMedium(context)),
              const SizedBox(width: 8),
              Text('($count)',
                  style: AppTextStyles.bodyMedium(context)
                      .copyWith(color: Colors.grey)),
            ],
          ),
          Row(
            children: [
              Text(
                'Select',
                style: AppTextStyles.bodyMedium(context).copyWith(
                  color: isSelected ? Colors.purple : Colors.grey,
                ),
              ),
              Checkbox(
                semanticLabel: 'Select',
                value: isSelected,
                onChanged: onChanged,
                activeColor: Colors.purple,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
