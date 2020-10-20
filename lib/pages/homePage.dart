import 'package:flutter/material.dart';
import 'package:flutter_bloc/controller/employeeBloC.dart';
import 'package:flutter_bloc/model/employee.dart';
import 'package:flutter_bloc/pages/detailsPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  EmployeeBloC _employeeBloC = EmployeeBloC();

  @override
  void dispose() {
    _employeeBloC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Container(
        child: StreamBuilder(
          stream: _employeeBloC.employeeListStream,
          builder: (BuildContext context, AsyncSnapshot<List<Employee>> snapshot){
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(
                        builder: (context)=> DetailsPage(
                          id: snapshot.data[index].id,
                          name: snapshot.data[index].name,
                          salary: snapshot.data[index].salary,))),
                    child: Card(
                      elevation: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Text('${snapshot.data[index].id}.',
                              style: TextStyle(fontSize: 20),),
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${snapshot.data[index].name}',
                                  style: TextStyle(fontSize: 18),),
                                Text('${snapshot.data[index].salary} €',
                                  style: TextStyle(fontSize: 16),),
                              ],
                            ),
                          ),
                          Container(
                            child: IconButton(
                              icon: Icon(Icons.thumb_up,
                                color: Colors.green,),
                              onPressed: ()=> _employeeBloC.employeeSalaryIncrementStreamController.add(snapshot.data[index]),
                            ),
                          ),
                          Container(
                            child: IconButton(
                              icon: Icon(Icons.thumb_down,
                                color: Colors.red,),
                              onPressed: ()=> _employeeBloC.employeeSalaryDecrementStreamController.add(snapshot.data[index]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}