import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todos/service/db.dart';

class ListTodo extends StatelessWidget {
  ListTodo({super.key});

  final ListTodoController c = Get.put(ListTodoController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          child: const Text(
            'Danh sách công việc',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Obx(
            () => ListView(
              children: c.list
                  .map(
                    (item) => Container(
                      padding: EdgeInsets.all(6),
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.lightBlue.withOpacity(0.05),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("Kiếm tiền nuối sống bản thân"),
                                  SizedBox(height: 4),
                                  Text(
                                    "Còn 5h3p /  3h30",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_right_sharp,
                                size: 24,
                              ),
                            )
                          ]),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class ListTodoController extends GetxController {
  final tabActive = 'list'.obs;
  final list = <Todo>[].obs;

  @override
  void onReady() {
    list.add(Todo.fromMap({
      '_id': 1,
      'title': 'title 1',
      'done': 0,
    }));
    list.add(Todo.fromMap({
      '_id': 1,
      'title': 'title 2',
      'done': 0,
    }));
    list.add(Todo.fromMap({
      '_id': 1,
      'title': 'title 3',
      'done': 1,
    }));
    list.add(Todo.fromMap({
      '_id': 1,
      'title': 'title 4',
      'done': 1,
    }));
    list.refresh();

    print(list);
    super.onReady();
  }
}
