import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckboxAlerta extends StatefulWidget {

  late List<CategoryOption> categoryOptions;
  List<CategoryOption> categorSelected = [];

  

   CheckboxAlerta({super.key, required this.categoryOptions});

  @override
  State<CheckboxAlerta> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxAlerta> {

  @override
  void initState() {
    super.initState();
    widget.categoryOptions = [
      CategoryOption(name: "Policia", state: false),
      CategoryOption(name: "Bomberos", state: false),
      CategoryOption(name: "Trancas", state: false),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categoryOptions.length,
        itemBuilder: ((context, index) {
          return Row(
            children: [
              Checkbox(
                value: widget.categoryOptions[index].state,
                onChanged: (value) {
                  setState(() {
                    widget.categoryOptions[index].state = value!;
                    if(value){
                      widget.categorSelected.add(widget.categoryOptions[index]);
                    }else{
                      widget.categorSelected.remove(widget.categoryOptions[index]);
                    }
                  });
                },
              ),
              Text(widget.categoryOptions[index].name),
            ],
          );   
        })
      )
    );
  }
}

class CategoryOption {
  String name;
  bool state;

  CategoryOption({required this.name, required this.state});
}