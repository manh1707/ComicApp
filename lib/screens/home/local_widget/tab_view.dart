import 'dart:async';
import 'package:comic_app/main.dart';
import 'package:comic_app/models/comic_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/comic_controller/comic_controller.dart';

class TabView extends StatefulWidget {
  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  final ComicController controller = Get.find();

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
      if (_pageController.hasClients) {
        _pageController.animateToPage(_currentPage,
            duration: const Duration(milliseconds: 700), curve: Curves.easeIn);
      }
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
    List<ComicModel> list = controller.comicList;
    return SizedBox(
      height: 200,
      child: Stack(alignment: Alignment.bottomCenter, children: [
        Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: PageView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.toNamed(Routes.detail, arguments: list[index].id);
                },
                child: Image.network(
                  list[index].hotImage.toString(),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  filterQuality: FilterQuality.low,
                  fit: BoxFit.cover,
                ),
              );
            },
            itemCount: controller.comicList.length,
            controller: _pageController,
            onPageChanged: _onPageChange,
          ),
        ),
        Positioned(
          bottom: 10,
          child: Stack(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < controller.comicList.length; i++)
                    if (i == _currentPage)
                      SlideDots(isActive: true)
                    else
                      SlideDots(isActive: false)
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}

class SlideDots extends StatelessWidget {
  bool isActive;
  SlideDots({Key? key, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: isActive ? 8 : 6,
      width: isActive ? 8 : 6,
      decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
    );
  }
}
