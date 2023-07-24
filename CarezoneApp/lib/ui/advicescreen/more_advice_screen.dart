import 'package:carezone/ui/resourses/styles_manager.dart';
import 'package:carezone/ui/resourses/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:carezone/models/advice.dart';
import 'package:carezone/ui/advicescreen/moreadvicescreendetails.dart';
import 'package:get/get.dart';
import '../resourses/Color_manager.dart';

class MoreAdvice extends StatelessWidget {
  const MoreAdvice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              size: 26,
              color: ColorManager.black,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.grey[100],
        ),
        body: Container(
          color: Colors.grey[100],
          child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: moreadvice.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 4 / 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15),
              itemBuilder: ((context, ind) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GridTile(
                        footer: GridTileBar(
                          backgroundColor: Colors.white,
                          title: Text(
                            moreadvice[ind]['Title'].toString(),
                            textAlign: TextAlign.center,
                            style: getRegularStyle(
                                color: Colors.black, fontSize: AppSize.s14),
                          ),
                        ),
                        child: GestureDetector(
                            child: Image.asset(
                              moreadvice[ind]['Image'].toString(),
                              fit: BoxFit.cover,
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) =>
                                      MoreAdviceScreenDetails(x: ind))));
                            })),
                  ))),
        ));
  }
}
