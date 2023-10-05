import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SavedJobsRecord extends FirestoreRecord {
  SavedJobsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "jobSaved" field.
  DocumentReference? _jobSaved;
  DocumentReference? get jobSaved => _jobSaved;
  bool hasJobSaved() => _jobSaved != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "savedTime" field.
  DateTime? _savedTime;
  DateTime? get savedTime => _savedTime;
  bool hasSavedTime() => _savedTime != null;

  void _initializeFields() {
    _jobSaved = snapshotData['jobSaved'] as DocumentReference?;
    _user = snapshotData['user'] as DocumentReference?;
    _savedTime = snapshotData['savedTime'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('savedJobs');

  static Stream<SavedJobsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SavedJobsRecord.fromSnapshot(s));

  static Future<SavedJobsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SavedJobsRecord.fromSnapshot(s));

  static SavedJobsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SavedJobsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SavedJobsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SavedJobsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SavedJobsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SavedJobsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSavedJobsRecordData({
  DocumentReference? jobSaved,
  DocumentReference? user,
  DateTime? savedTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'jobSaved': jobSaved,
      'user': user,
      'savedTime': savedTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class SavedJobsRecordDocumentEquality implements Equality<SavedJobsRecord> {
  const SavedJobsRecordDocumentEquality();

  @override
  bool equals(SavedJobsRecord? e1, SavedJobsRecord? e2) {
    return e1?.jobSaved == e2?.jobSaved &&
        e1?.user == e2?.user &&
        e1?.savedTime == e2?.savedTime;
  }

  @override
  int hash(SavedJobsRecord? e) =>
      const ListEquality().hash([e?.jobSaved, e?.user, e?.savedTime]);

  @override
  bool isValidKey(Object? o) => o is SavedJobsRecord;
}
