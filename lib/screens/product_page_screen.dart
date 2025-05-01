import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../utils/text_styles.dart';
import '../providers/theme_provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<Color> _colors = [
    Color(0xFFDDB6B7),
    Color(0xFF6F2225),
    Color(0xFFD63B3A),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Images Carousel
            SizedBox(
              height: 500,
              child: PageView(
                children: [
                  Image.asset(
                    'assets/jacket.png',
                    fit: BoxFit.fitHeight,
                  ),
                  Image.asset(
                    'assets/product.png',
                    fit: BoxFit.fitHeight,
                  ),
                ],
              ),
            ),

            // Product Info Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Asos Edited patchwork quilt jacket in red and cherry',
                      style: AppTextStyles.bodyLarge(context, useAvenir: true)
                          .copyWith(
                        color: isDarkMode ? Colors.white : Colors.black,
                      )),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Asos Original',
                          style:
                              AppTextStyles.bodyMedium(context, useAvenir: true)
                                  .copyWith(color: Colors.purple)),
                      Text('Size S',
                          style:
                              AppTextStyles.bodyMedium(context, useAvenir: true)
                                  .copyWith(color: Colors.purple)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'New with tags',
                        style: AppTextStyles.labelBase(context, useAvenir: true)
                            .copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Row(
                        children: List.generate(
                          _colors.length,
                          (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _colors[index],
                                border: Border.all(
                                  color: _selectedIndex == index
                                      ? (isDarkMode
                                          ? Colors.white
                                          : Colors.black)
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('£300.00',
                      style: AppTextStyles.bodyBase(context, useAvenir: true)
                          .copyWith(
                        color: Colors.grey,
                      )),
                  const SizedBox(height: 4),
                  Row(children: [
                    Text('£310.70 ',
                        style: AppTextStyles.bodyLarge(context, useAvenir: true)
                            .copyWith(color: Colors.purple)),
                    Text('including ',
                        style:
                            AppTextStyles.labelLarge(context, useAvenir: true)
                                .copyWith(color: Colors.purple)),
                    Text(
                      'Buyer Protection',
                      style: AppTextStyles.labelLarge(context, useAvenir: true)
                          .copyWith(
                        color: Colors.purple,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ]),

                  const SizedBox(height: 16),

                  // Seller Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage('assets/serena_04.png'),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'selena204',
                                style: AppTextStyles.bodyMedium(context,
                                        useAvenir: true)
                                    .copyWith(
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black),
                              ),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: 5,
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text('(250)',
                                      style: AppTextStyles.bodyMedium(context,
                                              useAvenir: true)
                                          .copyWith(
                                              color: isDarkMode
                                                  ? Colors.white
                                                  : Colors.black)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: isDarkMode ? Colors.white : Colors.black),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          'Ask a Question',
                          style:
                              AppTextStyles.bodyMedium(context, useAvenir: true)
                                  .copyWith(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Divider(thickness: 8.0),

                  // Description
                  Text('Description',
                      style: AppTextStyles.labelBase(context, useAvenir: true)
                          .copyWith(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text(
                      'Item has never been worn, it was initially bought as a gift for my sister but it didn\'t fit.',
                      style: AppTextStyles.labelLarge(context, useAvenir: true)
                          .copyWith(
                              color: isDarkMode ? Colors.white : Colors.black)),
                  const SizedBox(height: 16),

                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                    },
                    children: [
                      buildDetailRow(
                          context, 'Category', 'Jackets', isDarkMode),
                      buildDetailRow(context, 'Brand', 'Asos', isDarkMode),
                      buildDetailRow(context, 'Size', 'S', isDarkMode),
                      buildDetailRow(
                          context, 'Condition', 'New with tags', isDarkMode),
                      buildDetailRow(context, 'Views', '240', isDarkMode),
                      buildDetailRow(
                          context, 'Uploaded', '1 week ago', isDarkMode),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Divider(thickness: 8.0),

                  // Postage Info
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Postage',
                          style:
                              AppTextStyles.labelBase(context, useAvenir: true)
                                  .copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'From £1.99',
                          style:
                              AppTextStyles.labelLarge(context, useAvenir: true)
                                  .copyWith(
                            color: Colors.purple,
                          ),
                        ),
                      ]),
                  const SizedBox(height: 4),

                  const Divider(thickness: 8.0),

                  Row(
                    children: [
                      // More from seller
                      Text(
                        'More from seller',
                        style:
                            AppTextStyles.labelLarge(context, useAvenir: true)
                                .copyWith(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(width: 36),

                      // Similar items
                      Text(
                        'Similar items',
                        style:
                            AppTextStyles.labelLarge(context, useAvenir: true)
                                .copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable TableRow builder
  TableRow buildDetailRow(
      BuildContext context, String label, String value, bool isDarkMode) {
    final textStyle =
        AppTextStyles.labelLarge(context, useAvenir: true).copyWith(
      color: isDarkMode ? Colors.white : Colors.black,
    );

    return TableRow(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(label, style: textStyle),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(value, style: textStyle),
            ),
          ],
        ),
      ],
    );
  }
}
