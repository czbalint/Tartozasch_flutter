import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutterhf/UI/DetailsView/Member/avatar.dart';
import 'package:flutterhf/UI/DetailsView/Member/member.dart';
import 'package:flutterhf/UI/GroupView/group.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MemberCarousel extends StatefulWidget {
  const MemberCarousel({Key? key, required this.group, required this.onChange}) : super(key: key);

  final Group group;
  final ValueChanged<Member> onChange;

  @override
  State<MemberCarousel> createState() => _MemberCarouselState();
}

class _MemberCarouselState extends State<MemberCarousel> {
  var activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 160,
              viewportFraction: 0.5,
              onPageChanged: (index, reason) {
                setState(() {
                  activeIndex = index;
                });
                widget.onChange(widget.group.members[index]);
              },
              enlargeCenterPage: true
          ),
          items: widget.group.members.map((member) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 90,
                  width: 80,
                  child: MemberAvatar(
                    svgCode: member.avatar!,
                    size: const Size(80, 80),
                  ),
                ),
                Text(
                    member.name,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    )
                )
              ],
            );
          }).toList(),
        ),
        AnimatedSmoothIndicator(
            activeIndex: activeIndex,
            count: widget.group.members.length,
            effect: ScrollingDotsEffect(
              fixedCenter: true,
              dotHeight: 15,
              dotWidth: 15,
              activeDotColor: Theme.of(context).primaryColor,
            ),
        )
      ],
    );
  }
}
