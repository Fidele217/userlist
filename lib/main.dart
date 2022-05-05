
import 'package:flutter/material.dart';
import 'package:tp_flutter_ifri_2022/models/json-data.dart';
import 'package:tp_flutter_ifri_2022/pages/form.dart';

main() => runApp(MaterialApp(
  debugShowMaterialGrid: false,
  routes: {"/form":(context) => MyCustomForm(),},
  home: MyApp(),
  theme: ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.orange,
    ),
  ),
  debugShowCheckedModeBanner: false,
));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final data = Data();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Affichage"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, i) {
            return Container(
              width: 350,
              //SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spa,
                // crossAxisAlignment:CrossAxisAlignment.stretch,
                children: [

                  Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 0, 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            //color: Colors.orange,
                            // width: 350,
                            padding: EdgeInsets.fromLTRB(250, 0, 0, 0),
                            child: CircleAvatar(
                              backgroundImage: AssetImage("images/profile.png"),
                              radius: 35,
                            ),
                          ),
                          Text('Name: ${data.products[i]['lastname']}'),
                          Text('First name: ${data.products[i]['firstname']}'),
                          Text('Dbo: ${data.products[i]['birthday']}'),
                          Text('Email: ${data.products[i]['mail']}'),
                          Text('Gender: ${data.products[i]['gender']}'),
                          Text('" ${data.products[i]['citation']}"'),
                        ]),
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.white, Colors.orange]),
              ),
            );
          },
          itemCount: data.products.length,
        ),
      ),

      bottomNavigationBar:ElevatedButton(onPressed: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, "/form");
      }, child: Text("Page suivante"), ),
    );
  }
}
