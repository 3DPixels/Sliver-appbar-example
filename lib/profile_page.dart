import 'dart:math';

import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 7, 3, 52),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              delegate: WhatsappAppbar(MediaQuery.of(context).size.width),
              //delegate: SliverPersistentDelegete(),
              pinned: true,
            ),
            // SliverAppBar(
            //   backgroundColor: Color.fromARGB(255, 65, 62, 62),
            //   leading: Icon(
            //     Icons.menu,
            //     color: Colors.white,
            //   ),
            //   expandedHeight: 200,
            //   stretch: true,
            //   pinned: true,
            //   floating: true,
            //   flexibleSpace: FlexibleSpaceBar(
            //     title: Text('Hello, Ammar Ahmad'),
            //     background: Image.network(
            //       "https://st4.depositphotos.com/1741969/29457/i/450/depositphotos_294571810-stock-photo-blackground-of-abstract-glitter-lights.jpg",
            //       fit: BoxFit.cover,
            //     ),
            //     stretchModes: [
            //       StretchMode.fadeTitle,
            //       StretchMode.zoomBackground,
            //     ],
            //   ),
            // ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return ListTile(
                  title: Text(
                    'item $index',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }, childCount: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class WhatsappAppbar extends SliverPersistentHeaderDelegate {
  double screenWidth;
  Tween<double>? profilePicTranslateTween;

  WhatsappAppbar(this.screenWidth) {
    profilePicTranslateTween =
        Tween<double>(begin: screenWidth / 2 - 45 - 40 + 15, end: 40.0);
  }
  static final appBarColorTween = ColorTween(
      begin: Colors.white, end: const Color.fromARGB(255, 4, 94, 84));

  static final appbarIconColorTween =
      ColorTween(begin: Colors.grey[800], end: Colors.white);

  static final phoneNumberTranslateTween = Tween<double>(begin: 20.0, end: 0.0);

  static final phoneNumberFontSizeTween = Tween<double>(begin: 20.0, end: 16.0);

  static final profileImageRadiusTween = Tween<double>(begin: 3.5, end: 1.0);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final relativeScroll = min(shrinkOffset, 45) / 45;
    final relativeScroll70px = min(shrinkOffset, 70) / 70;

    return Container(
      color: appBarColorTween.transform(relativeScroll),
      child: Stack(
        children: [
          Stack(
            children: [
              Positioned(
                left: 0,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back, size: 25),
                  color: appbarIconColorTween.transform(relativeScroll),
                ),
              ),
              Positioned(
                right: 0,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert, size: 25),
                  color: appbarIconColorTween.transform(relativeScroll),
                ),
              ),
              Positioned(
                  top: 15,
                  left: 90,
                  child: displayPhoneNumber(relativeScroll70px)),
              Positioned(
                  top: 5,
                  left: profilePicTranslateTween!.transform(relativeScroll70px),
                  child: displayProfilePicture(relativeScroll70px)),
            ],
          ),
        ],
      ),
    );
  }

  Widget displayProfilePicture(double relativeFullScrollOffset) {
    return Transform(
      transform: Matrix4.identity()
        ..scale(
          profileImageRadiusTween.transform(relativeFullScrollOffset),
        ),
      child: const CircleAvatar(
        backgroundImage: NetworkImage(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEgzwHNJhsADqquO7m7NFcXLbZdFZ2gM73x8I82vhyhg&s"),
      ),
    );
  }

  Widget displayPhoneNumber(double relativeFullScrollOffset) {
    if (relativeFullScrollOffset >= 0.8) {
      return Transform(
        transform: Matrix4.identity()
          ..translate(
            0.0,
            phoneNumberTranslateTween
                .transform((relativeFullScrollOffset - 0.8) * 5),
          ),
        child: Text(
          "+3 3333333333",
          style: TextStyle(
            fontSize: phoneNumberFontSizeTween
                .transform((relativeFullScrollOffset - 0.8) * 5),
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  @override
  double get maxExtent => 160;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(WhatsappAppbar oldDelegate) {
    return true;
  }
}

class SliverPersistentDelegete extends SliverPersistentHeaderDelegate {
  final double maxHeaderHeight = 200; //max height to stretch [maxExtent]
  final double minHeaderHeight =
      kToolbarHeight; //min height to shrink [minExtent]
  final double maxImageSize = 140;
  final double minImageSize = 40;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent =
        shrinkOffset / maxHeaderHeight; //used to determine scroll position

    final currentImageSize =
        (maxImageSize * (1 - percent)).clamp(minImageSize, maxImageSize);
    final currentImagePosition =
        ((375 / 2 - 65) * (1 - percent)).clamp(minImageSize, maxImageSize);
    return Container(
      color: Colors.white,
      child: Container(
        color: Colors.red.withOpacity(percent * 2 < 1 ? percent * 2 : 1),
        child: Stack(
          children: [
            Positioned(
                top: MediaQuery.of(context).viewPadding.top + 17,
                left: currentImagePosition + 50,
                child: Text(
                  'Ammar Ahmad',
                  style: TextStyle(
                      fontSize: 20, color: Colors.white.withOpacity(percent)),
                )),
            Positioned(
                top: MediaQuery.of(context).viewPadding.top + 5,
                left: 0,
                child: BackButton(
                  color:
                      percent > 0.3 ? Colors.white.withOpacity(percent) : null,
                )),
            Positioned(
                top: MediaQuery.of(context).viewPadding.top + 5,
                right: 0,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                  color: percent > 0.3
                      ? Colors.white.withOpacity(percent)
                      : Theme.of(context).textTheme.bodyMedium!.color,
                )),
            Positioned(
                left: currentImagePosition,
                top: MediaQuery.of(context).viewPadding.top + 5,
                bottom: 0,
                child: Hero(
                  tag: "profile",
                  child: SizedBox(
                    width: currentImageSize,
                    child: const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEgzwHNJhsADqquO7m7NFcXLbZdFZ2gM73x8I82vhyhg&s"),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => maxHeaderHeight;

  @override
  double get minExtent => minHeaderHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
