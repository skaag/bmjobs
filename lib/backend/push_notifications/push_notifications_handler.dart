import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';
import '../backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../index.dart';
import '../../main.dart';

final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    if (mounted) {
      setState(() => _loading = true);
    }
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        context.pushNamed(
          initialPageName,
          pathParameters: parameterData.pathParameters,
          extra: parameterData.extra,
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    handleOpenedPushNotification();
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Container(
          color: Colors.transparent,
          child: Center(
            child: Image.asset(
              'assets/images/splash@2x.png',
              width: MediaQuery.sizeOf(context).width * 1.0,
              fit: BoxFit.fitWidth,
            ),
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'Login': ParameterData.none(),
  'Register': ParameterData.none(),
  'CreateProfile': ParameterData.none(),
  'CompanyProfile': ParameterData.none(),
  'AddWorkExp': ParameterData.none(),
  'Onboarding': ParameterData.none(),
  'MAINHome': ParameterData.none(),
  'SEARCH_Jobs': ParameterData.none(),
  'MAINSavedJobs': ParameterData.none(),
  'MAIN_Candidates': ParameterData.none(),
  'SEARCH_Candidates': ParameterData.none(),
  'MAIN_MyProfile': ParameterData.none(),
  'MAIN_Chat': ParameterData.none(),
  'DETAILS_Chat': (data) async => ParameterData(
        allParams: {
          'chatUser': await getDocumentParameter<UsersRecord>(
              data, 'chatUser', UsersRecord.fromSnapshot),
          'chatRef': getParameter<DocumentReference>(data, 'chatRef'),
        },
      ),
  'JobPost_DetailsActual': (data) async => ParameterData(
        allParams: {
          'likedJob': getParameter<DocumentReference>(data, 'likedJob'),
          'jobPostDetails':
              getParameter<DocumentReference>(data, 'jobPostDetails'),
        },
      ),
  'JobPost_submitApplication': (data) async => ParameterData(
        allParams: {
          'jobPostDetails':
              getParameter<DocumentReference>(data, 'jobPostDetails'),
        },
      ),
  'JobPost_Applied': (data) async => ParameterData(
        allParams: {
          'application': await getDocumentParameter<AppliedJobsRecord>(
              data, 'application', AppliedJobsRecord.fromSnapshot),
          'jobPostDetails':
              getParameter<DocumentReference>(data, 'jobPostDetails'),
        },
      ),
  'JobPost_MyJob_Applicants': (data) async => ParameterData(
        allParams: {
          'jobPostDetails':
              getParameter<DocumentReference>(data, 'jobPostDetails'),
        },
      ),
  'forgotPassword': ParameterData.none(),
  'editProfile': (data) async => ParameterData(
        allParams: {
          'userProfile': getParameter<DocumentReference>(data, 'userProfile'),
        },
      ),
  'createJob': ParameterData.none(),
  'candidateDetails': (data) async => ParameterData(
        allParams: {
          'candidateDetails':
              getParameter<DocumentReference>(data, 'candidateDetails'),
        },
      ),
  'JobPost_Details': (data) async => ParameterData(
        allParams: {
          'likedJob': getParameter<DocumentReference>(data, 'likedJob'),
          'jobPostDetails':
              getParameter<DocumentReference>(data, 'jobPostDetails'),
        },
      ),
  'companyDetails': (data) async => ParameterData(
        allParams: {
          'companyDetails':
              getParameter<DocumentReference>(data, 'companyDetails'),
        },
      ),
  'HomePage_OLD': ParameterData.none(),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
