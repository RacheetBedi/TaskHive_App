import 'package:flutter/material.dart';
import 'package:flutter_app/enums/navigation_enum.dart';
import 'package:flutter_app/models/group_models/hive.dart';
import 'package:flutter_app/pages/Home_Pages/main_page.dart';
import 'package:flutter_app/pages/Summaries_Pages/recent_changes.dart';
import 'package:flutter_app/pages/Main_Settings_Pages/settings.dart';
import 'package:flutter_app/pages/Summaries_Pages/summary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:choice/choice.dart';
import 'package:dio/dio.dart';
import 'package:async/async.dart';

class AddTasksBody extends ConsumerStatefulWidget {
  const AddTasksBody({super.key});
  @override
  ConsumerState<AddTasksBody> createState() => _AddTasksBodyState();
}

class _AddTasksBodyState extends ConsumerState<AddTasksBody> {
  GlobalKey<FormState> date = GlobalKey<FormState>();
  GlobalKey<FormState> time = GlobalKey<FormState>();
  TextEditingController taskname = TextEditingController();
  TextEditingController taskdescription = TextEditingController();
  bool _isGoogleTask = false;
  List<String> hives = [
    'Hive 1',
    'Hive 2',
    'Hive 3',
    'Hive 4',
    'Hive 5',
    'Hive 6',
    'Hive 7',
    'Hive 8',
  ];
  String? hiveValue;
  void setHiveValue(String? value) {
    setState(() => hiveValue = value);
  }

  List<String> Difficulties = [
    'Easy Task',
    'Medium Task',
    'Hard Task',
  ];
  String? diffValue;
  void setDiffValue(String? value) {
    setState(() => diffValue = value);
  }

  List<String> Owner = [
    'You',
    'BobyJoe',
    'JoeyBob',
  ];
  List<ChoiceData<String>> ownerValue = [];
  void setOwnerValue(List<ChoiceData<String>> value) {
    setState(() => ownerValue = value);
  }
  final choicesMemoizer = AsyncMemoizer<List<ChoiceData<String>>>();

  Future<List<ChoiceData<String>>> getChoices() async {
    try {
      const url =
          "https://randomuser.me/api/?inc=name,picture,email&results=25";
      final res = await Dio().get(url);
      final data = res.data['results'] as List;
      return Future.value(data.asChoiceData(
        value: (i, e) => e['email'],
        title: (i, e) => e['name']['first'] + ' ' + e['name']['last'],
        image: (i, e) => e['picture']['thumbnail'],
      ));
    } on DioException catch (e) {
      throw ErrorDescription(e.message ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        padding: const EdgeInsets.only(top: 10.0),
        shrinkWrap: true,
        children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color:Color.fromARGB(0, 0, 0, 0),
            border: Border(
              left: BorderSide(color: Colors.black, width: 2),
              right: BorderSide(color: Colors.black, width: 2),
              top: BorderSide(color: Colors.black, width: 2),
              bottom: BorderSide(color: Colors.black, width: 2),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("Choose Hive"),
              Choice<String>.inline(
                clearable: true,
                value: ChoiceSingle.value(hiveValue),
                onChanged: ChoiceSingle.onChanged(setHiveValue),
                itemCount: hives.length,
                itemBuilder: (state, i) {
                  return ChoiceChip(
                    selected: state.selected(hives[i]),
                    onSelected: state.onSelected(hives[i]),
                    label: Text(hives[i]),
                  );
                },
                listBuilder: ChoiceList.createScrollable(
                  spacing: 10,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                ),
              ),
            ],
          ),
        ), 
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color:Color.fromARGB(0, 0, 0, 0),
            border: Border(
              left: BorderSide(color: Colors.black, width: 2),
              right: BorderSide(color: Colors.black, width: 2),
              bottom: BorderSide(color: Colors.black, width: 2),
            ),
          ),
          child: Choice<String>.prompt(
            clearable: true,
            title: "Task Difficulty",
            value: ChoiceSingle.value(diffValue),
            onChanged: ChoiceSingle.onChanged(setDiffValue),
            itemCount: Difficulties.length,
            itemBuilder: (state, i) {
              return ChoiceChip(
                selected: state.selected(Difficulties[i]),
                onSelected: state.onSelected(Difficulties[i]),
                label: Text(Difficulties[i]),
              );
            },
            listBuilder: ChoiceList.createScrollable(
              spacing: 10,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 25,
              ),
            ),
          )
        ),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color:Color.fromARGB(0, 0, 0, 0),
            border: Border(
              left: BorderSide(color: Colors.black, width: 2),
              right: BorderSide(color: Colors.black, width: 2),
              bottom: BorderSide(color: Colors.black, width: 2),
            ),
          ),
          child: FutureBuilder<List<ChoiceData<String>>>(
            initialData: const [],
            future: choicesMemoizer.runOnce(getChoices),
            builder: (context, snapshot) {
              return SizedBox(
                width: 300,
                child: Card(
                  color:const Color(0xFFFFDD97),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      appBarTheme: Theme.of(context).appBarTheme.copyWith(
                        iconTheme: const IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                    child: PromptedChoice<ChoiceData<String>>.multiple(
                      title: 'Users',
                      clearable: true,
                      error: snapshot.hasError,
                      errorBuilder: ChoiceListError.create(
                        message: snapshot.error.toString(),
                      ),
                      loading: snapshot.connectionState == ConnectionState.waiting,
                      value: ownerValue,
                      onChanged: setOwnerValue,
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (state, i) {
                        final choice = snapshot.data?.elementAt(i);
                        return CheckboxListTile(
                          value: state.selected(choice!),
                          onChanged: state.onSelected(choice),
                          title: Text(choice.title),
                          subtitle: choice.subtitle != null
                            ? Text(
                                choice.subtitle!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            : null,
                          secondary: choice.image != null
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(choice.image!),
                              )
                            : null,
                        );
                      },
                      modalHeaderBuilder: ChoiceModal.createHeader(
                        title: const Text('Select Users', style: TextStyle(fontSize: 50, fontWeight: FontWeight.normal),),
                        actionsBuilder: [
                          (state) {
                            final values = snapshot.data!;
                            return Checkbox(
                              value: state.selectedMany(values),
                              onChanged: state.onSelectedMany(values),
                              tristate: true,
                            );
                          },
                          ChoiceModal.createSpacer(width: 25),
                        ],
                      ),
                      promptDelegate: ChoicePrompt.delegateBottomSheet(),
                      anchorBuilder: ChoiceAnchor.create(valueTruncate: 1),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 15,),
        TextField(
          controller: taskname,
          decoration: const InputDecoration(hintText: 'Task Name'),
        ),
        const SizedBox(height: 15,),
        TextField(
          minLines: null,
          maxLines: null,
          expands: true,
          controller: taskdescription,
          decoration: const InputDecoration(hintText: 'Task Summary'),
        ),
        const SizedBox(height: 15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Google Task?"),
            const SizedBox(width: 5,),
            Checkbox(
              value: _isGoogleTask,
              onChanged: (bool? newValue) {
                setState(() {
                  _isGoogleTask = newValue!;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 15,),
        ElevatedButton(
          onPressed: () {
            showDialog(context: context, builder: (BuildContext context) {
              return DatePickerDialog(firstDate: DateTime(2000), lastDate: DateTime(2100), initialDate: DateTime.now(), initialEntryMode: DatePickerEntryMode.input, key: date);
            });
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.date_range),
              SizedBox(width: 5,),
              Text("Select Date"),
            ],
          )
        ),
        const SizedBox(height: 15,),
        ElevatedButton(
          onPressed: () {
            showDialog(context: context, builder: (BuildContext context) {
              return TimePickerDialog(initialTime: TimeOfDay.now(), initialEntryMode: TimePickerEntryMode.input, key: time);
            });
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.av_timer),
              SizedBox(width: 5,),
              Text("Select Time"),
            ],
          )
        ),
        const SizedBox(height: 15,),
        ElevatedButton(
          onPressed: () {}, //Need to Add Adding Functionality
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              SizedBox(width: 5,),
              Text("Add Task"),
            ],
          )
        ),
      ],
    ),
  );
  }
}