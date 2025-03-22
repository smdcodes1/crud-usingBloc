import 'package:bloc_example/logic/fetchlist/fetchlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Api Example 2',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        ),
        elevation: 0,
        backgroundColor: Colors.lightBlue,
      ),
      body: BlocBuilder<FetchlistBloc, FetchlistState>(builder: (context, state) {
        if (state is FetchlistInitial) {
          return Center(child: Text('please wait..'));
        } else if (state is FetchlistLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is FetchlistLoaded) {
          return  ListView.builder(
        itemCount: state.album.length,
        itemBuilder: (_, index) => Container(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Color(0xFFFF82EEFD),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.album[index].id.toString(),
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(state.album[index].title),
              ],
            ),
          ),
        ),
      );
        } else if (state is FetchlistError) {
          return Center(child: Text('Error: '+state.msg));
        } else {
          return SizedBox();
        }
      },)
     
    );
  }
}
