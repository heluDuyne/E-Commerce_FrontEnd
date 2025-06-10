import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/theme/theme_provider.dart';
import 'package:e_commerce_frontend/scr/core/utils/values/colors.dart';
import 'package:e_commerce_frontend/scr/core/utils/helpers/responsive_ui_helper/responsive_ui_config.dart';
import 'package:e_commerce_frontend/scr/presentation/widgets/search_bar_with_filter.dart';

@RoutePage()
class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final List<String> bannerTitles = ['CLOTHING', 'ACCESSORIES', 'SHOES', 'COLLECTION'];
  int? expandedBannerIndex;

  final List<List<Map<String, dynamic>>> categories = [
    // CLOTHING
    [
      {'title': 'Jacket', 'count': 128},
      {'title': 'Skirts', 'count': 40},
      {
        'title': 'Dresses',
        'count': 36,
        'subcategories': [
          {'title': 'Sweaters', 'count': 24},
          {'title': 'Jeans', 'count': 14},
        ]
      },
      {'title': 'T-Shirts', 'count': 12},
      {'title': 'Pants', 'count': 9},
    ],
    // ACCESSORIES
    [
      {'title': 'Handbags', 'count': 22},
      {'title': 'Jewelry', 'count': 18},
      {'title': 'Belts', 'count': 10},
      {'title': 'Scarves', 'count': 6},
    ],
    // SHOES
    [
      {'title': 'Heels', 'count': 15},
      {'title': 'Boots', 'count': 12},
      {'title': 'Sneakers', 'count': 20},
      {'title': 'Sandals', 'count': 10},
    ],
    // COLLECTION
    [
      {'title': 'Summer Lookbook', 'count': 8},
      {'title': 'Business Casual', 'count': 12},
      {'title': 'Evening Styles', 'count': 5},
      {'title': 'Party Wear', 'count': 6},
    ],
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final responsive = ResponsiveUiConfig(context);

    return Scaffold(
      backgroundColor: isDarkMode ? ColorDark.background : ColorLight.background,
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        backgroundColor: isDarkMode ? ColorDark.background : ColorLight.background,
        title: Text(
          'Discover',
          style: TextStyle(
            color: isDarkMode ? ColorDark.titleText : ColorLight.titleText,
            fontWeight: FontWeight.w600,
            fontSize: responsive.setWidth(18),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu,
              color: isDarkMode ? ColorDark.iconPrimary : ColorLight.iconPrimary),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none,
                color: isDarkMode ? ColorDark.iconPrimary : ColorLight.iconPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(responsive.setWidth(16)),
        children: [
          const SearchBarWithFilter(),

          const SizedBox(height: 16),

          ...List.generate(bannerTitles.length, (index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      expandedBannerIndex =
                      expandedBannerIndex == index ? null : index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    height: responsive.setHeight(100),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage('assets/images/discover_banner_${index + 1}.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      bannerTitles[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                if (expandedBannerIndex == index && categories[index].isNotEmpty)
                  Column(
                    children: categories[index].expand((item) {
                      final bool hasSub = item.containsKey('subcategories');
                      return [
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          title: Text(
                            item['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: isDarkMode
                                  ? ColorDark.titleText
                                  : ColorLight.titleText,
                            ),
                          ),
                          trailing: Text(
                            '${item['count']} items',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDarkMode
                                  ? ColorDark.subtitleText
                                  : ColorLight.subtitleText,
                            ),
                          ),
                          onTap: () {},
                        ),
                        if (hasSub)
                          ...List<Map<String, dynamic>>.from(item['subcategories']).map((sub) {
                            return ListTile(
                              contentPadding: const EdgeInsets.only(left: 40, right: 16),
                              title: Text(
                                sub['title'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isDarkMode
                                      ? ColorDark.subtitleText
                                      : ColorLight.subtitleText,
                                ),
                              ),
                              trailing: Text(
                                '${sub['count']} items',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDarkMode
                                      ? ColorDark.subtitleText
                                      : ColorLight.subtitleText,
                                ),
                              ),
                              onTap: () {},
                            );
                          }),
                      ];
                    }).toList(),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}