import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:intl/intl.dart';
import 'package:my_project/Views/Widgets/WidgetBackgroundBox.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_project/Views/Widgets/WidgetTagsBox.dart';

import 'Styles/Colors.dart';
import 'Styles/StyleText.dart';
import 'Widgets/WidgetButtons.dart';

class add_activity_page extends StatefulWidget {
  const add_activity_page({super.key});

  @override
  State<add_activity_page> createState() => _add_activity_pageState();
}

class _add_activity_pageState extends State<add_activity_page> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController activity_title = TextEditingController();
  TextEditingController activity_location = TextEditingController();
  TextEditingController activity_date = TextEditingController();
  TextEditingController activity_time = TextEditingController();
  TextEditingController activity_nr_participants = TextEditingController();
  TextEditingController activity_description = TextEditingController();
  List<String> activity_tags = [];
  bool isVisible = false;

  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();

  void selectDate() {
    showDatePicker(
            context: context,
            builder: (context, child) => Theme(
                  data: ThemeData().copyWith(
                      colorScheme: const ColorScheme.dark(
                          primary: Color_Blue,
                          onPrimary: Color_White,
                          surface: Color_Blue,
                          onSurface: Color_Dark_Gray),
                      dialogBackgroundColor: Color_Gray),
                  child: child!,
                ),
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365)))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        activity_date.text = DateFormat("dd.MM.yyyy").format(pickedDate);
      });
    });
  }

  void selectTime() {
    showTimePicker(
            context: context,
            builder: (context, child) => Theme(
                  data: ThemeData().copyWith(
                      colorScheme: const ColorScheme.dark(
                          primary: Color_Blue,
                          surface: Color_Gray,
                          onSurface: Color_Dark_Gray)),
                  child: child!,
                ),
            initialTime: TimeOfDay.now())
        .then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      setState(() {
        final now = DateTime.now();
        DateTime aux = DateTime(
            now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
        activity_time.text = DateFormat.Hm().format(aux);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Column(
                  children: [Image.asset('assets/map.png'), const SizedBox()],
                ),
                WidgetBackgroundBox(
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 30, 25, 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 8,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: activity_title,
                                    validator: MultiValidator([
                                      MinLengthValidator(6,
                                          errorText:
                                              "Title must be at least 6 characters"),
                                    ]),
                                    style: Text_Title_Top,
                                    maxLength: 35,
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                        hintText: '+Activity name',
                                        hintStyle: Text_AddActivity_Title,
                                        border: InputBorder.none,
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            activity_title.clear();
                                          },
                                          icon: const Icon(
                                            Icons.clear,
                                            color: Color_Blue,
                                          ),
                                        )),
                                  ),
                                  TextFormField(
                                    controller: activity_location,
                                    validator: MultiValidator([
                                      MinLengthValidator(13,
                                          errorText: 'Include Str. and nr.'),
                                    ]),
                                    style: Text_AddActivity_Small_Input,
                                    maxLength: 50,
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                        hintText: '+Adress',
                                        hintStyle: Text_AddActivty_Small,
                                        border: InputBorder.none,
                                        prefixIcon: const Icon(
                                          Icons.location_pin,
                                          color: Color_Dark_Gray,
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            activity_location.clear();
                                          },
                                          icon: const Icon(
                                            Icons.clear,
                                            color: Color_Blue,
                                          ),
                                        )),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          onTap: selectDate,
                                          validator: MinLengthValidator(1,
                                              errorText: 'Required'),
                                          readOnly: true,
                                          controller: activity_date,
                                          style: Text_AddActivity_Small_Input,
                                          decoration: InputDecoration(
                                            hintText: '+Date',
                                            hintStyle: Text_AddActivty_Small,
                                            border: InputBorder.none,
                                            prefixIcon: const Icon(
                                              Icons.calendar_month_rounded,
                                              color: Color_Dark_Gray,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          onTap: selectTime,
                                          validator: MinLengthValidator(1,
                                              errorText: 'Required'),
                                          readOnly: true,
                                          controller: activity_time,
                                          style: Text_AddActivity_Small_Input,
                                          decoration: InputDecoration(
                                            hintText: '+Time',
                                            hintStyle: Text_AddActivty_Small,
                                            border: InputBorder.none,
                                            prefixIcon: const Icon(
                                              Icons.access_time_filled,
                                              color: Color_Dark_Gray,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: TextFormField(
                                          controller: activity_nr_participants,
                                          validator: MultiValidator([
                                            MinLengthValidator(1,
                                                errorText: 'Required'),
                                            RangeValidator(
                                                min: 2,
                                                max: 99,
                                                errorText:
                                                    'Between 2 and 99 participants')
                                          ]),
                                          keyboardType: TextInputType.number,
                                          style: Text_AddActivity_Small_Input,
                                          autocorrect: false,
                                          decoration: InputDecoration(
                                            hintText: '+Nr. participants',
                                            hintStyle: Text_AddActivty_Small,
                                            border: InputBorder.none,
                                            prefixIcon: const Icon(
                                              Icons.person_rounded,
                                              color: Color_Dark_Gray,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Expanded(child: SizedBox()),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: activity_description,
                                    validator: MultiValidator([
                                      MinLengthValidator(60,
                                          errorText: 'Make description longer'),
                                    ]),
                                    maxLength: 300,
                                    maxLines: 7,
                                    autocorrect: false,
                                    style: Text_AddActivity_Small_Description,
                                    decoration: InputDecoration(
                                        hintText: '+Description',
                                        hintStyle: Text_AddActivty_Small,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(35),
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            activity_description.clear();
                                          },
                                          icon: const Icon(
                                            Icons.clear,
                                            color: Color_Blue,
                                          ),
                                        )),
                                  ),
                                  Tags(
                                    key: _tagStateKey,
                                    textField: TagsTextField(
                                        autofocus: false,
                                        width: 1000,
                                        hintText: '+Tags',
                                        hintTextColor: Color_Dark_Gray,
                                        inputDecoration: InputDecoration(
                                          hintStyle: Text_AddActivty_Small,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(35),
                                          ),
                                        ),
                                        textStyle: Text_AddActivty_Small,
                                        onSubmitted: (String str) {
                                          setState(() {
                                            if(str.length < 3) {
                                              return;
                                            } else if (!activity_tags.contains(str)) {
                                              activity_tags.add(str);
                                            }
                                          });
                                        }),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Visibility(
                                        visible: isVisible,
                                        child: Text(
                                          'Add at least one tag',
                                          style: TextStyle(
                                              color: Colors.red[700],
                                              fontSize: 12),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 11,
                                  ),
                                  Wrap(
                                    direction: Axis.horizontal,
                                    alignment: WrapAlignment.start,
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: activity_tags.map((tag) {
                                      return IntrinsicWidth(
                                        child: WidgetTagsBox(Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              tag,
                                              style: Text_Tag_Widget
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                activity_tags.remove(tag);
                                                setState(() {});
                                              },
                                              icon: const Icon(Icons.clear, color: Color_Dark_Gray,),
                                            )
                                          ],
                                        )),
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(height: 200)
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (activity_tags.isEmpty) {
                                          isVisible = true;
                                        } else {
                                          isVisible = false;
                                        }
                                      });
                                      if (_formKey.currentState!.validate()) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            backgroundColor: Colors.white,
                                            content: Text(
                                              'Validation Successful',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: WidgetButton(
                                      Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('Create',
                                                style:
                                                    Text_Widget_Buttons_Blue),
                                            const Icon(
                                              Icons.add_circle,
                                              color: Color_Light_Blue,
                                            )
                                          ],
                                        ),
                                      ),
                                      Color_Dark_Gray,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: WidgetButton(
                                    Center(
                                      child: Text("Invite",
                                          style: Text_Widget_Buttons_Blue),
                                    ),
                                    Color_Dark_Gray,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
