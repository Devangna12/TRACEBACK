import 'package:flutter/material.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  // ==================== USER STATE ====================
  String _currentUserId = '';
  String get currentUserId => _currentUserId;
  set currentUserId(String value) {
    _currentUserId = value;
    notifyListeners();
  }

  String _currentUserRole = 'Volunteer';
  String get currentUserRole => _currentUserRole;
  set currentUserRole(String value) {
    _currentUserRole = value;
    notifyListeners();
  }

  String _currentUserName = '';
  String get currentUserName => _currentUserName;
  set currentUserName(String value) {
    _currentUserName = value;
    notifyListeners();
  }

  String _currentUserEmail = '';
  String get currentUserEmail => _currentUserEmail;
  set currentUserEmail(String value) {
    _currentUserEmail = value;
    notifyListeners();
  }

  // ==================== REPORT DATA ====================
  List<dynamic> _reports = [];
  List<dynamic> get reports => _reports;
  set reports(List<dynamic> value) {
    _reports = value;
    notifyListeners();
  }

  void updateReports(List<dynamic> newReports) {
    _reports = newReports;
    notifyListeners();
  }

  void addReport(dynamic report) {
    _reports.add(report);
    notifyListeners();
  }

  // ==================== CURRENT SELECTED DATA ====================
  String _selectedReportId = '';
  String get selectedReportId => _selectedReportId;
  set selectedReportId(String value) {
    _selectedReportId = value;
    notifyListeners();
  }

  Map<String, dynamic> _selectedReport = {};
  Map<String, dynamic> get selectedReport => _selectedReport;
  set selectedReport(Map<String, dynamic> value) {
    _selectedReport = value;
    notifyListeners();
  }

  String _selectedPersonId = '';
  String get selectedPersonId => _selectedPersonId;
  set selectedPersonId(String value) {
    _selectedPersonId = value;
    notifyListeners();
  }

  // ==================== CHAT STATE ====================
  List<dynamic> _channels = [];
  List<dynamic> get channels => _channels;
  set channels(List<dynamic> value) {
    _channels = value;
    notifyListeners();
  }

  String _activeChannelId = '';
  String get activeChannelId => _activeChannelId;
  set activeChannelId(String value) {
    _activeChannelId = value;
    notifyListeners();
  }

  List<dynamic> _chatMessages = [];
  List<dynamic> get chatMessages => _chatMessages;
  set chatMessages(List<dynamic> value) {
    _chatMessages = value;
    notifyListeners();
  }

  // ==================== FILTERS & SEARCH ====================
  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  set searchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  String _filterStatus = 'ALL';
  String get filterStatus => _filterStatus;
  set filterStatus(String value) {
    _filterStatus = value;
    notifyListeners();
  }

  String _channelFilter = 'ACTIVE';
  String get channelFilter => _channelFilter;
  set channelFilter(String value) {
    _channelFilter = value;
    notifyListeners();
  }

  // ==================== UTILITY METHODS ====================
  Future<void> initializeAppData() async {
    // Load initial data from Firebase
    // await fetchUserData();
    // await fetchReports();
    // await fetchChannels();
  }

  void clearSelectedData() {
    _selectedReportId = '';
    _selectedReport = {};
    _selectedPersonId = '';
    notifyListeners();
  }

  void clearChatData() {
    _activeChannelId = '';
    _chatMessages = [];
    notifyListeners();
  }

  void resetAppState() {
    _currentUserId = '';
    _currentUserRole = 'Volunteer';
    _currentUserName = '';
    _currentUserEmail = '';
    _reports = [];
    _selectedReportId = '';
    _selectedReport = {};
    _selectedPersonId = '';
    _channels = [];
    _activeChannelId = '';
    _chatMessages = [];
    _searchQuery = '';
    _filterStatus = 'ALL';
    _channelFilter = 'ACTIVE';
    notifyListeners();
  }
}
