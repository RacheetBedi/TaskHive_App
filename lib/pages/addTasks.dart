import 'package:flutter/material.dart';
import 'package:flutter_app/pages/settings.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:choice/choice.dart';
import 'package:dio/dio.dart';
import 'package:async/async.dart';

class AddTasks extends ConsumerStatefulWidget {
  const AddTasks({super.key});
  @override
  ConsumerState<AddTasks> createState() => _AddTasksState();
}

class _AddTasksState extends ConsumerState<AddTasks> {
  List<String> Hives = [
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/Circle Logo.png',
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(104, 255, 255, 255),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.history_outlined, color: Colors.red),
                                iconSize: 26,
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.analytics_outlined, color: Colors.red),
                                iconSize: 26,
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.settings_outlined, color: Colors.red),
                                iconSize: 26,
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                onPressed: () => Get.offAll(() => const Settings()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Positioned(
                  top: 64,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      "Add Tasks",
                      textHeightBehavior: TextHeightBehavior(
                        applyHeightToFirstAscent: false,
                        applyHeightToLastDescent: false,
                        leadingDistribution: TextLeadingDistribution.proportional,
                      ),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 80,
                        height: 0.65,
                        fontFamily: 'Jomhuria',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          if (index == 0) {
            Get.offAll(() => const Home());
          }
          
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.screen_search_desktop_outlined),
            label: 'Tracking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined),
            label: 'Hives',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.co_present_outlined),
            label: 'Classroom',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Calendar',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                      itemCount: Hives.length,
                      itemBuilder: (state, i) {
                        return ChoiceChip(
                          selected: state.selected(Hives[i]),
                          onSelected: state.onSelected(Hives[i]),
                          label: Text(Hives[i]),
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
                            title: const Text('Select Users'),
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
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}