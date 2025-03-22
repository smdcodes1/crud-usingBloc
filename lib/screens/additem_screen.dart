
import 'dart:math';

import 'package:bloc_example/item_model.dart';
import 'package:bloc_example/logic/item/item_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class addItemPage extends StatefulWidget {
  addItemPage({
    super.key,
  });

  @override
  State<addItemPage> createState() => _addItemPageState();
}

class _addItemPageState extends State<addItemPage> {
  bool _isProcessing = false;

  GlobalKey<FormState> _addItemKey = GlobalKey();

  TextEditingController _controllerTitle = TextEditingController();

  TextEditingController _controllerContent = TextEditingController();

  // File? _image;

  // final imagePicker = ImagePicker();

  // String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CRUD Sample',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
        ),
        elevation: 10,
        backgroundColor: Colors.cyan,
      ),
      body: Form(
        key: _addItemKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter ur title';
                    }
                    return null;
                  },
                  controller: _controllerTitle,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'Enter the Title',
                    labelText: 'Enter the Title',
                    disabledBorder: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  maxLines: 1,
                  autofocus: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter ur description';
                    }
                    return null;
                  },
                  controller: _controllerContent,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'Enter the Description',
                    labelText: 'Enter the Description',
                    disabledBorder: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  maxLines: 4,
                ),
              ),
              SizedBox(
                height: 20,
              ),
           
              SizedBox(
                height: 20,
              ),
              _isProcessing
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(25)),
                      child: TextButton(
                          onPressed: () {
                    
                            if (_addItemKey.currentState!.validate()) {
                              setState(() {
                                _isProcessing = true;
                              });

                        
                              var random= Random();
                              int randomInt= random.nextInt(100);
                              final newItem= Item(
                                name: _controllerTitle.text, 
                                id: randomInt.toString(), 
                                description: _controllerContent.text);
                              
                              BlocProvider.of<ItemBloc>(context).add(AddItem(item: newItem));
                             

                              setState(() {
                                _isProcessing = false;
                              });

                              Navigator.of(context).pop();
                        
                            }
                          },
                          child: Text(
                            'Add Item',
                            style: TextStyle(color: Colors.white),
                          )),
                    )
            ],
          ),
        ),
      ),
    );
  }

}