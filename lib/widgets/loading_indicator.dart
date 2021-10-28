import 'package:flutter/material.dart';
import 'package:raag/model/strings.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              CircularProgressIndicator(
                backgroundColor: Colors.black38,
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.secondary),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                loading,
                style: Theme.of(context).textTheme.headline3,
              )
            ],
          ),
        ],
      ),
    );
  }
}
