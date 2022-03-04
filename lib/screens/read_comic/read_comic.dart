import 'package:comic_app/controllers/comic_controller/comic_controller.dart';
import 'package:comic_app/models/chap_model.dart';
import 'package:comic_app/models/comic_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../main.dart';

class ReadComicScreen extends StatelessWidget {
  ReadComicScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ComicController comicController = Get.find();
    ComicModel comicModel = Get.arguments[0] as ComicModel;
    int thisChap = Get.arguments[1];
    List<ChapModel> listOfChap = comicModel.chaps;
    List<String> listOfImage = listOfChap[thisChap].chapImageUrl;
    // List<String> testImage = [
    //   'https://scontent.fhan4-1.fna.fbcdn.net/v/t39.30808-6/274700384_2896314410670734_8154252313299930255_n.jpg?_nc_cat=1&ccb=1-5&_nc_sid=8bfeb9&_nc_ohc=YbzJQrPA6fQAX8JBP1e&_nc_oc=AQnevM3wa2ndIT-FHIeVw7RZ1IbYyOU29e2ktPzex_DxDQZ4vfuecvq9VMp4hhx0KVA5KVSLQE_zNXxhcFglr9HG&_nc_ht=scontent.fhan4-1.fna&oh=00_AT-HUl4hWyfeULad4ggJJam05S7JWeNNmy0pgaR-kM2dlA&oe=62227BAE',
    //   'https://scontent.fhan4-1.fna.fbcdn.net/v/t39.30808-6/275003445_3170091666599915_7266122069421632968_n.jpg?_nc_cat=1&ccb=1-5&_nc_sid=5cd70e&_nc_ohc=QZkvNPBsbVAAX_c7amm&_nc_ht=scontent.fhan4-1.fna&oh=00_AT8D5mytgPDQtWYp8VSctKOkMk7xdk7HxIyhW36yZRSYaQ&oe=62234919',
    //   'https://scontent.fhan4-2.fna.fbcdn.net/v/t39.30808-6/274673193_10221089183916029_223966003325358953_n.jpg?_nc_cat=111&ccb=1-5&_nc_sid=5cd70e&_nc_ohc=-AY3SUX6-P8AX_TkqHE&_nc_ht=scontent.fhan4-2.fna&oh=00_AT8P-h9WAauUMDKa5NOCvZb1RLR3BoSXQPEeVlAkBfQ6zA&oe=622211A1',
    //   'https://scontent.fhan4-2.fna.fbcdn.net/v/t39.30808-6/274673193_10221089183916029_223966003325358953_n.jpg?_nc_cat=111&ccb=1-5&_nc_sid=5cd70e&_nc_ohc=-AY3SUX6-P8AX_TkqHE&_nc_ht=scontent.fhan4-2.fna&oh=00_AT8P-h9WAauUMDKa5NOCvZb1RLR3BoSXQPEeVlAkBfQ6zA&oe=622211A1',
    //   'https://scontent.fhan4-2.fna.fbcdn.net/v/t39.30808-6/274673193_10221089183916029_223966003325358953_n.jpg?_nc_cat=111&ccb=1-5&_nc_sid=5cd70e&_nc_ohc=-AY3SUX6-P8AX_TkqHE&_nc_ht=scontent.fhan4-2.fna&oh=00_AT8P-h9WAauUMDKa5NOCvZb1RLR3BoSXQPEeVlAkBfQ6zA&oe=622211A1',
    //   'https://scontent.fhan4-2.fna.fbcdn.net/v/t39.30808-6/274673193_10221089183916029_223966003325358953_n.jpg?_nc_cat=111&ccb=1-5&_nc_sid=5cd70e&_nc_ohc=-AY3SUX6-P8AX_TkqHE&_nc_ht=scontent.fhan4-2.fna&oh=00_AT8P-h9WAauUMDKa5NOCvZb1RLR3BoSXQPEeVlAkBfQ6zA&oe=622211A1',
    //   'https://scontent.fhan3-3.fna.fbcdn.net/v/t39.30808-6/274727762_10221089192356240_1554893136146006562_n.jpg?_nc_cat=108&ccb=1-5&_nc_sid=5cd70e&_nc_ohc=0RL0FwmW4bgAX8-UnRd&_nc_ht=scontent.fhan3-3.fna&oh=00_AT8PG_5wKKE0d14SOyaFW1agysG5t61G94V9T1usWkut0Q&oe=62223502',
    //   'https://scontent.fhan3-3.fna.fbcdn.net/v/t39.30808-6/274727762_10221089192356240_1554893136146006562_n.jpg?_nc_cat=108&ccb=1-5&_nc_sid=5cd70e&_nc_ohc=0RL0FwmW4bgAX8-UnRd&_nc_ht=scontent.fhan3-3.fna&oh=00_AT8PG_5wKKE0d14SOyaFW1agysG5t61G94V9T1usWkut0Q&oe=62223502',
    //   'https://scontent.fhan3-3.fna.fbcdn.net/v/t39.30808-6/274727762_10221089192356240_1554893136146006562_n.jpg?_nc_cat=108&ccb=1-5&_nc_sid=5cd70e&_nc_ohc=0RL0FwmW4bgAX8-UnRd&_nc_ht=scontent.fhan3-3.fna&oh=00_AT8PG_5wKKE0d14SOyaFW1agysG5t61G94V9T1usWkut0Q&oe=62223502',
    //   'https://scontent.fhan3-3.fna.fbcdn.net/v/t39.30808-6/274727762_10221089192356240_1554893136146006562_n.jpg?_nc_cat=108&ccb=1-5&_nc_sid=5cd70e&_nc_ohc=0RL0FwmW4bgAX8-UnRd&_nc_ht=scontent.fhan3-3.fna&oh=00_AT8PG_5wKKE0d14SOyaFW1agysG5t61G94V9T1usWkut0Q&oe=62223502',
    //   'https://scontent.fhan3-2.fna.fbcdn.net/v/t39.30808-6/274808185_10221089192876253_8127173035671175665_n.jpg?_nc_cat=107&ccb=1-5&_nc_sid=5cd70e&_nc_ohc=eBU4cNV4gNYAX8B3Pno&_nc_ht=scontent.fhan3-2.fna&oh=00_AT-nN2NcEXACuROKaFOhjF3-sF-GvxI0OEVvKYOCHyufRw&oe=6223133F',
    //   'https://scontent.fhan3-2.fna.fbcdn.net/v/t39.30808-6/274808185_10221089192876253_8127173035671175665_n.jpg?_nc_cat=107&ccb=1-5&_nc_sid=5cd70e&_nc_ohc=eBU4cNV4gNYAX8B3Pno&_nc_ht=scontent.fhan3-2.fna&oh=00_AT-nN2NcEXACuROKaFOhjF3-sF-GvxI0OEVvKYOCHyufRw&oe=6223133F',
    //   'https://scontent.fhan3-2.fna.fbcdn.net/v/t39.30808-6/274808185_10221089192876253_8127173035671175665_n.jpg?_nc_cat=107&ccb=1-5&_nc_sid=5cd70e&_nc_ohc=eBU4cNV4gNYAX8B3Pno&_nc_ht=scontent.fhan3-2.fna&oh=00_AT-nN2NcEXACuROKaFOhjF3-sF-GvxI0OEVvKYOCHyufRw&oe=6223133F',
    //   'https://scontent.fhan3-5.fna.fbcdn.net/v/t39.30808-6/274657776_10221089193276263_5142684814302062970_n.jpg?_nc_cat=109&ccb=1-5&_nc_sid=5cd70e&_nc_ohc=4n2F3P3SFYwAX8ll_-T&tn=Z2sltfH5ZjBRjBWV&_nc_ht=scontent.fhan3-5.fna&oh=00_AT8ttkz2cqYUhng2pf_FY4PMGI4jLCm9bGQQYh1jqIKcqQ&oe=62220F2C',
    //   'https://scontent.fhan3-5.fna.fbcdn.net/v/t39.30808-6/274657776_10221089193276263_5142684814302062970_n.jpg?_nc_cat=109&ccb=1-5&_nc_sid=5cd70e&_nc_ohc=4n2F3P3SFYwAX8ll_-T&tn=Z2sltfH5ZjBRjBWV&_nc_ht=scontent.fhan3-5.fna&oh=00_AT8ttkz2cqYUhng2pf_FY4PMGI4jLCm9bGQQYh1jqIKcqQ&oe=62220F2C',
    //   'https://scontent.fhan3-5.fna.fbcdn.net/v/t39.30808-6/274657776_10221089193276263_5142684814302062970_n.jpg?_nc_cat=109&ccb=1-5&_nc_sid=5cd70e&_nc_ohc=4n2F3P3SFYwAX8ll_-T&tn=Z2sltfH5ZjBRjBWV&_nc_ht=scontent.fhan3-5.fna&oh=00_AT8ttkz2cqYUhng2pf_FY4PMGI4jLCm9bGQQYh1jqIKcqQ&oe=62220F2C',
    //   'https://scontent.fhan4-3.fna.fbcdn.net/v/t39.30808-6/274481621_10221089193716274_6232700048866856792_n.jpg?_nc_cat=103&ccb=1-5&_nc_sid=5cd70e&_nc_ohc=y9QKylVvjY0AX-2zfUx&_nc_ht=scontent.fhan4-3.fna&oh=00_AT_AVr4UByfanYioPrQi44yHoogbkqE5eZYD6NpqPTHp7g&oe=622277A4',
    //   'https://scontent.fhan4-3.fna.fbcdn.net/v/t39.30808-6/274481621_10221089193716274_6232700048866856792_n.jpg?_nc_cat=103&ccb=1-5&_nc_sid=5cd70e&_nc_ohc=y9QKylVvjY0AX-2zfUx&_nc_ht=scontent.fhan4-3.fna&oh=00_AT_AVr4UByfanYioPrQi44yHoogbkqE5eZYD6NpqPTHp7g&oe=622277A4',
    //   'https://scontent.fhan4-3.fna.fbcdn.net/v/t39.30808-6/274481621_10221089193716274_6232700048866856792_n.jpg?_nc_cat=103&ccb=1-5&_nc_sid=5cd70e&_nc_ohc=y9QKylVvjY0AX-2zfUx&_nc_ht=scontent.fhan4-3.fna&oh=00_AT_AVr4UByfanYioPrQi44yHoogbkqE5eZYD6NpqPTHp7g&oe=622277A4',
    //   'https://scontent.fhan4-3.fna.fbcdn.net/v/t39.30808-6/274481621_10221089193716274_6232700048866856792_n.jpg?_nc_cat=103&ccb=1-5&_nc_sid=5cd70e&_nc_ohc=y9QKylVvjY0AX-2zfUx&_nc_ht=scontent.fhan4-3.fna&oh=00_AT_AVr4UByfanYioPrQi44yHoogbkqE5eZYD6NpqPTHp7g&oe=622277A4'
    // ];
    List<String> chapTitle = [];
    listOfChap.forEach(((element) {
      chapTitle.add(element.title.toString());
    }));
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listOfImage.length,
              itemBuilder: (context, index) {
                // return FadeInImage.memoryNetwork(
                //     placeholder: kTransparentImage, image: listOfImage[index]);
                return Image.network(
                  listOfImage[index],
                  fit: BoxFit.cover,
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
                );
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (thisChap == 0)
                  ? const SizedBox(
                      width: 30,
                    )
                  : ElevatedButton(
                      child: const Icon(Icons.arrow_back),
                      onPressed: () {
                        comicController.addToHistory(
                            comicModel, (thisChap - 1));
                        comicController.updateChapView(
                            comicModel, (thisChap - 1));
                        Get.offAndToNamed(Routes.read,
                            arguments: [comicModel, (thisChap - 1)]);
                      },
                    ),
              const SizedBox(
                width: 15,
              ),
              DropdownButton<String>(
                items: chapTitle.map((item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                onChanged: (value) {
                  comicController.addToHistory(
                      comicModel, chapTitle.indexOf(value!));
                  comicController.updateChapView(
                      comicModel, chapTitle.indexOf(value));
                  Get.offAndToNamed(Routes.read,
                      arguments: [comicModel, chapTitle.indexOf(value)]);
                },
                value: chapTitle[thisChap],
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  if (thisChap == comicModel.chaps.length - 1) {
                    Get.snackbar('Thông báo ', 'Không còn chương mới',
                        colorText: Colors.red);
                  } else {
                    comicController.addToHistory(comicModel, (thisChap + 1));
                    comicController.updateChapView(comicModel, (thisChap + 1));
                    Get.offAndToNamed(Routes.read,
                        arguments: [comicModel, (thisChap + 1)]);
                  }
                },
                child: const Icon(Icons.arrow_forward),
              )
            ],
          )
        ],
      ),
    ));
  }
}
