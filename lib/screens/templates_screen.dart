import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'dart:async' show Future;

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:app_demo_weva/models/templates.dart';

class TemplatesScreen extends StatefulWidget {
  static String routeName = "/temp";
  @override
  _TemplatesScreenState createState() => _TemplatesScreenState();
}

Future<String> _loadData() async {
  return await rootBundle.loadString('assets/templates.json');
}

class _TemplatesScreenState extends State<TemplatesScreen> {
  Future getData;
  Future loadData() async {
    String jsonString = await _loadData();
    final jsonResponse = json.decode(jsonString);
    TemplateFile templateFile = new TemplateFile.fromJson(jsonResponse);
    print('${templateFile.templates[1].name} - ${templateFile.templates[1].description}');
  }

  void initState() {
    super.initState();
    getData = loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('CHOOSE A TEMPLATE',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: Colors.grey,
              letterSpacing: 1.2,
            ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Center(
            child: FutureBuilder<String>(
              future: _loadData(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  print("nope");
                  return Center(child: CircularProgressIndicator());
                }
                else {
                  print(snapshot.data);
                  return Container(child: _albumGridView(snapshot.data, context));
                }
              },
            )
        ),
      ),
    );
  }
}

GridView _albumGridView(String data, BuildContext context) {
  var size = MediaQuery.of(context).size;

  /*24 is for notification bar on Android*/
  final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
  final double itemWidth = size.width / 2;

  var list = jsonDecode(data)['templates'] as List;
  List<Template> templatesList = list.map((templates) => Template.fromJson(templates)).toList();
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: (itemWidth / itemHeight),),
    itemCount: list.length,
    padding: EdgeInsets.all(2.0),
    itemBuilder: (BuildContext context, int index) {
      return _tile(templatesList[index].name, templatesList[index].description, templatesList[index].image);
    },
  );
}

GridTile _tile(String name, String description, String image) => GridTile(
    child: InkWell(
        onTap: () => print("click"),
        child: Wrap(
          children: [
            Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ], borderRadius: BorderRadius.all(Radius.circular(3))
                    ),
                    child: Wrap(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Image.asset(image, fit: BoxFit.contain),
                          ),
                          Container(
                            child: Text(name,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                )),
                          ),
                          Container(
                            child: Text(description,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                )),
                          )
                        ]
                    )
                )
            ),
          ],
        )
    )
);
