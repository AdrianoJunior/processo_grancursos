import 'package:flutter/material.dart';

import 'nav.dart';

alert(BuildContext context, String msg, {Function? callback}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text("Users CRUD"),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                if(callback != null) {
                  callback();
                }
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
    },
  );
}

alertCancel(BuildContext context, String msg, {Function? callback}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text("Users CRUD"),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                if(callback != null) {
                  callback();
                }
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}
