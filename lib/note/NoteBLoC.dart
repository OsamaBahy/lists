import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management_to_do_list/note/NoteState.dart';
import 'package:state_management_to_do_list/note/NoteEvent.dart';

class NoteBLoC extends Bloc<NoteEvent, NoteState>{
  NoteBLoC() : super(NoteState(notes: [])){

    on<AddNote>(
            (event, emit){
          final addedNote = List<note>.from(state.notes)..add(note(title: event.title, description: event.description, category: event.category));

          emit(NoteState(notes: addedNote));
        }
    );

      on<RemoveNote>(
          (event, emit){
            final removeNote = List<note>.from(state.notes)..removeAt(event.index);

            emit(NoteState(notes: removeNote));
          }
      );
  }
}