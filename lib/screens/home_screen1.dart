import 'package:bloc_example/logic/item/item_bloc.dart';
import 'package:bloc_example/screens/additem_screen.dart';
import 'package:bloc_example/screens/edititem_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen1 extends StatelessWidget {
  const HomeScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE8E8E8),
      appBar: AppBar(
        title: Text(
          'CRUD Sample',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        ),
        elevation: 0,
        backgroundColor: Colors.cyan,
      ),
      body: BlocBuilder<ItemBloc, ItemState>(builder: (context, state) {
        if (state is ItemLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ItemLoaded) {
          return   ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(
                height: 9,
              ),
          itemCount: state.items.length,
          itemBuilder: (context, index) {
            String userid = state.items[index].id;
            String title =
                state.items[index].name.toString();
            String description =
                state.items[index].description.toString();
            // String url= snapshot.data!.docs[index]['image'];
            return Padding(
              padding: const EdgeInsets.all(9),
              child: ListTile(
                
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blueGrey.shade400,
                  // backgroundImage: NetworkImage(''),
                
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => editItemPage(
                                  userId: userid, 
                                  currenttitle: title, 
                                  currentdescription: description)
                              ));
                        },
                        icon: Icon(
                          Icons.edit_sharp,
                          color: Colors.black,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                           BlocProvider.of<ItemBloc>(context).add(DeleteItem(id: userid.toString()));
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ))
                  ],
                ),
                textColor: Colors.black,
                title: Text(
                  title,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  description,
                  style: TextStyle(color: Colors.black),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                tileColor: Colors.white,
                selectedTileColor: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide.none),
            
              ),
            );
          });
        } else if (state is ItemError) {
          return Text("Error: "+state.message);
        } else {
          return Center(child: SizedBox());
        }
      },),
    
    floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => addItemPage(),
              ));
        },
        shape: CircleBorder(side: BorderSide.none),
        backgroundColor: Colors.cyan,
        child: Center(
            child: Icon(
          Icons.add,
          color: Colors.white,
        )),
      ),
    );
  }
}
