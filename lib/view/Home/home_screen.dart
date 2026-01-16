import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/controllers/apartment_controller.dart';
import 'package:task/generated/l10n.dart';
import 'package:task/models/apartment_model.dart';
import 'package:task/view/Home/Widget/Home_Drawer%20.dart';
import 'package:task/view/Home/Widget/apartment_filter_sheet.dart';
// import '../controllers/product_controller.dart';
// import '../models/product.dart';
import 'Widget/home_app_bar.dart';
import 'Widget/image_slider.dart';
import 'Widget/product_card.dart';
import 'Widget/search_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int currentSlider = 0;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productControllerProvider);

    final categories = [
      S.of(context).all,
      S.of(context).apartment,
      S.of(context).villa,
      S.of(context).hotel_room,
    ];

    return Scaffold(
      drawer: const HomeDrawer(),
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff285260),
              Color(0xff5A9C92),
              Color(0xffB4D7D8),
              Color(0xffAA8872),
            ],
            stops: [0.0, 0.37, 0.60, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 35),
                const CustomAppBar(),
                const SizedBox(height: 20),
           MySearchBar(
  onSearch: (query) {
    ref
        .read(productControllerProvider.notifier)
        .search(query);
  },
  onFilterPressed: () async {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const ApartmentFilterSheet(),
    );

    if (result != null) {
      ref
          .read(productControllerProvider.notifier)
          .applyLocalFilter(result);
    }
  },
),

                const SizedBox(height: 20),
                ImageSlider(
                  currentSlider: currentSlider,
                  onCharge: (value) {
                    setState(() {
                      currentSlider = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: selectedIndex == index
                                ? Colors.blue[200]
                                : Colors.transparent,
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 65,
                                width: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: selectedIndex == index
                                      ? Colors.blue[200]
                                      : Colors.grey[300],
                                ),
                                child: Center(
                                  child: Icon(
                                    index == 0
                                        ? Icons
                                              .apps // All
                                        : index == 1
                                        ? Icons
                                              .apartment // Apartment
                                        : index == 2
                                        ? Icons
                                              .villa // Villa
                                        : Icons.hotel, // Hotel room
                                    size: 32,
                                    color: Color(0xff285260),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 5),
                              Text(
                                categories[index],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).special_for_you,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      S.of(context).see_all,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                productsAsync.when(
                  data: (products) {
                    List<Product> filtered = selectedIndex == 0
                        ? products
                        : products
                              .where(
                                (p) =>
                                    (p.title ?? "").toLowerCase() ==
                                    categories[selectedIndex].toLowerCase(),
                              )
                              .toList();

                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.78,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: filtered[index]);
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, st) => Center(child: Text('Error: $e')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
