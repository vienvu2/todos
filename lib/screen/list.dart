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
              if (!c.isAdd.value) CreateButton(),
              if (c.isAdd.value) CreateForm(),
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
                                  Text(item.title),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Còn 5h3p /  ${item.time}",
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
                          ]),
                    ),
                  )
                  .toList(),
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
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        c.isAdd.value = true;
      },
      child: Container(
        padding: EdgeInsets.all(12),
        alignment: Alignment.center,
        child: Text('Thêm mới',
            style: TextStyle(
              fontSize: 12,
              color: Colors.lightBlue,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}

class CreateForm extends StatelessWidget {
  ListTodoController c = Get.find();

  CreateForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(6),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.lightBlue.withOpacity(0.2),
        ),
        child: Column(
          children: [
            Row(children: [
              Expanded(
                child: Text(
                  'Thêm mới',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  c.isAdd.value = false;
                },
                child: Text(
                  'Đóng',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nội dung công việc',
                        ),
                        initialValue: c.newTodo.value.title,
                        onChanged: (e) {
                          c.newTodo.value.title = e;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        minLines: 4,
                        maxLines: null,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Mô tả công việc',
                          alignLabelWithHint: true,
                        ),
                        initialValue: c.newTodo.value.description,
                        onChanged: (e) {
                          c.newTodo.value.description = e;
                        },
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              textAlign: TextAlign.end,
                              style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Time (phút)',
                              ),
                              initialValue: c.newTodo.value.time.toString(),
                              onChanged: (e) {
                                c.newTodo.value.time = int.parse(e);
                              },
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              textAlign: TextAlign.end,
                              style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Bắt đầu',
                              ),
                              initialValue: c.newTodo.value.startAtString,
                              onChanged: (e) {
                                c.newTodo.value.startAtString = e;
                              },
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
          ],
        ));
  }
}

class ListTodoController extends GetxController {
  final tabActive = 'list'.obs;
  final isAdd = false.obs;
  final list = <Todo>[].obs;

  final todoRequest = TodoProvider();

  final newTodo = Rx(Todo.fromMap({
    'title': '',
    'description': '',
    'time': 120,
  }));

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    await todoRequest.open('sample');
    getData();
    super.onReady();
  }

  getData() async {
    list.value = await todoRequest.getTodoList(0, 100);
    list.refresh();
  }

  save() async {
    isAdd.value = false;
    await todoRequest.insert(newTodo.value);
    newTodo.value = Todo.fromMap({
      'title': '',
      'description': '',
      'time': 120,
    });
    await getData();
  }

  @override
  void dispose() {
    todoRequest.close();
    super.dispose();
  }
}
