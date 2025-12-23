import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  final Function(int)  onCharge;
  final int currentSlider;
  const ImageSlider({super.key,required this.currentSlider,required this.onCharge});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        height: 220,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: PageView(
            scrollDirection: Axis.horizontal,
            allowImplicitScrolling: true,
            onPageChanged: onCharge,
            physics:const ClampingScrollPhysics(),
            children: [
              Image.asset(
                "images/240_F_883507704_EyCl2SH5NDRG9kDOob9QhbaJ3afr46qu.jpg",
                fit: BoxFit.cover,
              ),
              Image.asset(
                "images/240_F_1568471751_NiDBRVwPaF90ZGpJ4xvweYVoDfEjhImY.jpg",
                fit: BoxFit.cover,
              ),
              Image.asset(
                "images/1000_F_1537223297_KJcAUes9mZU1KtWRFV8g3H7iPmEqWQXE.webp",
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
      Positioned.fill(
        bottom: 10,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              5,
                  (index)=> AnimatedContainer(
                    duration:const Duration(microseconds: 300),
                    width: currentSlider == index? 15:0 ,
                    height: 8,
                    margin: EdgeInsets.only(right: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                    color: currentSlider ==index
                        ? Colors.black
                        :Colors.transparent,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                  ),
          ),
          ),
        ),
      )
    ],
    );
  }
}
