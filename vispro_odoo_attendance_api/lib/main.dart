import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'dart:async';

final orpc = OdooClient('http://localhost:8069/');
void main() async {
  await orpc.authenticate('test2313', 'admin', '!N9X\$*w5Np3s');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  Future<dynamic> fetchContacts() {
    return orpc.callKw({
      'model': 'res.partner',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [],
        'fields': ['id', 'name', 'email', '__last_update', 'image_128'],
        'limit': 10,
      },
    });
  }


  Widget buildListItem(Map<String, dynamic> record) {
    var unique = record['__last_update'] as String;
    unique = unique.replaceAll(RegExp(r'[^0-9]'), '');
    final avatarUrl =
        '${orpc.baseURL}/web/image?model=res.partner&field=image_128&id=${record["id"]}&unique=$unique';
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(avatarUrl)),
      title: Text(record['name']),
      subtitle: Text(record['email'] is String ? record['email'] : ''),
    );
  }

  void refreshData(){
    fetchContacts().then((data)  {
      setState((){
      });
    }).catchError((error) {
      print('Error fetching data: $error');
    });
  }

  late Timer _timer;
  @override
  void initState(){
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer){
      refreshData();
    });
  }

  @override
  void dispose(){
    super.dispose();
    _timer.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: fetchContacts(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          final record =
                          snapshot.data[index] as Map<String, dynamic>;
                          return buildListItem(record);
                        });
                  } else {
                    if (snapshot.hasError) return Text('Unable to fetch data');
                    return CircularProgressIndicator();
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: refreshData,
              child: Text('Refresh Data'),
            ),
          ),
        ],
      ),
    );
  }
}