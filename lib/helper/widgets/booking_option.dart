import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../size/size.dart';
import '../textstyle.dart';

class MyRadioButton<T> extends StatelessWidget {
  final T value;
  final T gruopValue;
  final ValueChanged<T?> onchanged;
  final String title;

  const MyRadioButton({
    Key? key,
    required this.value,
    required this.gruopValue,
    required this.onchanged,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            onchanged(value);
          },
          child: ChoiceCard(
            groupvalue: gruopValue,
            value: value,
          ),
        ),
        Ksize.ksize10,
        Text(
          title,
          style: Tstyles.greycolor,
        ),
      ],
    );
  }
}

class ChoiceCard<T> extends StatelessWidget {
  const ChoiceCard({
    super.key,
    required this.value,
    required this.groupvalue,
  });

  final T value;
  final T groupvalue;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupvalue;
    return Stack(
      children: [
        Positioned(
          left: 10,
          top: 5,
          child: CircleAvatar(
            backgroundColor: isSelected ? const Color(0xffFF7373) : Colors.grey,
            radius: 7,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 5,
              child: CircleAvatar(
                  radius: 3,
                  backgroundColor:
                      isSelected ? const Color(0xffFF7373) : Colors.grey),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: isSelected
                  ? const Color.fromARGB(255, 255, 115, 115).withOpacity(.3)
                  : Colors.grey.withOpacity(.4),
              borderRadius: BorderRadius.circular(10)),
          height: 90,
          width: 100,
          child: Center(
            child: Column(
              children: [
                Ksize.ksize40,
                isSelected
                    ? Center(
                      child: SvgPicture.asset(
                          "assets/svg_images/driver.svg",
                          width: 50,
                          height: 50,
                        ),
                    )
                    // Image.asset(
                    //         'assets/rcar (2).png',
                    //         width: 50,
                    //         height: 50,
                    //         color: Colors.red,
                    //       )
                    : SvgPicture.asset(
                  "assets/svg_images/driver.svg",
                  width: 50,
                  height: 50,
                  color: Colors.grey.shade600,

                )

                // Image.asset(
                //         'assets/bcar (2).png',
                //         width: 50,
                //         height: 50,
                //         color: Colors.grey.shade600,
                //       )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
