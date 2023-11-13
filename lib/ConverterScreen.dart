import 'package:flutter/material.dart';
import 'package:temperature_converter/units.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

String dropValue = Unit.C;
int c = 0;
List<double> result = [0.0, 0.0, 0.0];
TextEditingController _textEditingController = TextEditingController();

class _ConverterScreenState extends State<ConverterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber.shade50,
        appBar: AppBar(
          elevation: 2,
          toolbarHeight: 85,
          title: Text(
            "C O N V E R T E R",
            style: TextStyle(
                color: Colors.amber.shade700, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.amber.shade100,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.amber.shade100,
                  ),
                  child: DropdownButton<String>(
                    elevation: 5,
                    isExpanded: true,
                    isDense: true,
                    padding: EdgeInsets.only(top: 16, left: 12, right: 12),
                    alignment: Alignment.center,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                    dropdownColor: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    value: dropValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropValue = newValue!;
                      });
                    },
                    items: Unit.unitName.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: TextStyle(color: Colors.amber.shade700),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: InputText(dropValue)),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  title: Text(
                    "UNITS",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  trailing: Text(
                    "VALUE",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  tileColor: Colors.amber.shade500,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              Card(
                  elevation: 5,
                  clipBehavior: Clip.hardEdge,
                  shadowColor: Colors.grey,
                  margin: EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(width: 1, color: Colors.amber)),
                  child: AnsTile(AnsList()[0], c)),
              Card(
                  elevation: 5,
                  clipBehavior: Clip.hardEdge,
                  margin: EdgeInsets.all(8),
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(width: 1, color: Colors.amber)),
                  child: AnsTile(AnsList()[1], c + 1)),
              Card(
                  elevation: 5,
                  clipBehavior: Clip.hardEdge,
                  margin: EdgeInsets.all(8),
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(width: 1, color: Colors.amber)),
                  child: AnsTile(AnsList()[2], c + 2)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        _textEditingController.clear();
                        setState(() {});
                      },
                      style: ButtonStyle(
                          shape:
                              MaterialStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              side: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.black,
                                  width: 10),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          elevation: MaterialStatePropertyAll(5),
                          shadowColor: MaterialStatePropertyAll(Colors.black),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.redAccent)),
                      child: Text(
                        "R E S E T",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  TextFormField InputText(String value) {
    return TextFormField(
        keyboardType: TextInputType.number,
        controller: _textEditingController,
        textAlign: TextAlign.center,
        cursorOpacityAnimates: true,
        cursorColor: Colors.black,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          fillColor: Colors.amber.shade100,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          hintStyle:
              TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
          hintText: "enter value in $value",
          filled: true,
        ));
  }

  void CalculateResult(String s) {
    if (s.isEmpty) {
      result[0] = 0.0;
      result[1] = 0.0;
      result[2] = 0.0;
      return;
    }
    double value = double.parse(s);
    if (dropValue == Unit.C) {
      result[0] = (value * 9 / 5) + 32;
      result[1] = (value + 273.15);
      result[2] = (value + 9 / 5) + 491.67;
    } else if (dropValue == Unit.F) {
      result[0] = (value - 32) * 5 / 9;
      result[1] = result[0] + 273.15;
      result[2] = value + 459.67;
    } else if (dropValue == Unit.K) {
      result[0] = value - 273.15;
      result[1] = (value - 273.15) * 9 / 5 + 32;
      result[2] = value * 9 / 5;
    } else {
      result[0] = (value - 491.67) * 5 / 9;
      result[1] = value - 459.67;
      result[2] = value * 5 / 9;
    }
    result[0] = double.parse((result[0]).toStringAsFixed(2));
    result[1] = double.parse((result[1]).toStringAsFixed(2));
    result[2] = double.parse((result[2]).toStringAsFixed(2));
    setState(() {});
  }

  List<String> AnsList() {
    List<String> l = [Unit.C, Unit.F, Unit.K, Unit.R];
    l.remove(dropValue);
    return l;
  }

  ListTile AnsTile(String value, int i) {
    CalculateResult(_textEditingController.text);
    return ListTile(
      title: Text(
        value,
        style: TextStyle(
            color: Colors.black, fontSize: 15, fontWeight: FontWeight.w300),
      ),
      trailing: Text(
        "${result[i]}",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
      ),
      tileColor: Colors.white,
      contentPadding: EdgeInsets.all(10),
    );
  }
}
