import 'package:flutter/material.dart';

class PageViewController {
  final BuildContext _context;
  final PageController _pageController;

  static const _firstPage = 0;
  static const _animationDuration = Duration(milliseconds: 400);

  PageViewController(BuildContext context, {PageController? pageController})
      : _context = context,
        _pageController = pageController ?? PageController();

  PageController get get => _pageController;

  Future<void> nextPage() => _pageController.nextPage(duration: _animationDuration, curve: Curves.easeIn);
  void jumpToPage(int index) => _pageController.animateToPage(index, duration: _animationDuration, curve: Curves.easeIn);

  Future<bool> previousPage() {
    if (_pageController.page!.round() == _firstPage) {
      Navigator.pop(_context);
      return Future.value(false);
    }

    return _pageController
        .previousPage(
          duration: _animationDuration,
          curve: Curves.linear,
        )
        .then((_) => false);
  }

  void dispose() => _pageController.dispose();
}
