import 'dart:math';

class SecretQuestionsModel {
  final int id;
  final String questionText;

  SecretQuestionsModel({
    this.id,
    this.questionText,
  });

  ///Object to map
  Map<String, dynamic> toMap() => {
        'id': id,
        'questionText': questionText,
      };

  ///Map to object
  factory SecretQuestionsModel.fromMap(Map map) => SecretQuestionsModel(
        id: map['id'],
        questionText: map['questionText'],
      );
}
