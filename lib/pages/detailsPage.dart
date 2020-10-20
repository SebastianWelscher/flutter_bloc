import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {

  int id;
  String name;
  double salary;

  DetailsPage({this.id,this.name,this.salary});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Detail'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text(id.toString()),
              SizedBox(height: 10,),
              Text(name),
              SizedBox(height: 10,),
              Text('${salary}'),
            ],
          ),
        ),
      ),
    );
  }
}