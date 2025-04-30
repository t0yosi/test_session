import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../utils/responsive.dart';
import '../utils/text_styles.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  late Future<Map<String, dynamic>> _shopData;

  @override
  void initState() {
    super.initState();
    _shopData = _fetchShopData();
  }

  // Simulate API fetch with dummy data
  Future<Map<String, dynamic>> _fetchShopData() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    
    return {
      'seller': {
        'name': 'Maddison2525',
        'rating': 4.8,
        'reviewCount': 300,
        'location': 'London, United Kingdom',
        'verifications': [
          '🌟 Ships in 1 day',
          '📧 Email Verified',
          '📱 Number Verified',
          '🕒 Last seen moments ago',
        ],
        'description': 'Welcome to my wardrobe, all items are shipped from a clean, smoke free and reputable home. If you have any questions, please, reach out, thanks!',
        'stats': {
          'listings': 2025,
          'followings': 10,
          'followers': 10000,
        },
      },
      'categories': ['Nike', 'Levis', 'Vintage', 'The North'],
      'products': [
        {
          'name': 'Nike Cropped Top',
          'condition': 'Like New',
          'price': '£130 - £65',
          'image': 'assets/product.png',
        },
        {
          'name': 'Gucci Bag',
          'condition': 'Like New',
          'price': '£650',
          'image': 'assets/product.png',
        },
        {
          'name': 'Nike Cropped Top',
          'condition': 'Like New',
          'price': '',
          'image': 'assets/product.png',
        },
        {
          'name': 'Gucci Bag',
          'condition': 'Like New',
          'price': '',
          'image': 'assets/product.png',
        },
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text('Wardrobe', style: AppTextStyles.headlineMedium(context)),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              themeProvider.setTheme(
                isDarkMode ? ThemeMode.light : ThemeMode.dark,
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _shopData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          }

          final data = snapshot.data!;
          final seller = data['seller'] as Map<String, dynamic>;
          final products = data['products'] as List<dynamic>;
          final categories = data['categories'] as List<dynamic>;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.screenWidth(context) * 0.05,
              vertical: Responsive.screenHeight(context) * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Seller info section
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/avat.png'),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(seller['name'], 
                            style: AppTextStyles.titleLarge(context)),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            Text('${'★' * 5} (${seller['reviewCount']})',
                                style: AppTextStyles.bodyMedium(context)),
                          ],
                        ),
                        Text(seller['location'],
                            style: AppTextStyles.bodyMedium(context).copyWith(
                              fontSize: Responsive.responsiveFontSize(context) * 0.8,
                            )),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Verified badges
                Wrap(
                  spacing: 8,
                  children: (seller['verifications'] as List<dynamic>)
                      .map((verification) => Chip(
                            label: Text(verification.toString(),
                                style: AppTextStyles.labelLarge(context)),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16),

                // Description
                Text(
                  seller['description'].toString(),
                  style: AppTextStyles.bodyMedium(context),
                ),
                const Divider(height: 32),

                // Stats
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatColumn(
                        context, seller['stats']['listings'].toString(), 'Listings'),
                    _buildStatColumn(
                        context, seller['stats']['followings'].toString(), 'Followings'),
                    _buildStatColumn(
                        context, seller['stats']['followers'].toString(), 'Followers'),
                  ],
                ),
                const Divider(height: 32),

                // Categories
                Text('Categories', style: AppTextStyles.titleLarge(context)),
                const SizedBox(height: 8),
                Text('Top brands', style: AppTextStyles.bodyMedium(context)),
                const SizedBox(height: 16),

                // Brand filters
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  childAspectRatio: 2,
                  children: categories
                      .map((brand) => _buildBrandChip(context, brand.toString()))
                      .toList(),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('Filter', style: AppTextStyles.labelLarge(context)),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Sort', style: AppTextStyles.labelLarge(context)),
                    ),
                  ],
                ),
                const Divider(height: 32),

                // Products
                ...products.map((product) => _buildProductItem(
                      context,
                      product['name'].toString(),
                      product['condition'].toString(),
                      product['price'].toString(),
                      product['image'].toString(),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatColumn(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.titleLarge(context).copyWith(
          fontSize: Responsive.responsiveFontSize(context) * 1.2,
        )),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.labelLarge(context)),
      ],
    );
  }

  Widget _buildBrandChip(BuildContext context, String brand) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(brand, style: AppTextStyles.labelLarge(context)),
      ),
    );
  }

  Widget _buildProductItem(
    BuildContext context,
    String name,
    String condition,
    String price,
    String imagePath,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(name, style: AppTextStyles.titleLarge(context)),
          Text(condition, style: AppTextStyles.bodyMedium(context).copyWith(
            fontSize: Responsive.responsiveFontSize(context) * 0.8,
          )),
          if (price.isNotEmpty)
            Text(price, style: AppTextStyles.bodyLarge(context).copyWith(
              fontWeight: FontWeight.bold,
            )),
          const Divider(height: 32),
        ],
      ),
    );
  }
}