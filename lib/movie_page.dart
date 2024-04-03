import 'dart:ui';
import 'package:flutter/material.dart';

////This way is kinda heavy on performance so try to rework it like the other file

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final scrollController = ScrollController();
  bool isCollapsed = false;
  @override
  Widget build(BuildContext context) {
    const collapsedBarHeight = 60.0;
    const expandedBarHeight = 400.0;
    return Stack(
      children: [
        SizedBox(
          height: double.maxFinite,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Image.network(
              "https://m.media-amazon.com/images/I/71eHZFw+GlL._AC_UF894,1000_QL80_.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        NotificationListener(
          onNotification: (notification) {
            final bool isScrolled = scrollController.hasClients &&
                scrollController.offset >
                    (expandedBarHeight -
                        collapsedBarHeight); // Change this threshold as needed
            if (isScrolled != isCollapsed) {
              setState(() {
                isCollapsed = isScrolled;
              });
            }
            return true;
          },
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: expandedBarHeight,
                collapsedHeight: collapsedBarHeight,
                centerTitle: false,
                pinned: true,
                title: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isCollapsed ? 1 : 0,
                  child: ListTile(
                    title: const Text(
                      'Avengers: Infinity War',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Image.network(
                      "https://logos-world.net/wp-content/uploads/2021/11/Warner-Brothers-Logo.png",
                      width: 70,
                    ),
                  ),
                ),
                elevation: 0,
                backgroundColor:
                    isCollapsed ? Colors.black : Colors.transparent,
                leading: const BackButton(
                  color: Colors.white,
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: kToolbarHeight + 50),
                        width: 150,
                        height: 230,
                        child: Image.network(
                          "https://m.media-amazon.com/images/I/71eHZFw+GlL._AC_UF894,1000_QL80_.jpg",
                          //fit: BoxFit.cover,
                        ),
                      ),
                      const Text(
                        'Avengers: Infinity War',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const Text(
                        'Fight for Humanity',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Material(
                    child: ListTile(
                      title: Text(
                        'item $index',
                      ),
                    ),
                  );
                }, childCount: 20),
              ),
            ],
          ),
        )
      ],
    );
  }
}
