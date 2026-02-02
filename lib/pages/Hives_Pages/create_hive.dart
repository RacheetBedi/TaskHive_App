import 'package:choice/choice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/enums/navigation_enum.dart';
import 'package:flutter_app/pages/Setup_Pages/login_page.dart';
import 'package:flutter_app/pages/Home_Pages/main_page.dart';
import 'package:flutter_app/pages/Summaries_Pages/recent_changes.dart';
import 'package:flutter_app/pages/Main_Settings_Pages/settings.dart';
import 'package:flutter_app/pages/Setup_Pages/signupStudent.dart';
import 'package:flutter_app/pages/Setup_Pages/signupTeacher.dart';
import 'package:flutter_app/pages/Hives_Pages/specificHive.dart';
import 'package:flutter_app/pages/Summaries_Pages/summary.dart';
import 'package:flutter_app/providers/auth_provider.dart';
import 'package:flutter_app/utilities/userRepository.dart';
import 'package:flutter_app/widgets/hive_widget.dart';
import 'package:flutter_app/widgets/nectar_center_points_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:async/async.dart';

class CreateHive extends ConsumerStatefulWidget {
  const CreateHive({super.key});
  @override
  ConsumerState<CreateHive> createState() => _CreateHiveState();
}

class _CreateHiveState extends ConsumerState<CreateHive> {
  TextEditingController hiveName = TextEditingController();
  TextEditingController hiveDesc = TextEditingController();
  String _subject = "Mathematics";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
  List<ChoiceData<String>> ownerValue = [];
  void setOwnerValue(List<ChoiceData<String>> value) {
    setState(() => ownerValue = value);
  }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.only(top: 10.0),
          child: ListView(
            children: [
              Column(
                children: [
                  TextField(
                    controller: hiveName,
                    decoration: const InputDecoration(
                      hintText: 'Hive Name',
                      constraints: BoxConstraints(
                        maxWidth: 225,
                        minWidth: 50,
                        minHeight: 50,
                        maxHeight: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: () {
                      // Popup for Choosing Icon
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100000000),
                        side: const BorderSide(
                          color: Color(0xFFFF7700),
                          width: 1,
                        ),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: 30, color: Color(0xFFFF7700),),
                        SizedBox(width: 10),
                        Text(
                          "Choose Hive Icon",
                          style: TextStyle(
                            fontFamily: 'Jomhuria',
                            fontWeight: FontWeight.normal,
                            fontSize: 40,
                            color: Color(0xFFFF7700),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  FutureBuilder<List<ChoiceData<String>>>(
                    initialData: const [],
                    future: choicesMemoizer.runOnce(getChoices),
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: 300,
                        child: Card(
                          color:const Color(0xFFFFB743),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              appBarTheme: Theme.of(context).appBarTheme.copyWith(
                                iconTheme: const IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                            child: PromptedChoice<ChoiceData<String>>.multiple(
                              title: 'Hive Members',
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
                                title: const Text('Select Hive Members', style: TextStyle(fontSize: 50, fontWeight: FontWeight.normal),),
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
                  const SizedBox(height: 10,),
                  TextField(
                    controller: hiveDesc,
                    expands: true,
                    minLines: null,
                    maxLines: null,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: const InputDecoration(
                      hintText: 'description',
                      constraints: BoxConstraints(
                        maxWidth: 350,
                        minWidth: 50,
                        minHeight: 50,
                        maxHeight: 200,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Transform.scale(
                      scale: 1,
                      child: DropdownMenu<SubjectLabel>(
                        initialSelection: SubjectLabel.mathematics,
                        onSelected: (SubjectLabel? subject) {
                          setState(() {
                            _subject = subject?.label ?? "Mathematics";
                          });
                        },
                        dropdownMenuEntries: SubjectLabel.entries,
                      ),
                    ),
                  const SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: () {
                      // Takes to Hive Settings Page
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100000000),
                        side: const BorderSide(
                          color: Color(0xFFFFF600),
                          width: 1,
                        ),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings_outlined, size: 30, color: Color(0xFFFFF600),),
                        SizedBox(width: 10),
                        Text(
                          "Hive Settings",
                          style: TextStyle(
                            fontFamily: 'Jomhuria',
                            fontWeight: FontWeight.normal,
                            fontSize: 40,
                            color: Color(0xFFFFF600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: () {
                      // Creates the Hive
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100000000),
                        side: const BorderSide(
                          color: Color(0xFFFF00EE),
                          width: 1,
                        ),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.group_add_outlined, size: 30, color: Color(0xFFFF00EE),),
                        SizedBox(width: 10),
                        Text(
                          "Create Hive",
                          style: TextStyle(
                            fontFamily: 'Jomhuria',
                            fontWeight: FontWeight.normal,
                            fontSize: 40,
                            color: Color(0xFFFF00EE),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ]
          ),
        ),
      )
    );
  }
}

typedef SubjectEntry = DropdownMenuEntry<SubjectLabel>;

enum SubjectLabel {
  mathematics('Mathematics'),
  science('Science'),
  history('History'),
  english('English'),
  art('Art'),
  music('Music'),
  physicalEducation('Physical Education'),
  computerScience('Computer Science'),
  foreignLanguages('Foreign Languages'),
  economics('Economics'),
  psychology('Psychology');

  const SubjectLabel(this.label);
  final String label;

  static final List<DropdownMenuEntry<SubjectLabel>> entries =
      SubjectLabel.values.map((subject) {
    return DropdownMenuEntry<SubjectLabel>(
      value: subject,
      label: subject.label,
    );
  }).toList();
}