import 'package:flutter/material.dart';

showErrorDialog(BuildContext context, {bool? doublePop, String? message}) {
  bool double = doublePop ?? false;
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text(
            'Error',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red),
          ),
          content: Text(
            message ?? "We are unable to do that. Please try again",
            textAlign: TextAlign.center,
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                child: const Text("Ok"),
                onPressed: () {
                  if (double) {
                    Navigator.of(ctx).pop();
                  }
                  Navigator.of(ctx).pop();
                },
              ),
            ),
          ],
        );
      });
} // End showErrorDialog