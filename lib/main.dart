import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(TestREST());
}

class TestREST extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP Request',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _urlController = TextEditingController();
  String _selectedMethod = 'GET';
  List<String> _responses = [];

  Future<void> fetchData(String url, String method) async {
    http.Response response;
    switch (method) {
      case 'GET':
        response = await http.get(Uri.parse(url));
        break;
      case 'POST':
        response = await http.post(Uri.parse(url));
        break;
      case 'DELETE':
        response = await http.delete(Uri.parse(url));
        break;
      case 'UPDATE':
        response = await http.put(Uri.parse(url));
        break;
      default:
        response = await http.get(Uri.parse(url));
    }

    if (response == null) {
      return _responses.add('Error: ');
    } else {
      if (response.statusCode == 200) {
        setState(() {
          // if (response == null) {
          //   return _responses.add('Error: ');
          // } else {
          _responses.add(json.decode(response.body).toString());
          // }
        });
      } else {
        setState(() {
          // if (response == null) {
          //   return _responses.add('Error: ');
          // } else {
          _responses.add('Error: ${response.statusCode}');
          // }
        });
      }
      // } else {
      //   return _responses.add('Error: ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP Request'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedMethod,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedMethod = newValue!;
                      });
                    },
                    items: ['GET', 'POST', 'DELETE', 'UPDATE']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: _urlController,
                    decoration: InputDecoration(labelText: 'Enter URL'),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              fetchData(_urlController.text, _selectedMethod);
            },
            child: Text('Send request'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _responses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Response ${index + 1}:'),
                  subtitle: Text(_responses[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }
}
