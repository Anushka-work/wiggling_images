import 'dart:math';
import 'package:animation1/likebutton.dart';
import 'package:animation1/sliding_images.dart';

import 'package:flutter/material.dart';
import 'favorites_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.Title});

  final String Title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _imageUrls = [
    'https://picsum.photos/200/300?random=1',
    'https://picsum.photos/200/300?random=2',
    'https://picsum.photos/200/300?random=3',
    'https://picsum.photos/200/300?random=4',
    'https://picsum.photos/200/300?random=5',
  ];
  final List<String> _favorites = [];

  String _currentImageUrl = 'https://picsum.photos/200/300?random=1';
  int _currentImageIndex = 0;
  int _page = 0;
  bool _isButtonVisible = true;

  void _changeImage() {
    setState(() {
      _currentImageUrl = _imageUrls[Random().nextInt(_imageUrls.length)];
    });
  }

  void _onWiggleComplete() {}

  void _addToFavorites() {
    if (!_favorites.contains(_currentImageUrl)) {
      setState(() {
        _favorites.add(_currentImageUrl);
      });
    }
  }

  void _showNextImage() {
    setState(() {
      _currentImageIndex = (_currentImageIndex + 1) % _imageUrls.length;
      _currentImageUrl = _imageUrls[_currentImageIndex];
    });
  }

  void _showPreviousImage() {
    setState(() {
      _currentImageIndex =
          (_currentImageIndex - 1 + _imageUrls.length) % _imageUrls.length;
      _currentImageUrl = _imageUrls[_currentImageIndex];
    });
  }

  void _navigateToFavorites() {
    setState(() {
      _isButtonVisible = false;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FavoritesPage(favorites: _favorites),
        ),
      ).then((_) {
        setState(() {
          _isButtonVisible = true;
        });
      });
    });
  }

  void _navigateToHeartButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LikeButton(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.Title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0x00DF6352),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favorites'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                _navigateToFavorites(); // Navigate to favorites
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            SlidingImage(
              imageUrl: _currentImageUrl,
              onTap: _showNextImage,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  opacity: _isButtonVisible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: LikeButton(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar:  CurvedNavigationBar(
        index: 0,
        height: 60.0,
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.favorite, size: 30),
          Icon(Icons.settings, size: 30),
        ],
        color: const Color.fromRGBO(255, 255, 255, 1),
        buttonBackgroundColor: Color(0x00DF6352),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
            _isButtonVisible = false;
          });
          Future.delayed(const Duration(milliseconds: 500), () {
            if (index == 1) {
              _navigateToFavorites();
            } else {
              setState(() {
                _isButtonVisible = true;
              });
            }
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
