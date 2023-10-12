import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/send_notification.dart';
import 'package:todo/tasks.dart';
import 'database.dart';
import 'notification_services.dart';

class TaskList extends StatefulWidget {
  final DatabaseHelper dbHelper;

  const TaskList({required this.dbHelper});

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  NotificationServices notificationServices = NotificationServices();
List <String>tokens=[];
  void initState() {
    notificationServices.requestNotificationPermission();

    // Cloud Messaging
    notificationServices.firebaseInit(context);

    // Device Token Refresh
    notificationServices.isTokenRefresh();
    // Device Token
    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('Device Token');
      }
      if (kDebugMode) {
        print(value);
        tokens.add(value);
      }
    });

    super.initState();
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper();

  Future<List<Task>> getData() async {
    await databaseHelper.initializeDatabase(); // Initialize the database helper
    final data = await databaseHelper.getTasks();

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        elevation: 0,
        title: const Center(
          child: Text(
            'To-Do App',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
      body: FutureBuilder<List<Task>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final task = snapshot.data;
            return ListView.builder(
              itemCount: task?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: Card(
                    elevation: 5, // Adds a shadow to the card
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // Adds rounded corners to the card
                    ),
                    color: Colors.yellow,
                    child: ListTile(
                      title: Text(
                        task![index].title,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(task![index].description),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          widget.dbHelper.deleteTask(task[index].id!);
                          showSnackBar("Note Deleted");
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("NO Task Added"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskDialog(context),
        backgroundColor: Colors.yellow,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }

  void _showTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shadowColor: Colors.amber,
          contentPadding: EdgeInsets.all(17),
          backgroundColor: Colors.yellow[300],
          title: const Text(
            'Add Task',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                style: const TextStyle(color: Colors.black),
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: "Enter Title",
                  hintStyle: const TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.amberAccent),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      color: Colors.amberAccent,
                      // Outline border color when not focused
                      width: 2.0, // Outline border width when not focused
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(10.0),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                style: const TextStyle(color: Colors.black),
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: "Enter Description",
                  hintStyle: const TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.amberAccent),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      color: Colors.amberAccent,
                      width: 2.0, // Outline border width when not focused
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
              ),
              onPressed: () async {
                final title = _titleController.text;
                final description = _descriptionController.text;
                if (title.isNotEmpty) {
                  await databaseHelper.insertTask(
                    Task(
                      title: title,
                      description: description,
                    ),
                  );
                  await FirebaseAPIServices().sendPushNotifications(
                      title: _titleController.text.toString(),
                      body: _descriptionController.text.toString(),
                      token: tokens);
                  setState(() {
                    _titleController.text = "";
                    _descriptionController.text = "";
                  });
                  showSnackBar("Note is Added");
                }
                Navigator.of(context).pop();
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}

void showSnackBar(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.yellow,
    textColor: Colors.black54,
  );
}
