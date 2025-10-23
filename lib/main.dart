import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'NoteBLoC.dart';
import 'NoteState.dart';
import 'NoteEvent.dart';





void main() {
  runApp( NotePage());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
          create: (_) => NoteBLoC() ,
          child: NotePage()),
    );
  }
}


class NotePage extends StatelessWidget {

  final TextEditingController TitleController = TextEditingController();
  final TextEditingController DescriptionController = TextEditingController();
  String selectedCategory = 'other';
  final List<DropdownMenuItem<String>> categories = [
    const DropdownMenuItem(
      value: 'work',
      child: Text('work'),
    ),
    const DropdownMenuItem(
      value: 'personal',
      child: Text('personal'),
    ),
    const DropdownMenuItem(
      value: 'shopping',
      child: Text('shopping'),
    ),
    const DropdownMenuItem(
      value: 'other',
      child: Text('other'),
    ),
  ];


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final noteBloc = BlocProvider.of<NoteBLoC>(context);

    return MaterialApp(

      home:Scaffold(
        appBar: AppBar(
          title: const Text('Note App with BLoC'),
        ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: TitleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: DescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),

              ),
            ),
            DropdownButton(
                value: selectedCategory,
                items: categories,
                onChanged: (data) {
                  if(data != null){
                    selectedCategory = data;
                  }
                }
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if(),
                noteBloc.add(AddNote(
                    TitleController.text,
                    DescriptionController.text,
                    selectedCategory
                ));
              },
              child: const Text('Add Note'),
          ],
        ),
      ),
    );
  }
}


