import 'package:fastcampus/counter.dart';
import 'package:fastcampus/daynote.dart';
import 'package:fastcampus/mise.dart';
import 'package:fastcampus/weather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_){
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(
          Colors.black.value,
          <int, Color>{
            50: Colors.black,
            100: Colors.black,
            200: Colors.black,
            300: Colors.black,
            400: Colors.black,
            500: Colors.black,
            600: Colors.black,
            700: Colors.black,
            800: Colors.black,
            900: Colors.black,
          },
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WeatherPage(),
    );
  }
}
List<Color> colors = [
  Color(0xFF80d3f4),
  Color(0xFFa794fa),
  Color(0xFFfb91d1),
  Color(0xFFfb8a94),
  Color(0xFFfebd9a),
  Color(0xFF51e29d),
  Color(0xFFFFFFFF),
];
List<String> categories = [
  "운동",
  "공부"
];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Todo> todo = [
  ];
  List<Todo> histories = [
    Todo(id: 1, title: "책 2권 읽기", done: false, memo: "부의 추월차선 읽기", color: 0xFFFFFFFF),
    Todo(id: 2, title: "헬스 2시간", done: false, memo: "어깨 운동", color: colors[0].value),
    Todo(id: 3, title: "헬스 1시간", done: false, memo: "다리 운동", color:  colors[1].value),
    Todo(id: 4, title: "헬스 4시간", done: false, memo: "가슴 운동", color: colors[2].value),
    Todo(id: 5, title: "헬스 3시간", done: false, memo: "등 운동", color: colors[3].value),
  ];
  int tapIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    todo = [
      Todo(id: 1, title: "책 2권 읽기", done: false, memo: "부의 추월차선 읽기", date: getFormatTime(DateTime.now())
          , color: colors[0].value
      ),
      Todo(id: 2, title: "헬스 2시간", done: false, memo: "어깨 운동", date: getFormatTime(DateTime.now())
          , color: colors[0].value
      ),
    ];
    histories = [
      Todo(id: 1, title: "책 2권 읽기", done: false, memo: "부의 추월차선 읽기", date: getFormatTime(DateTime.now().subtract(Duration(days: 1)))
          , color: colors[0].value
      ),
      Todo(id: 2, title: "헬스 2시간", done: false, memo: "어깨 운동", date: getFormatTime(DateTime.now().subtract(Duration(days: 1)))
          , color: colors[1].value
      ),
      Todo(id: 3, title: "헬스 1시간", done: true, memo: "다리 운동", date: getFormatTime(DateTime.now().subtract(Duration(days: 2)))
          , color: colors[2].value
      ),
      Todo(id: 4, title: "헬스 4시간", done: true, memo: "가슴 운동", date: getFormatTime(DateTime.now().subtract(Duration(days: 2)))
          , color: colors[3].value
      ),
      Todo(id: 5, title: "헬스 3시간", done: true, memo: "등 운동", date: getFormatTime(DateTime.now().subtract(Duration(days: 2)))
          , color: colors[3].value
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Color(0xfffefefe),
      appBar: PreferredSize(child: AppBar(brightness: Brightness.light, backgroundColor: Color(0xfffefefe), elevation: 0,),
        preferredSize: Size.fromHeight(0),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "오늘"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined),
              label: "기록"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz_outlined),
              label: "더보기"
          ),
        ],
        currentIndex: tapIndex,
        onTap: (idx){
          setState(() {
            tapIndex = idx;
          });
        },
      ),
      body: getPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final _todo = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TodoWritePage(todo: Todo(
                  id: 2, title: "", memo: "", done: false
              ))));
          if(_todo != null){
            setState(() {
              todo.add(_todo);
            });
          }
        },
        tooltip: 'Increment',
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.black,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getPage() {
    if (tapIndex == 0) {
      return ListView.builder(
        itemBuilder: (ctx, idx) {
          if (idx == 0) {
            return Container(
              alignment: Alignment.centerLeft,
              child: Text("오늘 하루", style: TextStyle(fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
              margin: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            );
          }
          else if (idx == 1) {
            final t = todo.where((t) => !t.done).toList();
            return Container(
                child: Column(children: List.generate(t.length, (index) {
                  return InkWell(child: mainCard(t[index]),
                      onLongPress: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TodoWritePage(todo: t[index])));
                        setState(() {});
                      },
                      onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("${t[index].title}완료 하셨나요?"),
                            content: Text("완료하셨다면 예를 눌러주세요"),
                            actions: [
                              TextButton(child: Text("아니오"), onPressed: () {
                                setState(() {
                                  t[index].done = false;
                                });
                                Navigator.of(context).pop();
                              },),
                              TextButton(child: Text("예"), onPressed: () {
                                setState(() {
                                  t[index].done = true;
                                });
                                Navigator.of(context).pop();
                              },),
                            ],
                          );
                        });
                  });
                }),
                ));
          }
          else if (idx == 2) {
            return Container(
              alignment: Alignment.centerLeft,
              child: Text("완료된 하루", style: TextStyle(fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
              margin: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            );
          }
          else if (idx == 3) {
            final t = todo.where((t) => t.done).toList();
            return Container(
                child: Column(children: List.generate(t.length, (index) {
                  return InkWell(child: mainCard(t[index]), onLongPress: () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TodoWritePage(todo: t[index])));
                    setState(() {});
                  },onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("${t[index].title}완료 하셨나요?"),
                            content: Text("완료하셨다면 예를 눌러주세요"),
                            actions: [
                              TextButton(child: Text("아니오"), onPressed: () {
                                setState(() {
                                  t[index].done = false;
                                });
                                Navigator.of(context).pop();
                              },),
                              TextButton(child: Text("예"), onPressed: () {
                                setState(() {
                                  t[index].done = true;
                                });
                                Navigator.of(context).pop();
                              },),
                            ],
                          );
                        });
                  });
                }),
                ));
          }
          else if (idx == 2) {
            // TextEditingController _titleController = TextEditingController();
            // return TextField(
            //   onTap: (){
            //     print("abcd");
            //   },
            //   controller: _titleController,
            //   style: TextStyle(color: Colors.black),
            //   keyboardType: TextInputType.emailAddress,
            //   onChanged: (v){
            //
            //   },
            //   onSubmitted: (v){
            //
            //   },
            // );
          }
          return Container();
        },
        itemCount: 5,
      );
    }else if(tapIndex == 1){
      return Container(
        child: ListView.builder(
          itemBuilder: (ctx, idx){
            final hi = groupBy(histories, (Todo obj) => "${obj.date}").entries.toList();
            return Container(
              child: Column(
                children: List.generate(hi.length, (_idx){
                  final m = hi[_idx];
                  final d = stringToDateTime(m.key);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(m.value.length + 1, (__idx){
                      if(__idx == 0){
                        return Container(child: Text("${d.month}월 ${d.day}일", style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold
                        ),), margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),);
                      }else{
                        final h = m.value[__idx - 1];
                        return mainCard(h);
                      }
                    }),
                  );
                  // return _idx;
                }),
              ),
            );
          },
          itemCount: 1,
        ),
      );
    }else if(tapIndex == 2){
      return Container(
        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: ListView.builder(itemBuilder: (ctx, idx){
          return ListTile(
            title: Text("카테고리 설정"),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CategoryPage()));

            },
          );
        },
        itemCount: 1,),
      );
    }else{
      return Container();
    }
  }

  Widget mainCard(Todo t){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      decoration: BoxDecoration(
          color: Color(t.color),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.transparent),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.03),
                offset: Offset(3.5, 3.5))
          ]

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(t.title, style: TextStyle(fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
              Container(child: Text(t.done ? "완료" : "미완료",
                style: TextStyle(
                    fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),),
                decoration: BoxDecoration(
                  color: Color(t.color),
                  borderRadius: BorderRadius.circular(18),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                    vertical: 6.0, horizontal: 0),
              )
            ],
          ),
          Container(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Text(t.memo, style: TextStyle(fontSize: 14, color: Colors.white),),
            Text(t.category ?? "", style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),),
          ])
        ],
      ),
    );
  }

  int getFormatTime(DateTime date) {
    return int.parse(
        "${date.year}${makeTwoDigit(date.month)}${makeTwoDigit(date.day)}");
  }

  String getFormatTimeWithHour(DateTime date) {
    return "${date.year}${makeTwoDigit(date.month)}${makeTwoDigit(date.day)}${makeTwoDigit(date.hour)}${makeTwoDigit(date.minute)}";
  }

  static String makeTwoDigit(int number) {
    return number.toString().padLeft(2, '0');
  }

  DateTime stringToDateTime(String date) {
    int year = int.parse(date.substring(0, 4));
    int month = int.parse(date.substring(4, 6));
    int day = int.parse(date.substring(6, 8));

    return DateTime(year, month, day);
  }
}

class Todo {
  int id;
  int date;
  int color;
  bool done;
  String title;
  String memo;
  String category;

  Todo({this.id, this.date, this.color, this.memo, this.category, this.title, this.done});
}
class CategoryPage extends StatefulWidget {
  final String title;
  CategoryPage({Key key, this.title}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(""),
        actions: [
        ],
      ),
      body: ListView.builder(itemBuilder: (ctx, idx){
        return ListTile(
          title: Text(categories[idx]),
          trailing: Icon(Icons.arrow_forward_ios_outlined),
        );
      },
        itemCount: categories.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final c =  await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CategoryWritePage(title: "",)));
          if(c != null){
            if(!categories.contains(c)){
              setState(() {
                categories.add(c);
              });
            }
          }
        },
      ),
    );

  }
}

class CategoryWritePage extends StatefulWidget {
  final String title;
  CategoryWritePage({Key key, this.title}) : super(key: key);

  @override
  _CategoryWritePageState createState() => _CategoryWritePageState();
}

class _CategoryWritePageState extends State<CategoryWritePage> {
  TextEditingController _titleController = TextEditingController();
  String get title => widget.title ?? "";

  @override
  void initState() {
    _titleController.text = widget.title ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(""),
          actions: [
            TextButton(
              child: Text("저장", style: TextStyle(color: Colors.white),),
              onPressed: (){
                Navigator.of(context).pop(_titleController.text);
              },
            )
          ],
        ),
        body: ListView.builder(
            itemCount: 3,
            itemBuilder: (ctx, idx){
              if(idx == 0){
                return Container(
                  margin: EdgeInsets.only(top: 32, left: 20, right: 20),
                  alignment: Alignment.centerLeft,
                  child: Text("카테고리 이름", style: TextStyle(fontSize: 18, color: Colors.black)),
                );
              }
              else if(idx == 1) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    onTap: (){},
                    controller: _titleController,
                    style: TextStyle(color: Colors.black),
                    keyboardType: TextInputType.text,
                    onChanged: (v){
                    },
                    onSubmitted: (v){

                    },
                  ),
                );
              }else {
                return Container();
              }
            })
    );
  }
}
class TodoWritePage extends StatefulWidget {
  final Todo todo;
  TodoWritePage({Key key, this.todo}) : super(key: key);

  @override
  _TodoWritePageState createState() => _TodoWritePageState();
}

class _TodoWritePageState extends State<TodoWritePage> {
  Todo get todo => widget.todo;
  // Todo todo  = Todo(id: 1, title: "asdfasdf", memo: "", done: false);
  TextEditingController _titleController = TextEditingController();
  TextEditingController _memoController = TextEditingController();

  @override
  void initState() {
    _titleController.text = todo.title ?? "";
    _memoController.text = todo.memo ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(""),
        actions: [
          TextButton(
            child: Text("저장", style: TextStyle(color: Colors.white),),
            onPressed: (){
              Navigator.of(context).pop(todo);
            },
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (ctx, idx){
          if(idx == 0){
            return Container(
              margin: EdgeInsets.only(top: 32, left: 20, right: 20),
              alignment: Alignment.centerLeft,
              child: Text("제목", style: TextStyle(fontSize: 18, color: Colors.black)),
            );
          }
          else if(idx == 1) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onTap: (){
                },
                controller: _titleController,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.emailAddress,
                onChanged: (v){
                  todo.title = v;
                },
                onSubmitted: (v){

                },
              ),
            );
          }
          else if(idx == 2){
            return Container(child: ListTile(
              title: Text("색상", style: TextStyle(fontSize: 18, color: Colors.black)),
              trailing: Container(width: 20, height: 20, color: Color(todo.color ?? colors[0].value)),
              onTap: (){
                showDialog(
                    context: context,
                    builder: (ctx){
                      return AlertDialog(
                        backgroundColor: Color(0xFFfefefe),
                        content: Container(child: GridView.count(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 5, childAspectRatio: 1,
                          children: List.generate(colors.length, (_idx){
                            return InkWell(child: Container(color: colors[_idx],),
                              onTap: (){
                                setState(() {
                                  todo.color = colors[_idx].value;
                                  Navigator.of(context).pop();
                                });
                              },);
                          }),), width: 300,),
                      );
                    }
                );
              },
            ),
              margin: EdgeInsets.only(top: 16),
            );
          }
          else if(idx == 3){
            return Container(child: ListTile(
              title: Text("카테고리", style: TextStyle(fontSize: 18, color: Colors.black)),
              trailing: Text(todo.category ?? ""),
              onTap: (){
                showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return _buildBottomPicker(
                          _buildCategoryPicker());
                    });
              },
            ),
              margin: EdgeInsets.only(top: 16),
            );
          }
          else if(idx == 4){
            return Container(
              margin: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              alignment: Alignment.centerLeft,
              child: Text("내용", style: TextStyle(fontSize: 18, color: Colors.black)),
            );
          }
          else if(idx == 5) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: TextField(
                controller: _memoController,
                maxLines: 10,
                minLines: 10,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    border: OutlineInputBorder()
                ),
                onChanged: (v){
                  todo.memo = v;
                },
                onSubmitted: (v){},
              ),
            );
          }

          return Container();
        },
        itemCount: 6,
      ),
    );
  }

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: 200,
      padding: const EdgeInsets.only(top: 6.0, bottom: 50),
      color: Colors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: Colors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryPicker() {
//    var localizations = CupertinoLocalizations.of(context);
    return CupertinoPicker(
      scrollController:
      FixedExtentScrollController(initialItem: 0),
      itemExtent: 40,
      backgroundColor: Colors.white,
      onSelectedItemChanged: (int index) {
        setState(() {
          todo.category = categories[index];
        });
      },
      children: List<Widget>.generate(categories.length, (int index) {
        return Semantics(
          excludeSemantics: true,
          child: Container(
            child: Container(
              // Adds some spaces between words.
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Text("${categories[index]}",
                  style: TextStyle()),
            ),
          ),
        );
      }),
    );
  }
}
