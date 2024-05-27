import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
// import 'package:manage_finance/config/enums/bloc_status.dart';
// import 'package:manage_finance/config/enums/sort_status.dart';
// import 'package:manage_finance/features/home/models/student_model.dart';
// import 'package:manage_finance/features/settings/models/date_model.dart';
// import 'package:manage_finance/features/teachers/data/models/new_teacher_model.dart';
// import 'package:manage_finance/features/teachers/data/models/new_teacher_student_model.dart';
// import 'package:manage_finance/features/teachers/data/models/teacher_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  DBHelper();

  late Database database;

  final String databaseName = 'sqlite.db';
  final int databaseVersion = 1;  
  final String tableDate = 'date';
  int dateId = 1;
  int lastDateId = 1;

  // void restartDateId({required int dateID}) {
  //   dateId = dateID;
  // }

//   final String request =
//       '''SELECT student.name, student.date_id, sum(teacher.fees) from student
// LEFT JOIN teacher_student on student.id==teacher_student.student_id and student.date_id==teacher_student.date_id
// LEFT JOIN teacher on teacher.id==teacher_student.teacher_id and teacher.date_id==teacher_student.date_id
// WHERE student.date_id==1
// GROUP BY student.id, student.name
// ''';

  // opens the database (and creates if it do not exist)
  Future<void> init() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, databaseName);

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets/db", databaseName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    } else {}
    database = await openDatabase(
      path,
    );
  }

  // Future<List<StudentModel>> getStudents(
  //     {SortStatus? sortStatus}) async {
  //   log(dateId.toString());
  //   try {
  //     if (database.isOpen) {
  //       final response = await database.rawQuery(
  //         '''SELECT student.id, student.name,student.payment, student.days, student.payment_date, student.added_date, student.date_id, (sum(teacher.fees)+500000) AS fixedPayment from student
  //             LEFT JOIN teacher_student on student.id==teacher_student.student_id and student.date_id==teacher_student.date_id
  //             LEFT JOIN teacher on teacher.id==teacher_student.teacher_id and teacher.date_id==teacher_student.date_id
  //             WHERE student.date_id==$dateId
  //             GROUP BY student.id, student.name
  //             ORDER by  ${getStatusSort(sortStatus?? SortStatus.name)}''',
  //       );
  //       final listStudents = List<StudentModel>.from(response.map((e) {
  //         return StudentModel.fromJson(e);
  //       }));
  //       return listStudents;
  //     }
  //   } catch (e) {
  //     log("getSpeakingViewList", error: e.toString());
  //   }

  //   return [];
  // }

  // String getStatusSort(SortStatus status) {
  //   switch (status) {
  //     case SortStatus.name:
  //       return 'student.name';
  //     case SortStatus.nameDesc:
  //       return 'student.name desc';
  //     case SortStatus.payment:
  //       return 'student.payment';
  //     case SortStatus.paymentDesc:
  //       return 'student.payment desc';
  //     default:
  //       return 'student.name';
  //   }
  // }

  // Future<void> addNewTeacher({required NewTeacherModel teacherModel}) async {
  //   try {
  //     if (database.isOpen) {
  //       database.insert(
  //         tableTeacher,
  //         teacherModel.toJson(),
  //         conflictAlgorithm: ConflictAlgorithm.replace,
  //       );
  //       log("added teacher Id: ${teacherModel.dateId}");
  //     }
  //   } catch (e) {
  //     log("getSpeakingViewList", error: e.toString());
  //   }
  // }

  // Future<void> deleteTeacher({required TeacherModel teacherModel}) async {
  //   try {
  //     if (database.isOpen) {
  //       database.delete(tableTeacher, where: "id==${teacherModel.id}");
  //       database.delete(tableTeacherStuden,
  //           where: "teacher_id==${teacherModel.id}");
  //     }
  //   } catch (e) {
  //     log("getSpeakingViewList", error: e.toString());
  //   }
  // }

  // Future<List<TeacherModel>> getTEachers() async {
  //   try {
  //     if (database.isOpen) {
  //       log("dateID: $dateId");
  //       final response = await database.rawQuery(
  //         '''SELECT
  //               teacher.id,
  //               teacher.subject_name,
  //               teacher.name,
  //               teacher.fees,
  //               COUNT(student.id) AS pupils,
  //               sum((student.days/30.0 )*teacher.fees )as payment
  //           FROM
  //               teacher
  //           LEFT JOIN teacher_student ON teacher.id = teacher_student.teacher_id AND teacher.date_id==teacher_student.date_id
  //           LEFT JOIN student ON teacher_student.student_id = student.id AND teacher_student.date_id==student.date_id
  //           WHERE teacher.date_id==$dateId
  //           GROUP BY
  //               teacher.id, teacher.name;''',
  //       );
  //       final listTeachers = List<TeacherModel>.from(response.map((e) {
  //         return TeacherModel.fromJson(e);
  //       }));
  //       return listTeachers;
  //     }
  //   } catch (e) {
  //     log("getSpeakingViewList", error: e.toString());
  //   }
  //   return [];
  // }

  // Future<List<StudentModel>> getTeachersStudents({required int id}) async {
  //   try {
  //     if (database.isOpen) {
  //       final response = await database.rawQuery(
  //         '''SELECT * from student 
  //             WHERE id in 
  //             (SELECT student_id from teacher_student 
  //                   WHERE teacher_id==$id and date_id==$dateId)
  //             ''',
  //       );
  //       final listTeachers = List<StudentModel>.from(response.map((e) {
  //         return StudentModel.fromJson(e);
  //       }));
  //       return listTeachers;
  //     }
  //   } catch (e) {
  //     log("getSpeakingViewList", error: e.toString());
  //   }
  //   return [];
  // }

  // Future<List<NewStudentModel>> getNewTeachersStudents(
  //     {required int id}) async {
  //   try {
  //     if (database.isOpen) {
  //       final response = await database.rawQuery(
  //         '''SELECT id, name ,0 as inLesson FROM student WHERE id NOT in (SELECT student_id from teacher_student WHERE teacher_id==$id) and date_id==$dateId
  //             UNION
  //             SELECT id, name, 1 as inLesson from student WHERE id in (SELECT student_id from teacher_student WHERE teacher_id==$id) and date_id==$dateId
  //             ORDER BY name''',
  //       );
  //       final listStudents = List<NewStudentModel>.from(response.map((e) {
  //         return NewStudentModel.fromJson(e);
  //       }));
  //       return listStudents;
  //     }
  //   } catch (e) {
  //     log("getSpeakingViewList", error: e.toString());
  //   }
  //   return [];
  // }

  // Future<List<NewStudentModel>> addStudentForTeachers({
  //   required int teacherId,
  //   required int studentId,
  // }) async {
  //   try {
  //     if (database.isOpen) {
  //       database.insert(tableTeacherStuden, {
  //         "student_id": studentId,
  //         "teacher_id": teacherId,
  //         "date_id": dateId,
  //       });
  //     }
  //   } catch (e) {
  //     log("getSpeakingViewList", error: e.toString());
  //   }
  //   return [];
  // }

  // Future<void> setPayment(StudentModel studentModel) async {
  //   try {
  //     if (database.isOpen) {
  //       database.rawUpdate(
  //         '''
  //           UPDATE student 
  //           SET payment=${studentModel.payment}, 
  //             payment_date=${DateTime.now().millisecondsSinceEpoch}, 
  //             days=${studentModel.days} 
  //           WHERE id==${studentModel.id}''',
  //       );
  //     }
  //   } catch (e) {
  //     log("getSpeakingViewList", error: e.toString());
  //   }
  // }

  // Future<void> addNewStudent(StudentModel studentModel) async {
  //   try {
  //     if (database.isOpen) {
  //       database.insert(
  //         tableStudent,
  //         studentModel.toJson(),
  //         conflictAlgorithm: ConflictAlgorithm.replace,
  //       );
  //     }
  //   } catch (e) {
  //     log("getSpeakingViewList", error: e.toString());
  //   }
  // }

  // Future<void> deleteStudent(StudentModel studentModel) async {
  //   try {
  //     if (database.isOpen) {
  //       await database.insert(
  //         tableDeletedStudens,
  //         studentModel.toJson(isDeleted: true),
  //       );
  //       database.rawDelete("DELETE FROM student WHERE id==${studentModel.id};");
  //       deleteStudentFromTeacher(studentModel);
  //     }
  //   } catch (e) {
  //     log("getSpeakingViewList", error: e.toString());
  //   }
  // }

  // Future<void> deleteStudentFromTeacher(StudentModel studentModel) async {
  //   try {
  //     if (database.isOpen) {
  //       database.rawDelete(
  //           "DELETE from teacher_student WHERE student_id==${studentModel.id};");
  //     }
  //   } catch (e) {
  //     log("getSpeakingViewList", error: e.toString());
  //   }
  // }

  // Future<void> createNewMonth(DateModel dateModel, DateModel lastModel) async {
  //   try {
  //     if (database.isOpen) {
  //       lastDateId++;
  //       await database.insert(tableDate, dateModel.toJson());
  //       await database.rawInsert(
  //         '''INSERT INTO student(name, payment, days, date_id, payment_date, added_date)
  //                SELECT name, 0 as payment, 30 as days,$lastDateId  as date_id, 
  //                   added_date as payment_date, added_date 
  //                   FROM student 
  //                 WHERE date_id==${lastModel.id}''',
  //       );
  //       await database.rawInsert(
  //         '''INSERT INTO teacher(name, subject_name, date_id, fees) 
  //                 SELECT name, subject_name, $lastDateId as  date_id, fees 
  //                 from teacher 
  //                 WHERE date_id==${lastModel.id};''',
  //       );
  //       // await database.rawInsert(
  //       //   '''INSERT into teacher_student(teacher_id, student_id, date_id)
  //       //           SELECT teacher_id, student_id, $lastDateId AS date_id
  //       //           from teacher_student WHERE date_id==${lastModel.id};''',
  //       // );
  //       final result = await database.rawQuery("Select * from teacher_student");
  //       log(result.toString());
  //     }
  //   } catch (e) {
  //     log("getSpeakingViewList", error: e.toString());
  //   }
  // }

  // Future<List<DateModel>> getAllDates() async {
  //   try {
  //     if (database.isOpen) {
  //       final response = await database.rawQuery("SELECT * FROM date");
  //       List<DateModel> list =
  //           response.map((e) => DateModel.fromJson(e)).toList();
  //       lastDateId = list.last.id ?? 1;
  //       return list;
  //     }
  //   } catch (e) {
  //     log("getSpeakingViewList", error: e.toString());
  //   }
  //   return [];
  // }
}
