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
            () => ListView(children: [
              ...c.list
                  .map(
                    (item) => Container(
                      padding: const EdgeInsets.all(6),
                      margin: const EdgeInsets.all(4),
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
                                children: [
                                  const Text("Kiếm tiền nuối sống bản thân"),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          "Còn 5h3p /  3h30",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.green),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: const Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            'Đánh dấu đã xong',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.green,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),

                            // IconButton(
                            //   onPressed: () {},
                            //   icon: const Icon(
                            //     Icons.arrow_right_sharp,
                            //     size: 24,
                            //   ),
                            // )
                          ]),
                    ),
                  )
                  .toList(),
              CreateButton(),
              const SizedBox(height: 50),
            ]),
          ),
        ),
      ],
    );
  }
}

class CreateButton extends StatelessWidget {
  ListTodoController c = Get.find();

  CreateButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.lightBlue.withOpacity(0.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tạo mới',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nội dung công việc',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mô tả công việc',
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        textAlign: TextAlign.end,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Thời gian (phút)',
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: TextFormField(
                        textAlign: TextAlign.end,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Bắt đầu',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          IconButton(
            onPressed: () {
              c.save();
            },
            icon: const Icon(
              Icons.save_rounded,
              size: 24,
              color: Colors.lightBlue,
            ),
          )
        ],
      ),
    );
  }
}

class ListTodoController extends GetxController {
  final tabActive = 'list'.obs;
  final list = <Todo>[].obs;

  final newTodo = Rx(Todo.fromMap({'title': 'Làm:'}));

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
    list.add(Todo.fromMap({
      '_id': 1,
      'title': 'title 4',
      'done': 1,
    }));
    list.add(Todo.fromMap({
      '_id': 1,
      'title': 'title 4',
      'done': 1,
    }));
    list.add(Todo.fromMap({
      '_id': 1,
      'title': 'title 4',
      'done': 1,
    }));
    list.add(Todo.fromMap({
      '_id': 1,
      'title': 'title 4',
      'done': 1,
    }));

    list.refresh();

    super.onReady();
  }

  save() {
    print(newTodo);
  }
}
