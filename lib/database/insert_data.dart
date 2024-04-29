// -- Inserting Videos for material
import 'package:learn_toefl/database/toefl_database.dart';

void insertVideos() async {
  final db = await ToeflDatabase.instance.database;

  //Memasukkan SubCategory
  await db.execute("INSERT INTO SubCategory (name) VALUES ('Material')");
  await db.execute("INSERT INTO SubCategory (name) VALUES ('Grammar')");

  //Memasukkan Category
  await db.execute(
      "INSERT INTO VideoCategory (name, subCategory_id) VALUES ('Listening', 1)");
  await db.execute(
      "INSERT INTO VideoCategory (name, subCategory_id) VALUES ('Speaking', 1)");
  await db.execute(
      "INSERT INTO VideoCategory (name, subCategory_id) VALUES ('Reading', 1)");
  await db.execute(
      "INSERT INTO VideoCategory (name, subCategory_id) VALUES ('Writing', 1)");
  await db.execute(
      "INSERT INTO VideoCategory (name, subCategory_id) VALUES ('Grammar', 2)");

  //Memasukkan Video Listening
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('Introduction to the TOEFL Listening Section', 'LW6ArsK4cG8', 1)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('TOEFL Listening Practice (Lecture Recording)', 'p8KPgM24k-w', 1)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('TOEFL Tuesday: 3 Tips for Better Listening Notes', '0ObB_n-g2vE', 1)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('TOEFL Tuesday: How to Improve English Listening Skills', '4AjZa1Ltjh4', 1)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('TOEFL Listening Practice Test', 'jSUh0Civuv4', 1)");
  //Memasukkan Video Speaking
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('Introduction to the TOEFL Speaking Section', 'WA2xN7BHMrI', 2)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('TOEFL Speaking Question 1 (With Sample Questions)', 'nL0rFI6IrF0', 2)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('TOEFL Speaking Question 4', 'sP35Yo_e8jw', 2)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('TOEFL Tuesday: Speaking Sample Answer - Task 3', 'kBAM72qzbXk', 2)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('TOEFL Tuesday: Speaking & Writing Templates', 'E14vwfLLZmM', 2)");
  //Memasukkan Video Reading
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('Introduction to the TOEFL Reading Section', 'kFHAYLo33T0', 3)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('TOEFL Reading Tip: Pacing', 'v62eN1CyBEU', 3)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('TOEFL Tuesday: Reading Tip - Actor and Action', '314R4DYhVx0', 3)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('TOEFL Lesson: How to Scan the Text', 'w55ztsgjk1o', 3)");
  //Memasukkan Video Writing
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('TOEFL Writing Section Overview', 'iU-ovcaX2Ik', 4)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('How to Structure Your TOEFL Essay 2015', 'nGBzJ3y3IN8', 4)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('TOEFL Writing Question 2 (Sample Questions)', 'bt4drqbA5Xo', 4)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('TOEFL Tuesday: The WORST Writing Mistake', 'GerjUpGYxqQ', 4)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('TOEFL Writing ULTIMATE Guide', 'DfdYu5vXqg0', 4)");
  //Memasukkan Video Grammar
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('Subject', '8svyqZjgbMg', 5)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('Subject and Verb', 'Z8chUfgvnV8', 5)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('Direct Object', 'oV6IlN4GVXo', 5)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('Intransitive Verbs', 'kzMjgZFhSb0', 5)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('Indirect Object', '5SGezzsGQkQ', 5)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('Prepositional Phrases', 'yo5Ugrj0RD0', 5)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('Fragments vs. Sentences', 'OuaA1xLpS_0', 5)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('Dependent Clauses', 'JuaUWtzSGpo', 5)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('Past Tense', 'pXYhXGDOw48', 5)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('Past Tense Irregular', '2kTzFoyzf0o', 5)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('Future Tense', '27OzI23wFEU', 5)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('Past Perfect', 'uIF1SQFCLQc', 5)");
  await db.execute(
      "INSERT INTO Video (name, url, video_category_id) VALUES ('Present Perfect', 'olwUz4qkA2c', 5)");
}

