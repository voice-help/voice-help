import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voicehelp/service/record_service.dart';

class RecordDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RecordDialogState();
}

class RecordDialogState extends State<RecordDialog> {
  final TextEditingController recordNameController = TextEditingController();
  var _isRecordNameValid = true;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: Container(
        height: 250,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'What do you want to do with record ?'),
              ),
              TextField(
                controller: recordNameController,
                obscureText: false,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter record name',
                  hintStyle: TextStyle(color: Colors.grey),
                  errorText:
                      _isRecordNameValid ? null : 'Name has to be 3-32 length',
                  errorStyle: TextStyle(color: Colors.red),
                ),
              ),
              SizedBox(
                width: 320.0,
                child: RaisedButton(
                  onPressed: () {
                    if (recordNameController.text.length < 3 ||
                        recordNameController.text.length > 32) {
                      setState(() {
                        _isRecordNameValid = false;
                      });
                      return;
                    }
                    uploadRecord(recordNameController.text).then((value) => {
                          if (value != null && value.statusCode == 200)
                            {
                              Scaffold.of(this.context)
                                  .showSnackBar(saveSuccessSnackBar)
                            }
                          else
                            {
                              Scaffold.of(this.context)
                                  .showSnackBar(saveFailSnackBare)
                            }
                        });
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: const Color(0xFF1BC0C5),
                ),
              ),
              SizedBox(
                width: 320.0,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Remove",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: const Color(0xFF1BC0C5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final saveSuccessSnackBar = SnackBar(
    content: Text('Record saved!'),
  );

  final saveFailSnackBare = SnackBar(
    content: Text('Record save failure :('),
  );
  final removedSnackBar = SnackBar(
    content: Text('Record removed'),
  );
}
