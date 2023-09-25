
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Widgets/containerongoingactivities.dart';
import 'Classes/activitydetails.dart';
import '../darius_mock_models/remote_service_list_objects.dart';
import 'Widgets/loadingscreen.dart';
import 'detailed_activity_page.dart';
import 'Widgets/containersearchactivity.dart';
import 'Styles/Colors.dart';

class OngoingActivities extends StatefulWidget {
  const OngoingActivities({super.key});

  @override
  State<OngoingActivities> createState() => _OngoingActivitiesState();
}

class _OngoingActivitiesState extends State<OngoingActivities> {
  List<ActivityDetails> activities = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final activityData = await fetchEventData();

    setState(() {
      activities = activityFromJson(json.encode(activityData));
      isLoaded = true;
    });
  }

  void _onBackPressed() {
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoadingScreenPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ongoing Activities"),
        backgroundColor: Color_Blue,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _onBackPressed();
          },
        ),
      ),
      body: Container(
        color: Color_Gray,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Visibility(
                visible: isLoaded,
                replacement: Center(child: const CircularProgressIndicator()),
                child: ListView.builder(
                  itemCount: activities.length,
                  itemBuilder: (context, index) {
                    final activity = activities[index];
                    return ContainerActivityForSearch(activity);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



