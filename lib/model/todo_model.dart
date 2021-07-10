import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class Todo extends Equatable {
  final bool complete;
  final String? id;
  final String note;

  Todo({this.complete = false, String note = '', String? id})
      : this.note = note,
        this.id = id ?? Uuid().v4();

  Todo copyWith({bool? complete, String? note, String? id}) {
    return Todo(
      complete: complete ?? this.complete,
      note: note ?? this.note,
      id: id ?? this.id,
    );
  }

  @override
  List<Object> get props => [complete, id!, note];

  @override
  String toString() {
    return 'Todo { complete: $complete, note: $note, id: $id }';
  }

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
  Map<String, dynamic> toJson() => _$TodoToJson(this);
}
