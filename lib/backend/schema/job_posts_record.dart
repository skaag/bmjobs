import 'dart:async';

import 'package:from_css_color/from_css_color.dart';
import '/backend/algolia/serialization_util.dart';
import '/backend/algolia/algolia_manager.dart';
import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class JobPostsRecord extends FirestoreRecord {
  JobPostsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "jobName" field.
  String? _jobName;
  String get jobName => _jobName ?? '';
  bool hasJobName() => _jobName != null;

  // "jobCompany" field.
  String? _jobCompany;
  String get jobCompany => _jobCompany ?? '';
  bool hasJobCompany() => _jobCompany != null;

  // "salary" field.
  String? _salary;
  String get salary => _salary ?? '';
  bool hasSalary() => _salary != null;

  // "jobDescription" field.
  String? _jobDescription;
  String get jobDescription => _jobDescription ?? '';
  bool hasJobDescription() => _jobDescription != null;

  // "timeCreated" field.
  DateTime? _timeCreated;
  DateTime? get timeCreated => _timeCreated;
  bool hasTimeCreated() => _timeCreated != null;

  // "jobLocation" field.
  LatLng? _jobLocation;
  LatLng? get jobLocation => _jobLocation;
  bool hasJobLocation() => _jobLocation != null;

  // "postedBy" field.
  DocumentReference? _postedBy;
  DocumentReference? get postedBy => _postedBy;
  bool hasPostedBy() => _postedBy != null;

  // "likedPost" field.
  bool? _likedPost;
  bool get likedPost => _likedPost ?? false;
  bool hasLikedPost() => _likedPost != null;

  // "jobRequirements" field.
  String? _jobRequirements;
  String get jobRequirements => _jobRequirements ?? '';
  bool hasJobRequirements() => _jobRequirements != null;

  // "jobPreferredSkills" field.
  String? _jobPreferredSkills;
  String get jobPreferredSkills => _jobPreferredSkills ?? '';
  bool hasJobPreferredSkills() => _jobPreferredSkills != null;

  // "companyLogo" field.
  String? _companyLogo;
  String get companyLogo => _companyLogo ?? '';
  bool hasCompanyLogo() => _companyLogo != null;

  // "photoHero" field.
  String? _photoHero;
  String get photoHero => _photoHero ?? '';
  bool hasPhotoHero() => _photoHero != null;

  // "myJob" field.
  bool? _myJob;
  bool get myJob => _myJob ?? false;
  bool hasMyJob() => _myJob != null;

  void _initializeFields() {
    _jobName = snapshotData['jobName'] as String?;
    _jobCompany = snapshotData['jobCompany'] as String?;
    _salary = snapshotData['salary'] as String?;
    _jobDescription = snapshotData['jobDescription'] as String?;
    _timeCreated = snapshotData['timeCreated'] as DateTime?;
    _jobLocation = snapshotData['jobLocation'] as LatLng?;
    _postedBy = snapshotData['postedBy'] as DocumentReference?;
    _likedPost = snapshotData['likedPost'] as bool?;
    _jobRequirements = snapshotData['jobRequirements'] as String?;
    _jobPreferredSkills = snapshotData['jobPreferredSkills'] as String?;
    _companyLogo = snapshotData['companyLogo'] as String?;
    _photoHero = snapshotData['photoHero'] as String?;
    _myJob = snapshotData['myJob'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('jobPosts');

  static Stream<JobPostsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => JobPostsRecord.fromSnapshot(s));

  static Future<JobPostsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => JobPostsRecord.fromSnapshot(s));

  static JobPostsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      JobPostsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static JobPostsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      JobPostsRecord._(reference, mapFromFirestore(data));

  static JobPostsRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      JobPostsRecord.getDocumentFromData(
        {
          'jobName': snapshot.data['jobName'],
          'jobCompany': snapshot.data['jobCompany'],
          'salary': snapshot.data['salary'],
          'jobDescription': snapshot.data['jobDescription'],
          'timeCreated': convertAlgoliaParam(
            snapshot.data['timeCreated'],
            ParamType.DateTime,
            false,
          ),
          'jobLocation': convertAlgoliaParam(
            snapshot.data,
            ParamType.LatLng,
            false,
          ),
          'postedBy': convertAlgoliaParam(
            snapshot.data['postedBy'],
            ParamType.DocumentReference,
            false,
          ),
          'likedPost': snapshot.data['likedPost'],
          'jobRequirements': snapshot.data['jobRequirements'],
          'jobPreferredSkills': snapshot.data['jobPreferredSkills'],
          'companyLogo': snapshot.data['companyLogo'],
          'photoHero': snapshot.data['photoHero'],
          'myJob': snapshot.data['myJob'],
        },
        JobPostsRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<JobPostsRecord>> search({
    String? term,
    FutureOr<LatLng>? location,
    int? maxResults,
    double? searchRadiusMeters,
    bool useCache = false,
  }) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'jobPosts',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
            useCache: useCache,
          )
          .then((r) => r.map(fromAlgolia).toList());

  @override
  String toString() =>
      'JobPostsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is JobPostsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createJobPostsRecordData({
  String? jobName,
  String? jobCompany,
  String? salary,
  String? jobDescription,
  DateTime? timeCreated,
  LatLng? jobLocation,
  DocumentReference? postedBy,
  bool? likedPost,
  String? jobRequirements,
  String? jobPreferredSkills,
  String? companyLogo,
  String? photoHero,
  bool? myJob,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'jobName': jobName,
      'jobCompany': jobCompany,
      'salary': salary,
      'jobDescription': jobDescription,
      'timeCreated': timeCreated,
      'jobLocation': jobLocation,
      'postedBy': postedBy,
      'likedPost': likedPost,
      'jobRequirements': jobRequirements,
      'jobPreferredSkills': jobPreferredSkills,
      'companyLogo': companyLogo,
      'photoHero': photoHero,
      'myJob': myJob,
    }.withoutNulls,
  );

  return firestoreData;
}

class JobPostsRecordDocumentEquality implements Equality<JobPostsRecord> {
  const JobPostsRecordDocumentEquality();

  @override
  bool equals(JobPostsRecord? e1, JobPostsRecord? e2) {
    return e1?.jobName == e2?.jobName &&
        e1?.jobCompany == e2?.jobCompany &&
        e1?.salary == e2?.salary &&
        e1?.jobDescription == e2?.jobDescription &&
        e1?.timeCreated == e2?.timeCreated &&
        e1?.jobLocation == e2?.jobLocation &&
        e1?.postedBy == e2?.postedBy &&
        e1?.likedPost == e2?.likedPost &&
        e1?.jobRequirements == e2?.jobRequirements &&
        e1?.jobPreferredSkills == e2?.jobPreferredSkills &&
        e1?.companyLogo == e2?.companyLogo &&
        e1?.photoHero == e2?.photoHero &&
        e1?.myJob == e2?.myJob;
  }

  @override
  int hash(JobPostsRecord? e) => const ListEquality().hash([
        e?.jobName,
        e?.jobCompany,
        e?.salary,
        e?.jobDescription,
        e?.timeCreated,
        e?.jobLocation,
        e?.postedBy,
        e?.likedPost,
        e?.jobRequirements,
        e?.jobPreferredSkills,
        e?.companyLogo,
        e?.photoHero,
        e?.myJob
      ]);

  @override
  bool isValidKey(Object? o) => o is JobPostsRecord;
}
