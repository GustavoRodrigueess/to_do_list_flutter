import 'package:flutter/material.dart';
import 'package:forgelist/CheckList.dart';
import 'package:forgelist/NewTask.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:forgelist/NewNote.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'avenir'
      ),
      home: homePage(),
    );
  }
}
class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  String filterType = "today";
  DateTime today = new DateTime.now();
  String taskPop  = "close";
  var monthNames = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEPT", "OCT", "NOV", "DEC"];
  CalendarController ctrlr = new CalendarController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  backgroundColor: Color(0xfff96060),
                  elevation: 0,
                  title: Text("Forge List", style: TextStyle(
                    fontSize: 30
                  ),),
                  actions: [
                    IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.short_text,
                      color: Colors.white,
                          size: 30,
                      ),
                    )
                  ],
                ),
                Container(
                  height: 70,
                  color: Color(0xfff96060),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: (){changeFilter("today");},
                            child: Text("Hoje", style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            ),),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 4,
                            width: 120,
                            color: (filterType== "today")?Colors.white:Colors.transparent,
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: (){changeFilter("monthly");},
                            child: Text("Mês", style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            ),),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 4,
                            width: 120,
                            color: (filterType == "monthly")?Colors.white:Colors.transparent,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                (filterType == "monthly")?TableCalendar(
                  calendarController: ctrlr,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  initialCalendarFormat: CalendarFormat.week,
                ):Container(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hoje ${monthNames[today.month-1]}, ${today.day}/${today.year}", style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey
                              ), )
                            ],
                          ),
                        ),
                        taskWidget(Color(0xfff96060), "Limpar a casa" , "7:00 AM"),
                        taskWidget(Colors.blue, "Tomar Remédio" , "9:00 AM"),
                        taskWidget(Colors.green, "Encontro" , "10:00 PM"),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 110,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: 90,
                            width: MediaQuery.of(context).size.width,
                          color: Color(0xff292e4e),
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 5,),
                                    Text("Tarefas", style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15
                                    ),)
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.menu,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 5,),
                                    Text("Menu", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15
                                    ),)
                                  ],
                                ),
                              ),
                              Container(width: 80,),
                              Container(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.content_paste,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 5,),
                                    Text("Notas", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15
                                    ),)
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.account_circle,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 5,),
                                    Text("Perfil", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15
                                    ),)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 25,
                        left: 0,
                        right: 0,
                        child: InkWell(
                          onTap: openTaskPop,
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [Color(0xfff96060), Colors.red],
                              ),
                              shape: BoxShape.circle
                            ),
                            child: Center(
                              child: Text("+", style: TextStyle(
                                fontSize: 40,
                                color: Colors.white
                              ),),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              child: (taskPop == "open") ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black.withOpacity(0.3),
                child: Center(
                  child: InkWell(
                    onTap: closeTaskPop,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white
                      ),
                      height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width*0.7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(height: 1,),
                          InkWell(
                            onTap: openNewTask,
                            child: Container(
                              child: Text("Add Tarefa", style: TextStyle(
                                fontSize: 18
                              ),),
                            ),
                          ),
                          Container(
                            height: 1,
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            color: Colors.black.withOpacity(0.2),
                          ),
                          InkWell(
                            onTap: openNewNote,
                            child: Container(
                              child: Text("Add Nota", style: TextStyle(
                                  fontSize: 18
                              ),),
                            ),
                          ),
                          Container(
                            height: 1,
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            color: Colors.black.withOpacity(0.2),
                          ),
                          InkWell(
                            onTap: openNewCheckList,
                            child: Container(
                              child: Text("Add Checklist", style: TextStyle(
                                  fontSize: 18
                              ),),
                            ),
                          ),
                          SizedBox(height: 1,)
                        ],
                      ),
                    ),
                  ),
                ),
              ):Container(),
            )
          ],
        ),
    );
  }
  openTaskPop()
  {
    taskPop = "open";
    setState(() {

    });
  }
  closeTaskPop()
  {
    taskPop = "close";
    setState(() {

    });
  }
  changeFilter(String filter)
  {
    filterType = filter;
    setState(() {

    });
  }
  Slidable taskWidget(Color color, String title, String time)
  {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.3,
      child: Container(
        height: 80,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(
            color: Colors.black.withOpacity(0.03),
            offset: Offset(0,9),
            blurRadius: 20,
            spreadRadius: 1
          )]
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: color,
                width: 4)
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: TextStyle(
                  color: Colors.black,
                  fontSize: 18
                ),),
                Text(time, style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18
                ),)
              ],
            ),
            Expanded(child: Container(),),
            Container(
              height: 50,
              width: 5,
              color: color,
            )
          ],
        ),
      ),
      secondaryActions: [
        IconSlideAction(
          caption: "Editar",
          color: Colors.white,
          icon: Icons.edit,
          onTap: (){},
        ),
        IconSlideAction(
          caption: "Deletar",
          color: color,
          icon: Icons.edit,
          onTap: (){},
        )
      ],
    );
  }
  openNewTask()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>NewTask()));
  }
  openNewNote()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>NewNote()));
  }
  openNewCheckList()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckList()));
  }
}
