// import 'dart:convert';
// import 'dart:js_interop';
// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestRESTHomePage extends StatefulWidget {
  @override
  _TestRESTHomePageState createState() => _TestRESTHomePageState();
}

class _TestRESTHomePageState extends State<TestRESTHomePage> {
  TextEditingController _urlController = TextEditingController();
  String _selectedMethod = 'GET';
  List<String> _responses = [];

  Future<void> fetchData(String url, String method) async {
    // final response = await Dio().get(url);
    // final data = response.data as Map<String, dynamic>;

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

    // if (response == null) {
    //   return _responses.add('Error: ');
    // } else {
      if (response.statusCode == 200) {
        setState(() {
          // if (response == null) {
          //   return _responses.add('Error: ');
          // } else {
          // _responses.add(json.decode(response.body).toString());
          _responses.add(response.body.toString());
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
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP Request'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
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
            // child: Icon(Icons.send),
            child: const Text('Send request'),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _responses.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Response ${index + 1}: $_selectedMethod : ${_urlController.text}'),
                  subtitle: Text(_responses[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // void dispose() {
  //   _urlController.dispose();
  //   super.dispose();
  // }
}