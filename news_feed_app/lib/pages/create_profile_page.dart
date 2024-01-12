import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_feed_app/components/news_feed_input_field.dart';
import 'package:news_feed_app/controllers/create_profile_controller.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final _createProfileCtrl = CreateProfileController();
  final _selected = <String>{};

  @override
  void dispose() {
    _createProfileCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(children: [
          // Title
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Text(
              'Create Profile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Name
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 20, right: 20),
            child: GetBuilder<CreateProfileController>(
                init: _createProfileCtrl,
                builder: (ctrl) {
                  return NewsFeedInputField(
                      onChanged: (val) => ctrl.setName(val),
                      hintText: 'Name...');
                }),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: GetBuilder<CreateProfileController>(
                init: _createProfileCtrl,
                builder: (ctrl) {
                  return NewsFeedInputField(
                      onChanged: (val) => ctrl.setCountry(val),
                      hintText: 'Country...');
                }),
          ),

          Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: _listOfChipsWidget()),

          // Create Profile Button
          GetBuilder<CreateProfileController>(
              init: _createProfileCtrl,
              builder: (ctrl) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () => ctrl.createProfile(_selected.toList()),
                    child: const Text('Create Profile'),
                  ),
                );
              }),
        ]),
      ),
    );
  }

  Color _colorGeneratorBasedOnIndex(int index) {
    final colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.orange,
      Colors.pink,
      Colors.purple,
    ].map((e) => e.withOpacity(0.5)).toList();

    return colors[index % colors.length];
  }

  _listOfChipsWidget() {
    return GetBuilder<CreateProfileController>(builder: (ctrl) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Column(children: [_chips(ctrl)]),
        ),
      );
    });
  }

  Wrap _chips(CreateProfileController profileController) {
    return Wrap(
        spacing: 6.0 * 1.3,
        runSpacing: 6.0 * 1.3,
        alignment: WrapAlignment.center,
        children: List<Widget>.generate(profileController.categories.length,
            (int index) {
          final isSelected =
              _selected.contains(profileController.categories[index]);
          return ChoiceChip(
            selectedColor: _colorGeneratorBasedOnIndex(index),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: const BorderSide(color: Colors.deepPurpleAccent),
            ),
            backgroundColor: Colors.white,
            label: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                profileController.categories[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 14.0 * 1.3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            selected: isSelected,
            onSelected: (bool selected) {
              setState(() {
                if (selected) {
                  _selected.add(profileController.categories[index]);
                } else {
                  _selected.remove(profileController.categories[index]);
                }
              });
            },
          );
        }));
  }
}
