import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/models/task_model.dart';

class SupabaseFunctions {
//insert //مهم
//delete //مهم
//select //مهم
//update

  Future<List<Task>> getAllTask() async {
    final supabase = Supabase.instance.client;
    final List data = await supabase.from('Task').select('*');

    //print(data.runtimeType.toString());
    List<Task> taskList = [];
    for (var element in data) {
      taskList.add(Task.fromJson(element));
    }
    print(taskList);
    return taskList;
  }

  deleteTask(int id) async {
    await Supabase.instance.client.from('Task').delete().eq('id', id);
  }

  insertTask(String title, String subTitle) async {
    await Supabase.instance.client
        .from('Task')
        .insert({"title": title, "sub_title": subTitle});
  }

  // updateTask()async {
  //   final supabase = Supabase.instance.client;
  //   await supabase.from('Task').update(values)
  // }
}
