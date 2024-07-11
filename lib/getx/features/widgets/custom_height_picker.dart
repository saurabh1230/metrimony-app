import 'package:bureau_couple/getx/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeightPickerWidget extends StatefulWidget {
  final TextEditingController heightController;

  HeightPickerWidget({required this.heightController});

  @override
  _HeightPickerWidgetState createState() => _HeightPickerWidgetState();
}

class _HeightPickerWidgetState extends State<HeightPickerWidget> {
  int _feet = 5;
  int _inches = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radius20),
            topRight: Radius.circular(Dimensions.radius20)
        )
      ),
      height: MediaQuery.of(context).copyWith().size.height / 3,
      child: Column(
        children: [
          WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: SizedBox(
              height: 200,
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                        initialItem: _feet - 5,
                      ),
                      itemExtent: 32,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _feet = index + 5;
                        });
                      },
                      children: List.generate(
                        7, // 7 feet in the range from 5 to 11
                            (index) => Center(child: Text('${index + 5}\'')),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                        initialItem: _inches,
                      ),
                      itemExtent: 32,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _inches = index;
                        });
                        print('$_feet-${_inches.toString().padLeft(2, '0')}');
                      },
                      children: List.generate(
                        12, // 12 inches in a foot
                            (index) => Center(child: Text('$index\"')),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Close and Save buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent, // Change the background color to red
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.heightController.text =
                      '$_feet.${_inches.toString().padLeft(1, '0')}';
                      print('$_feet.${_inches.toString().padLeft(1, '0')}');
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
