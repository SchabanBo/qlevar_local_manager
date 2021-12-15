import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/main_controller.dart';

class LeadingActions extends StatelessWidget {
  const LeadingActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainController>();
    return Row(
      children: [
        SizedBox(
          width: 250,
          child: TextField(
            onChanged: controller.filter,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Filter',
              fillColor: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
