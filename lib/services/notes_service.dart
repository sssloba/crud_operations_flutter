import 'dart:convert';

import 'package:crud_operations_flutter/models/api_response.dart';
import 'package:crud_operations_flutter/models/note_for_listing.dart';
import 'package:http/http.dart' as http;

class NotesService {

  static const API = 'http://api.notes.programmingaddict.com';
  static const headers = {
    'apiKey' : '73283363-1e34-4eb8-8c62-c593ebb1410d'
  };

  Future<APIResponse<List<NoteForListing>>> getNotesList() {
    return http.get(API + '/notes', headers: headers)
    .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NoteForListing>[];
        for (var item in jsonData) {
          final note = NoteForListing(
            noteID: item['noteID'],
            noteTitle: item['noteTitle'],
            createDateTime: DateTime.parse(item['createDateTime']),
            latestEditDateTime: item['latestEditDateTime'] !=null ? DateTime.parse(item['latestEditDateTime'])
            :null,
          );
          notes.add(note);
        }
        return APIResponse<List<NoteForListing>>(
          data: notes
        );
      }
      return APIResponse<List<NoteForListing>>(
        error: true,
        errorMessage: 'An error occured'
      );
    })
    .catchError((_) => APIResponse<List<NoteForListing>>(error: true, errorMessage: 'An error occured'));
  }
}