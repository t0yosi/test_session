import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:test_session/widgets/collapsible_categories.dart';
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

  IconData getIconFromKey(String key) {
    switch (key) {
      case '📧':
        return Icons.email;
      case '📱':
        return Icons.phone_android;
      case '🕒':
        return Icons.access_time;
      default:
        return Icons.verified; // Fallback icon
    }
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
          'shipping Ships in 1 day',
          'check Email Verified',
          'check Number Verified',
          'clock Last seen moments ago',
        ],
        'description':
            'Welcome to my wardrobe, all items are shipped from a clean, smoke free and reputable home. If you have any questions, please, reach out, thanks!',
        'stats': {
          'listings': 2025,
          'followings': 10,
          'followers': 10000,
          'reviews': 350,
          'location': 'LDN',
        },
      },
      'categories': [
        'Nike',
        'Levis',
        'Vintage',
        'The North',
        'Levis',
        'Vintage',
        'The North'
      ],
      'products': [
        {
          'name': 'Nike Cropped Top',
          'brand': 'Nike',
          'condition': 'Like New',
          'price': '£65',
          'image': 'assets/product.png',
          'likes': 14,
          'originalPrice': '£130',
          "discountPercentage": 50.0,
        },
        {
          'name': 'Gucci Bag',
          'brand': 'Gucci',
          'condition': 'Like New',
          'price': '£650',
          'image': 'assets/product.png',
          'likes': 45,
        },
        {
          'name': 'Nike Cropped Top',
          'brand': 'Nike',
          'condition': 'Like New',
          'price': '',
          'image': 'assets/product.png',
          'likes': 19,
        },
        {
          'name': 'Gucci Bag',
          'brand': 'Gucci',
          'condition': 'Like New',
          'price': '',
          'image': 'assets/product.png',
          'likes': 21,
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
        title: const Text('Wardrobe'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color(0xFF979797).withOpacity(0.5),
            height: 1.0,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
              title: Text(isDarkMode ? 'Light Mode' : 'Dark Mode'),
              onTap: () {
                themeProvider.setTheme(
                  isDarkMode ? ThemeMode.light : ThemeMode.dark,
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar
                    const CircleAvatar(
                      radius: 36,
                      backgroundImage: AssetImage('assets/avat.png'),
                    ),
                    const SizedBox(width: 16),

                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Username & Rating
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 24,
                                      child: Text(
                                        seller['name'],
                                        style:
                                            AppTextStyles.bodyMedium(context),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        ...List.generate(
                                          seller['rating'].floor(),
                                          (_) => const Icon(Icons.star,
                                              color: Colors.amber, size: 16),
                                        ),
                                        if (seller['rating'] % 1 >= 0.5)
                                          const Icon(Icons.star_half,
                                              color: Colors.amber, size: 16),
                                        const SizedBox(width: 4),
                                        Text(
                                          '(${seller['reviewCount']})',
                                          style:
                                              AppTextStyles.bodyMedium(context)
                                                  .copyWith(
                                            color: Colors.purple,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'icons/add-contact.svg',
                                    width: 22,
                                    height: 22.95,
                                    colorFilter: ColorFilter.mode(
                                      isDarkMode ? Colors.black : Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  SvgPicture.asset(
                                    'icons/reply-arrow.svg',
                                    width: 24,
                                    height: 19.31,
                                  ),
                                ],
                              )
                            ],
                          ),

                          const SizedBox(height: 4),
                          // Location
                          Text(
                            seller['location'],
                            style: AppTextStyles.bodyMedium(context).copyWith(
                                fontSize:
                                    Responsive.responsiveFontSize(context) *
                                        0.9,
                                color:
                                    isDarkMode ? Colors.black : Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Verified badges
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (seller['verifications'] as List<dynamic>).map((v) {
                    final parts = v.toString().split(' ');
                    final iconKey = parts[0];
                    final text = parts.sublist(1).join(' ');

                    Widget leadingIcon;
                    if (iconKey == 'shipping') {
                      leadingIcon = SvgPicture.asset(
                        'icons/shipping.svg',
                        width: 16,
                        height: 16,
                      );
                    } else if (iconKey == 'check') {
                      leadingIcon = SvgPicture.asset(
                        'icons/check-icon.svg',
                        width: 16,
                        height: 16,
                      );
                    } else if (iconKey == 'clock') {
                      leadingIcon = SvgPicture.asset(
                        'icons/clock-icon.svg',
                        width: 16,
                        height: 16,
                      );
                    } else {
                      leadingIcon = Icon(
                        getIconFromKey(iconKey),
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      );
                    }

                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 3),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          leadingIcon,
                          const SizedBox(width: 4),
                          Text(
                            text,
                            style: AppTextStyles.labelLarge(context).copyWith(
                              fontSize:
                                  Responsive.responsiveFontSize(context) * 0.85,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 16),

                // Description
                Text(
                  seller['description'].toString(),
                  style: AppTextStyles.bodyMedium(context),
                ),
                const Divider(height: 20),

                // Stats Section (horizontally scrollable)
                SizedBox(
                  height: Responsive.responsiveFontSize(context) * 4.5,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minWidth: constraints.maxWidth),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildStatColumn(
                                context,
                                seller['stats']['listings'].toString(),
                                'Listings',
                              ),
                              SizedBox(width: constraints.maxWidth * 0.1),
                              _buildStatColumn(
                                context,
                                seller['stats']['followings'].toString(),
                                'Followings',
                              ),
                              SizedBox(width: constraints.maxWidth * 0.1),
                              _buildStatColumn(
                                context,
                                seller['stats']['followers'].toString(),
                                'Followers',
                              ),
                              SizedBox(width: constraints.maxWidth * 0.1),
                              _buildStatColumn(
                                context,
                                seller['stats']['reviews'].toString(),
                                'Reviews',
                              ),
                              SizedBox(width: constraints.maxWidth * 0.1),
                              _buildStatColumn(
                                context,
                                seller['stats']['location'],
                                'Location',
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Divider(height: 20),

                // Categories
                const ExpandableCategoriesSection(),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Top brands',
                        style: AppTextStyles.bodyMedium(context)),
                    const SizedBox(width: 8),
                    const Icon(Icons.search, color: Colors.purple)
                  ],
                ),
                const SizedBox(height: 8),

                // Brand filters (horizontally scrollable chips)
                SizedBox(
                  height: Responsive.responsiveFontSize(context) *
                      3.5, // chip height + padding
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Row(
                      children: categories.map((brand) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 0),
                          child: _buildBrandChip(context, brand.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Filter',
                              style: AppTextStyles.labelLarge(context).copyWith(
                                color: Colors.grey,
                              ),
                            )),
                        SvgPicture.asset(
                          'icons/filters-icon.svg',
                          width: 22,
                          height: 20,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Sort',
                              style: AppTextStyles.labelLarge(context).copyWith(
                                color: Colors.grey,
                              ),
                            )),
                        SvgPicture.asset(
                          'icons/sort-icon.svg',
                          width: 12,
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(height: 20),

                // Products
                GridProductsSection(products: products, context: context),
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
        Text(value, style: AppTextStyles.titleLarger(context)),
        const SizedBox(height: 4),
        Text(label,
            style: AppTextStyles.labelLarge(context).copyWith(
              color: Colors.grey,
            )),
      ],
    );
  }

  Widget _buildBrandChip(BuildContext context, String brand) {
    return Container(
      constraints: const BoxConstraints(minWidth: 70),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.5),
        border: Border.all(
          color: Colors.purple,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        // Center the text
        child: Text(
          brand,
          style: AppTextStyles.bodyMedium(context).copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class GridProductsSection extends StatelessWidget {
  final List<dynamic> products;
  final BuildContext context;

  const GridProductsSection({
    super.key,
    required this.products,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6, // Reduced from 0.7
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return _buildProductItem(
          context,
          product['name'].toString(),
          product['condition'].toString(),
          product['price'].toString(),
          product['image'].toString(),
          product['brand'].toString(),
          product['likes'],
          originalPrice: product['originalPrice']?.toString(),
          discountPercentage: product['discountPercentage']?.toDouble(),
        );
      },
    );
  }
}

Widget _buildProductItem(
  BuildContext context,
  String name,
  String condition,
  String price,
  String imagePath,
  String brand,
  int likes, {
  String? originalPrice,
  double? discountPercentage,
}) {
  final hasDiscount = originalPrice != null &&
      originalPrice.isNotEmpty &&
      discountPercentage != null &&
      discountPercentage > 0;
  final themeProvider = Provider.of<ThemeProvider>(context);
  final isDarkMode = themeProvider.isDarkMode;
  final textColor = isDarkMode ? Colors.black : Colors.white;

  return Container(
    constraints: BoxConstraints(
      maxHeight: Responsive.isMobile(context) ? 400 : 600,
      minHeight: Responsive.isMobile(context) ? 350 : 400,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 200,
          width: double.infinity,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // Pin icon - top right
              Positioned(
                top: 8,
                right: 8,
                child: Transform.rotate(
                  angle: 0.7854,
                  child: const Icon(
                    Icons.push_pin,
                    color: Colors.white,
                    size: 24,
                    shadows: [
                      Shadow(
                        color: Colors.black45,
                        offset: Offset(1, 1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
              // Like icon and count - bottom right
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$likes',
                        style: AppTextStyles.labelSmall(context).copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                brand,
                style: AppTextStyles.labelLarge(context).copyWith(
                  color: Colors.purple,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                name,
                style: AppTextStyles.labelLarge(context),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                condition,
                style: AppTextStyles.labelLarge(context).copyWith(
                  color: Colors.grey,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (price.isNotEmpty)
                hasDiscount
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(height: 4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                originalPrice,
                                style:
                                    AppTextStyles.labelLarge(context).copyWith(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                price,
                                style:
                                    AppTextStyles.labelLarge(context).copyWith(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '${discountPercentage.round()}% OFF',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Text(
                        price,
                        style: AppTextStyles.labelLarge(context).copyWith(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
            ],
          ),
        ),
      ],
    ),
  );
}
