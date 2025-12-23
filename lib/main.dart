


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/view/Home/home_screen.dart';
import 'package:task/view/cart_screen.dart';
import 'package:task/view/favourite.dart';
import 'package:task/view/profile_view.dart';
import 'package:task/view/welcome/welcome_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // textTheme: GoogleFonts.mulishTextTheme(),
      ),
      // home: BottomNavBar(),
        home: WelcomeScreen(),
//         home: const Scaffold(
//   // body: Center(child: CircularProgressIndicator()),
// ),

    );
  }
}



class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int cuttentIndex=2;
  List<Widget> screens = [

     Scaffold(),
     Favourite(),
     HomeScreen(),
     CartScreen(),
    //  Scaffold(),
     ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          cuttentIndex=2;

        });
      },
        shape: CircleBorder(),
        backgroundColor: Color(0xff5A9C92),
        child: const Icon(
          Icons.home,
          color: Colors.white,
          size: 35,
        ),
      ),
      floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked ,
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        height: 60,
        color: Colors.white,
        shape:  const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: (){
                setState(() {
                  cuttentIndex=0;
                });
              },
              icon: Icon(
                Icons.grid_view_outlined,
                size: 30,
                color: cuttentIndex == 0 ? Color(0xff5A9C92) :Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: (){
                setState(() {
                  cuttentIndex=1;
                });
              },
              icon: Icon(
                Icons.favorite_border,
                size: 30,
                color: cuttentIndex == 1 ? Color(0xff5A9C92) :Colors.grey.shade400,
              ),
            ),
            const SizedBox(width: 15,),
            IconButton(
              onPressed: (){
                setState(() {
                  cuttentIndex=3;
                });
              },
              icon: Icon(
                Icons.shopping_cart_outlined,
                size: 30,
                color: cuttentIndex == 3 ? Color(0xff5A9C92) :Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: (){
                setState(() {
      cuttentIndex = 4;
    });
              },
              icon: Icon(
                Icons.person,
                size: 30,
                color: cuttentIndex == 4 ? Color(0xff5A9C92) :Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
      body: screens[cuttentIndex],
    );
  }
}