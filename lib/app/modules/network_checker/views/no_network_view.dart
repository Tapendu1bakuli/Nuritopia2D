import 'package:flutter/material.dart';

import '../../../../utils/image_utils/image_utils.dart';
class CommonNoInterNetWidget extends StatelessWidget {
  const CommonNoInterNetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(ImageUtils.noNet),
            const Text(
              "Please Check Your Connection!",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}