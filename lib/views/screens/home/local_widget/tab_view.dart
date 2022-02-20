import 'dart:async';
import 'package:comic_app/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/root_controller/root_controller.dart';

class TabView extends StatefulWidget {
  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  final RootController controller = Get.find();

  final PageController _pageController = PageController(initialPage: 0);

  int _currentPage = 0;
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < controller.comicList.length) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients)
        _pageController.animateToPage(_currentPage,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    });
    super.initState();
  }

  void _onPageChange(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: Container(
            height: 200,
            child: Stack(alignment: Alignment.bottomCenter, children: [
              PageView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.detail,
                            arguments: controller.comicList.value[index].id);
                      },
                      child: Image.network(
                        controller.comicList.value[index].imageURL.toString(),
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
                itemCount: controller.comicList.length,
                controller: _pageController,
                onPageChanged: _onPageChange,
              ),
              Stack(
                children: [
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < controller.comicList.length; i++)
                          if (i == _currentPage)
                            SlideDots(isActive: true)
                          else
                            SlideDots(isActive: false)
                      ],
                    ),
                  )
                ],
              )
            ]),
          ),
        ),
      ],
    );
  }
}

class SlideDots extends StatelessWidget {
  bool isActive;
  SlideDots({Key? key, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: isActive ? 8 : 6,
      width: isActive ? 8 : 6,
      decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(15))),
    );
  }
}
