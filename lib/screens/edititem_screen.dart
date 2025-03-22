
import 'package:bloc_example/item_model.dart';
import 'package:bloc_example/logic/item/item_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class editItemPage extends StatefulWidget {
  editItemPage(
      {super.key,
      required this.userId,
      required this.currenttitle,
      required this.currentdescription});

  String userId;
  String currenttitle;
  String currentdescription;

  @override
  State<editItemPage> createState() => _editItemPageState();
}

class _editItemPageState extends State<editItemPage> {
  
  // bool _isDeleting = false;

  bool _isProcessing = false;

  GlobalKey<FormState> _updateItemKey = GlobalKey();

  TextEditingController _controllerTitle = TextEditingController();

  TextEditingController _controllerContent = TextEditingController();

  @override
  void initState() {
    _controllerTitle.text= widget.currenttitle;
    _controllerContent.text= widget.currentdescription;
    super.initState();
  }
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
        key: _updateItemKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              editItemForm(
                controllerTitle: _controllerTitle,
                controllerContent: _controllerContent,
                updateItemKey: _updateItemKey,
              ),
              SizedBox(
                height: 40,
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
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(25)),
                      child: TextButton(
                          onPressed: () async {
                            if (_updateItemKey.currentState!.validate()) {
                              setState(() {
                                _isProcessing = true;
                              });
                             
                              
                              final item= Item(
                                name: _controllerTitle.text, 
                                id: widget.userId, 
                                description: _controllerContent.text);
                              context.read<ItemBloc>().add(UpdateItem(updatedItem: item));

                              setState(() {
                                _isProcessing = false;
                              });
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text(
                            'Update Item',
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

class editItemForm extends StatelessWidget {
  editItemForm(
      {super.key,
      required this.controllerTitle,
      required this.controllerContent,
      required this.updateItemKey,
      });
  

  TextEditingController controllerTitle= TextEditingController();

  TextEditingController controllerContent= TextEditingController();

   GlobalKey<FormState> updateItemKey= GlobalKey();

  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'please enter ur title';
              }
              return null;
            },
            controller: controllerTitle,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              hintText: 'Enter the Title',
              labelText: 'Title',
              disabledBorder: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            maxLines: 1,
            autofocus: true,
          ),
        ),
        SizedBox(
          height: 20,
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
            controller: controllerContent,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              hintText: 'Enter the Description',
              labelText: 'Description',
              disabledBorder: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            maxLines: 4,
          ),
        ),

      
      ],
    );
  }
}