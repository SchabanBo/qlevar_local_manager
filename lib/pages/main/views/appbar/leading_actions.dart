import 'package:flutter/material.dart';

import '../../../../helpers/constants.dart';
import '../../../../services/di_service.dart';
import '../../controllers/main_controller.dart';

class LeadingActions extends StatelessWidget {
  const LeadingActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = getService<MainController>();
    return Row(
      children: [
        SizedBox(
          width: 250,
          child: TextField(
            onChanged: controller.filter,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search, color: AppColors.icon),
              hintText: 'Filter',
              fillColor: AppColors.icon,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
