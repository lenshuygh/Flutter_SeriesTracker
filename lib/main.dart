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

  _MyHomePageState() {
    _fillSeriesTitles();
  }

  void _fillSeriesTitles() {
    _seriesTitles.add(_title('Star Trek: Picard', DateTime.parse("2020-01-23"),
        "assets/images/icons/picard.jpg"));
    _seriesTitles.add(_title('The New Pope', DateTime.parse("2020-01-23"),
        "assets/images/icons/theNewPope.jpg"));
    _seriesTitles.add(_title('Westworld', DateTime.parse("2016-10-02"),
        "assets/images/icons/westworld.jpg"));
  }

  void _addSeriesEntry() {
    Toast.show("Adding title...", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    setState(() {
      _seriesTitles.add(_title(
          'New Series', DateTime.now(), "assets/images/icons/westworld.jpg"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => (_seriesTitles.elementAt(index)),
          separatorBuilder: (context, index) => Divider(
                color: Colors.black12,
              ),
          itemCount: _seriesTitles.length),

      floatingActionButton: FloatingActionButton(
        onPressed: _addSeriesEntry,
        tooltip: 'Add series',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods
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
              fontSize: 9,
            )),
        leading: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 44,
            minHeight: 44,
            maxWidth: 64,
            maxHeight: 64,
          ),
          child: Image.asset(imageUrl, fit: BoxFit.cover),
        ),
        onTap: () {
          Toast.show("Clicked on " + title, context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        },
        onLongPress: () {
          _removeFromList(title);
        },
      );

  void _removeFromList(String title) {
    var index = -1;
    Text txt;
    for (var i = 0; i < _seriesTitles.length; i++) {
      txt = _seriesTitles[i].title;
      if (txt.data == title) {
        index = i;
        break;
      }
    }
    setState(() {
      _seriesTitles.removeAt(index);
    });
  }
}
