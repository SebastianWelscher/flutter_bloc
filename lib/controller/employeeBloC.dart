import 'dart:async';
import 'package:flutter_bloc/model/employee.dart';

class EmployeeBloC{

  List<Employee> _employeeList = [
    Employee(1, 'Employee 1', 10000),
    Employee(2, 'Employee 2', 20000),
    Employee(3, 'Employee 3', 30000),
    Employee(4, 'Employee 4', 40000),
    Employee(5, 'Employee 5', 50000),
  ];

  final _employeeListStreamController = StreamController<List<Employee>>();
  final _employeeSalaryIncrementStreamController = StreamController<Employee>();
  final _employeeSalaryDecrementStreamController = StreamController<Employee>();

  //getters

  Stream<List<Employee>> get employeeListStream => _employeeListStreamController.stream;
  StreamSink<List<Employee>> get employeeListSink => _employeeListStreamController.sink;
  StreamSink<Employee> get employeeSalaryIncrementStreamController => _employeeSalaryIncrementStreamController.sink;
  StreamSink<Employee> get employeeSalaryDecrementStreamController => _employeeSalaryDecrementStreamController.sink;

  //construtor

  EmployeeBloC(){
    _employeeListStreamController.add(_employeeList);
    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }

  //core functions

  _incrementSalary(Employee employee){
    double salary = employee.salary;
    double incrementSalary = salary * 20/100;
    _employeeList[employee.id -1].salary = salary + incrementSalary;
    employeeListSink.add(_employeeList);
  }

  _decrementSalary(Employee employee){
    double salary = employee.salary;
    double decrementSalary = salary * 20/100;
    _employeeList[employee.id -1].salary = salary - decrementSalary;
    employeeListSink.add(_employeeList);
  }

  void dispose(){
    _employeeListStreamController.close();
    _employeeSalaryIncrementStreamController.close();
    _employeeSalaryDecrementStreamController.close();
  }

}