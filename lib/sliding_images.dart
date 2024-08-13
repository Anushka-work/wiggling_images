import 'package:flutter/material.dart';

class SlidingImage extends StatelessWidget {
  final String imageUrl;
  final Duration duration;
  final VoidCallback onTap;

  const SlidingImage({
    Key? key,
    required this.imageUrl,
    required this.onTap,
    this.duration = const Duration(milliseconds: 600),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedSwitcher(
        duration: duration,
        transitionBuilder: (Widget child, Animation<double> animation) {
          final imageUrl = (child.key as ValueKey<String>).value;

          final combinedTween = TweenSequence<Offset>([
            TweenSequenceItem(
              tween: Tween<Offset>(
                begin: imageUrl == this.imageUrl
                    ? const Offset(-1, 0)
                    : const Offset(1, 0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeInOut)),
              weight: 2.0,
            ),
            TweenSequenceItem(
              tween: Tween<Offset>(
                begin: const Offset(-0.02, 0),
                end: const Offset(0.02, 0),
              ),
              weight: 1.0,
            ),
            TweenSequenceItem(
              tween: Tween<Offset>(
                begin: const Offset(0.02, 0),
                end: Offset.zero,
              ),
              weight: 1.0,
            ),
          ]);
          return SlideTransition(
            position: combinedTween.animate(animation),
            child: child,
          );
        },
        child: Image.network(
          imageUrl,
          key: ValueKey<String>(imageUrl),
        ),
      ),
    );
  }
}
