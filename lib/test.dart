import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController textEditingController = TextEditingController();
  String tokenForSession = "37465";
  List<dynamic> listForPlace = [];
  void makeSuggestion(String input)async {
    String apiKey = "AIzaSyAI9kPkskayYti5ttrZL_UfBlL3OkMEbvs";
    String groundUrl ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$groundUrl?input=$input&key=$apiKey&sessiontoken=$tokenForSession';

    var response = await http.get(Uri.parse(request));
    var resultData = response.body.toString();

    if(response.statusCode == 200){
      setState(() {
        listForPlace = jsonDecode(response.body.toString())['predictions'];
        print(listForPlace);
      });
    }else{
      throw Exception("Fail");
    }
  }


  void onModify(){
    if(tokenForSession == ""){
      setState(() {
        tokenForSession = Uuid().v4();
      });
    }
    makeSuggestion(textEditingController.text);
  }

  @override
  void initState(){
    super.initState();
    textEditingController.addListener(() {
      makeSuggestion(textEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
          ),
          TextFormField(
            onChanged: (value){
              onModify();
            },
            controller: textEditingController,
            decoration: const InputDecoration(
              hintText: "Search"
            ),
          ),
          Expanded(child: ListView.builder(
              itemCount: listForPlace.length,
              itemBuilder: (context, index){
            return listForPlace[index]['description'];
          }))
        ],
      ),
    );
  }
}


