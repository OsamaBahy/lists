import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'note/NoteBLoC.dart';
import 'note/NoteState.dart';
import 'note/NoteEvent.dart';





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
  final List<String> categories = ['work', 'personal', 'other'];


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
                items: categories.map(
                    (value){
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }
                ).toList(),
                onChanged: (data) {
                  if(data != null){
                    selectedCategory = data;
                  }
                }
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if(TitleController.text.isNotEmpty && DescriptionController.text.isNotEmpty){
                noteBloc.add(AddNote(
                    TitleController.text,
                    DescriptionController.text,
                    selectedCategory
                ));
                TitleController.clear();
                DescriptionController.clear();
                }
              },
              child: const Text('Add Note'),
            ),
            SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<NoteBLoC, NoteState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.notes.length,
                    itemBuilder: (context, index) {
                    final note = state.notes[index];
                      return Card(
                        child: ListTile(
                          title: Text(note.title),
                          subtitle: Text('${note.description} ||  ${note.category}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              noteBloc.add(RemoveNote(index));
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


