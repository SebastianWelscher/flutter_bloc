import 'package:flutter/material.dart';
import 'controller/employeeBloC.dart';
import 'model/employee.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.orange,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter BloC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
                   return Card(
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
                   );
                 });
          },
        ),
      ),
    );
  }
}