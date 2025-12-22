
//import 'package:booking_app/models/product_model.dart';
//import 'package:booking_app/screens/Details/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:task/models/product.dart';
import 'package:task/view/property_deatils_view.dart';
class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context)=>  DetailScreen(product: product,)
            ),
        );
      },
      child: Stack(

        children: [

           Container(
           width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
              ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  SizedBox(height: 5,),
                    Center(
                      child: Image.asset(
                        product.image,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.only(left:5),
                      child: Text(
                        product.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                        ),
                      ),
                    ),
                     const SizedBox(height: 5),


                ],
                ),
              ),

      
          
        ],
      
      ),
    );
  }

  // DetailScreen({required Product product}) {}
}
class DetailScreen extends StatelessWidget {
  final Product product;

  const DetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return PropertyDetailsScreen(product: product);
  }
}

