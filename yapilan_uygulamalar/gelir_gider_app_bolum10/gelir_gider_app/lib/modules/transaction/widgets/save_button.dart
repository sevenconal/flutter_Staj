import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../controllers/transaction_controller.dart';

class SaveButton extends GetView<TransactionController> {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        await controller.createTransaction();
      },
      label: Text("Kaydet"),
      icon: Icon(Icons.save_rounded),
    );
  }
}
