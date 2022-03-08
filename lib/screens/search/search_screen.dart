import 'package:comic_app/controllers/comic_controller/comic_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../main.dart';
import '../../../themes.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    ComicController comicController = Get.find();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return WillPopScope(
      onWillPop: (() async {
        return true;
      }),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                TextField(
                  controller: textEditingController,
                  onChanged: (value) {
                    comicController.findByName(value.toLowerCase());
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Tìm kiếm',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                GetBuilder<ComicController>(builder: ((controller) {
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: comicController.chapSearch.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed(Routes.detail,
                                arguments: controller.chapSearch[index].id);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: SizedBox(
                                    height: 200,
                                    width: 120,
                                    child: Image.network(
                                      comicController
                                          .chapSearch[index].imageURL,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comicController.chapSearch[index].name,
                                    style: Mytheme.textLogin.copyWith(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  Text(
                                    'Chap mới nhất ${comicController.chapSearch[index].chaps.length + 1}',
                                    style: Mytheme.textLogin
                                        .copyWith(color: Colors.grey),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      });
                }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
