import 'package:flutter/material.dart';

class DetailAppBar extends StatelessWidget {
  const DetailAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.all(10),
    child: Row(children: [
      IconButton(
          style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.all(15)
          ),
          onPressed: (){},
          icon:Icon(Icons.arrow_back_ios)
      ),
      const Spacer(),
      IconButton(
          style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.all(15)
          ),
          onPressed: (){},
          icon:Icon(Icons.share_outlined)
      ),
       const SizedBox(width: 10,),
      IconButton(
          style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.all(15)
          ),
          onPressed: (){},
          icon:Icon(Icons.favorite)
      ),
    ],),
    );
  }
}
