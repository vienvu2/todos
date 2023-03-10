import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todos/screen/config.dart';
import 'package:todos/screen/list.dart';
import 'package:todos/screen/profile.dart';
import 'package:todos/screen/report.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final MainController c = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (c.tabActive.value == 'list') {
            return ListTodo();
          }
          if (c.tabActive.value == 'report') {
            return Report();
          }
          if (c.tabActive.value == 'config') {
            return Config();
          }
          if (c.tabActive.value == 'profile') {
            return Profile();
          }
          return Text(c.tabActive.value);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Obx(
          () => Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: c.tabActive.value == 'list'
                    ? const Icon(
                        Icons.account_tree,
                        color: Colors.lightBlue,
                      )
                    : const Icon(
                        Icons.account_tree_outlined,
                        color: Colors.black38,
                      ),
                onPressed: () {
                  c.tabActive.value = 'list';
                },
              ),
              IconButton(
                icon: c.tabActive.value == 'report'
                    ? const Icon(
                        Icons.pie_chart,
                        color: Colors.lightBlue,
                      )
                    : const Icon(
                        Icons.pie_chart_outline,
                        color: Colors.black38,
                      ),
                onPressed: () {
                  c.tabActive.value = 'report';
                },
              ),
              const SizedBox(width: 50, height: 50),
              IconButton(
                icon: c.tabActive.value == 'config'
                    ? const Icon(
                        Icons.settings,
                        color: Colors.lightBlue,
                      )
                    : const Icon(
                        Icons.settings_outlined,
                        color: Colors.black38,
                      ),
                onPressed: () {
                  c.tabActive.value = 'config';
                },
              ),
              IconButton(
                icon: c.tabActive.value == 'profile'
                    ? const Icon(
                        Icons.face,
                        color: Colors.lightBlue,
                      )
                    : const Icon(
                        Icons.face_outlined,
                        color: Colors.black38,
                      ),
                onPressed: () {
                  c.tabActive.value = 'profile';
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainController extends GetxController {
  final tabActive = 'list'.obs;
}
