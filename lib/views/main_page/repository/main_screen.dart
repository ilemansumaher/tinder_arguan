
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:heart_overlay/heart_overlay.dart';
import 'package:lesson1/views/main_page/controller/controller.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  ControllerImage controller = ControllerImage();
  late HeartOverlayController heartOverlayController;

  final List<String> images = [
    "assets/images/1.jpg",
    "assets/images/girls.png",
    "assets/images/girls1.png",
    "assets/images/girls2.png",
  ];

  @override
  void initState() {
    super.initState();
    heartOverlayController = HeartOverlayController();
  }

  void likeHeart() {
    double iconSize = heartOverlayController.getSize() * 2;
    double height = heartOverlayController.getHeight() ?? MediaQuery.of(context).size.height;
    double width = heartOverlayController.getWidth() ?? MediaQuery.of(context).size.width;

    Offset offset = Offset(
      (Random().nextDouble() * width).clamp(iconSize, width - iconSize),
      (Random().nextDouble() * height).clamp(iconSize, height - iconSize - 100), // -100 for button padding
    );

    heartOverlayController.showIcon(offset: offset);

    // Changes to the emoji on the second click
    heartOverlayController.changeIcon(
      icon: const Text('👀'), // Optional custom emoji
      size: 200,
      horizontalOffset: 20,
      verticalOffset: 40,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 10),
            Image.asset("assets/images/logo.png", height: 30),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body:IndexedStack(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.grey[700],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '',
          ),
        ],
      ),
    );
  }

  
}


class MainScrenn extends StatefulWidget {
  const MainScrenn({super.key});

  @override
  State<MainScrenn> createState() => _MainScrennState();
}

class _MainScrennState extends State<MainScrenn> {
  ControllerImage controller = ControllerImage();
  late HeartOverlayController heartOverlayController;
  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GestureDetector(
                  onDoubleTap: () {
                    likeHeart();
                    controller.nextImage(); // Trigger heart animation on double-tap
                  },
                  child: Stack(
                    children: [
                      Observer(builder: (_) {
                        return AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          transitionBuilder: (widget, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: ScaleTransition(
                                scale: animation,
                                child: widget,
                              ),
                            );
                          },
                          child: Container(
                            key: ValueKey<int>(controller.imegIndex),
                            margin: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(images[controller.imegIndex]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }),
                      Center(
                        child: HeartOverlay(
                          controller: heartOverlayController,
                          duration: const Duration(seconds: 2),
                          tapDownType: TapDownType.single,
                          enableGestures: true,
                          cacheExtent: 30,
                          splashAnimationDetails: const SplashAnimationDetails(
                            enableSplash: true,
                            animationDuration: Duration(seconds: 1),
                          ),
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                            size: 100,
                          ),
                        ),
                      ),
                      // Left Arrow
                      Positioned(
                        left: 10,
                        top: 0,
                        bottom: 0,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: controller.prevImage, // Custom function
                        ),
                      ),
                      // Right Arrow
                      Positioned(
                        right: 10,
                        top: 0,
                        bottom: 0,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                          onPressed: () {
                            controller.nextImage(); // Change to next image
                            likeHeart(); // Trigger heart animation
                          },
                        ),
                      ),
                      // Profile Info
                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sophia, 24',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(Icons.info_outline, color: Colors.white),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'Recently active',
                                    style: TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              children: [
                                _buildInterestChip('Spotify'),
                                _buildInterestChip('Theatre'),
                                _buildInterestChip('Self-care'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(Icons.replay, Colors.yellow, () {}),
                _buildActionButton(Icons.close, Colors.red, () {}),
                _buildActionButton(Icons.star, Colors.blue, () {}),
                _buildActionButton(Icons.favorite, Colors.green, () {}),
                _buildActionButton(Icons.bolt, Colors.purple, () {}),
              ],
            ),
          ],
        ),
      )
      ;
  }

  Widget _buildInterestChip(String label) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.grey.withOpacity(0.5),
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget _buildActionButton(IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(15),
        backgroundColor: Colors.white,
      ),
      child: Icon(
        icon,
        color: color,
        size: 30,
      ),
    );
  }
}