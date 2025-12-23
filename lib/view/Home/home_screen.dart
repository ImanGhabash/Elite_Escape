
import 'package:flutter/material.dart';
import 'package:task/models/product.dart';
//import '../../models/category.dart';
//import '../../models/product_model.dart';
import 'Widget/home_app_bar.dart';
import 'Widget/image_slider.dart';
import 'Widget/product_cart.dart';
import 'Widget/search_bar.dart';
class Category {
  final String title;
  final String image;


  Category({
    required this.title,
    required this.image,
  });
}
final List<Category> categories = [
  Category(
      title: "All",
      image:"images/cute-english-house-illustration-retro-style-architecture-cottagecore-style-cozy-home-with-flower-and-chimney-png.png"
  ),
  Category(

      title: "Apartment",
      image: "images/download.jpg"
  ),
  Category(
      title: "Villa",
      image: "images/images.jpg"
  ),
  Category(
      title: "Hotel room",
      image: "images/img.png"
  ),
  Category(
      title: "Cottage",
      image:"images/cute-english-house-illustration-retro-style-architecture-cottagecore-style-cozy-home-with-flower-and-chimney-png.png"
  ),


];
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
const Color darkTeal =Color(0xff285260);
const Color mediumTeal =Color(0xff5A9C92);
const Color lightAqua =Color(0xffB4D7D8);
const Color lightBeige =Color(0xffE0CFBF);
const Color tanBrown =Color(0xffAA8872);

class _HomeScreenState extends State<HomeScreen> {
  int currentSlider=0;
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    List<List<Product>> selectedCategories=[all,appartment,villa,hotelRoom,cottage];
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              darkTeal,
              mediumTeal,
              lightAqua,
              // lightBeige,
              tanBrown,

            ],
            stops: [0.0, 0.37, 0.60, 1.0],
          ),),
        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 35),
              const CustomAppBar(),
              const SizedBox(height: 20),
              const MySearchBar(),
              const SizedBox(height: 20),
              ImageSlider(
                  currentSlider: currentSlider,
                  onCharge: (value) {
                    setState(() {
                currentSlider= value;
                },
                    );
                  },
              ),
              const SizedBox(height: 20),
            SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedIndex=index;
                      });

                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: selectedIndex==index
                            ?Colors.blue[200]
                            :Colors.transparent,
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 65,
                            width: 70,
                            decoration: BoxDecoration(

                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(categories[index].image),
                                fit: BoxFit.cover,

                              ),
                            ),
                          ),

                          const SizedBox(height: 5,),
                          Text(
                            categories[index].title,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },

              ),
            ),
               const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Special For You",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "See All",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black54,
                    ),
                  ),
                ],
              ),
              GridView.builder(
                physics:const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    childAspectRatio: 0.78,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20
                  ),
                itemCount: selectedCategories[selectedIndex].length,
                itemBuilder: (context,index){
                    return ProductCard(
                      product:  selectedCategories[selectedIndex][index],
                    );
                },
              )
            ],
          ),
          ),
        ),
      ),
    );
  }
}




