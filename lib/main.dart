import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Series Tracker',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: MyHomePage(title: 'Series Tracker'),
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
  final List<ListTile> _seriesTitles = <ListTile>[];
  final dateFormat = new DateFormat('dd/MM/yyyy');
  int _counter = 0;

  void _fillSeriesTitles() {
    _seriesTitles.add(_title('Star Trek: Picard', DateTime.parse("2020-01-23"),
        "assets/images/icons/picard.jpg"));
    _seriesTitles.add(_title('The New Pope', DateTime.parse("2020-01-23"),
        "assets/images/icons/theNewPope.jpg"));
    _seriesTitles.add(_title('Westworld', DateTime.parse("2016-10-02"),
        "assets/images/icons/westworld.jpg"));
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      print('CLICK' + _counter.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    _fillSeriesTitles();
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView(
          children: _seriesTitles
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Add series',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  ListTile _title(String title, DateTime startDate, String imageUrl) =>
      ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(dateFormat.format(startDate),
            style: TextStyle(
              fontSize: 11,
            )),
        leading: CircleAvatar(backgroundImage: AssetImage(imageUrl)),
        onTap: () {
          /*setState(() {
            print(title);
          });*/
          Toast.show("Clicked on " + title, context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        },
        onLongPress: () {
          setState(() {});
        },
      );
}