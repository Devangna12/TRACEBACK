# Dynamic Pages Implementation Guide - TraceBack App

## ✅ What's Been Implemented

Your Flutter app now has a complete **dynamic page connection system** with:

### 1. **Global State Management** (`FFAppState`)
Centralized store for:
- User information
- Report data and selection
- Chat channels and messages
- Search & filter states

### 2. **DataService** (`lib/backend/services/data_service.dart`)
Unified Firebase access with:
- Real-time streams for auto-updates
- Filtering and search capabilities
- Single report/user/chat lookups

### 3. **Updated Pages**
- **Dashboard**: Dynamic reports with live filtering
- **PersonDetails**: Single report with real-time sync
- **ChatHub**: Channel management with state binding
- **ChatRoom**: Active channel tracking

### 4. **Smart Navigation** 
Routes now pass data efficiently:
- Path params for IDs: `reportId`
- Extra data for full objects: `reportData`
- Global state automatically synced

---

## 🚀 How to Use in Your App

### Load Data When Page Opens
```dart
@override
void initState() {
  super.initState();
  _model = createModel(context, () => YourPageModel());
  _loadData();
}

void _loadData() async {
  final data = await _dataService.fetchSomething();
  context.read<FFAppState>().updateSomething(data);
}
```

### Listen to State Changes
```dart
@override
Widget build(BuildContext context) {
  return Consumer<FFAppState>(
    builder: (context, appState, _) {
      return ListView.builder(
        itemCount: appState.reports.length,
        itemBuilder: (context, index) {
          return Text(appState.reports[index].name);
        },
      );
    },
  );
}
```

### Navigate with Data
```dart
context.pushNamed(
  TargetPageWidget.routeName,
  pathParameters: {'id': item.id},
  extra: {'data': item.toMap()},
);
```

### Update State from Filters
```dart
InkWell(
  onTap: () {
    context.read<FFAppState>().filterStatus = 'URGENT';
  },
  child: Text('Filter by Urgent'),
)
```

---

## 📋 To Apply This Pattern to Other Pages

### Step 1: Import DataService
```dart
import '/backend/services/data_service.dart';
```

### Step 2: Add to State Class
```dart
class _YourPageWidgetState extends State<YourPageWidget> {
  final DataService _dataService = DataService();
  // ... rest of code
}
```

### Step 3: Load Data in initState
```dart
@override
void initState() {
  super.initState();
  _model = createModel(context, () => YourPageModel());
  _loadPageData();
}

void _loadPageData() async {
  try {
    final data = await _dataService.fetchYourData();
    if (mounted) {
      context.read<FFAppState>().updateYourData(data);
    }
  } catch (e) {
    print('Error loading data: $e');
  }
}
```

### Step 4: Use Consumer for Real-time Updates
```dart
@override
Widget build(BuildContext context) {
  return Consumer<FFAppState>(
    builder: (context, appState, _) {
      return StreamBuilder(
        stream: _dataService.yourDataStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          
          final data = snapshot.data;
          return ListView(...);
        },
      );
    },
  );
}
```

---

## 🔗 Key Files to Reference

1. **[app_state.dart](../lib/app_state.dart)** - Global state definitions
2. **[data_service.dart](../lib/backend/services/data_service.dart)** - Firebase queries
3. **[dashboard_widget.dart](../lib/pages/dashboard/dashboard_widget.dart)** - Best practice example
4. **[person_details_widget.dart](../lib/pages/person_details/person_details_widget.dart)** - Stream usage example
5. **[nav.dart](../lib/flutter_flow/nav/nav.dart)** - Navigation with data passing

---

## 🎯 Common Patterns

### Pattern 1: List with Filtering
```dart
final filtered = appState.items
    .where((item) => item.status == appState.filterStatus)
    .toList();
```

### Pattern 2: Real-time Single Item
```dart
StreamBuilder<ItemRecord?>(
  stream: _dataService.itemStream(itemId),
  builder: (context, snapshot) {
    final item = snapshot.data;
    return item != null ? DisplayItem(item) : ErrorWidget();
  },
)
```

### Pattern 3: Search + Filter Combined
```dart
final filtered = items
    .where((item) {
      if (appState.searchQuery.isEmpty) return true;
      return item.name.contains(appState.searchQuery);
    })
    .where((item) => item.status == appState.filterStatus)
    .toList();
```

---

## 📝 Next Steps

1. **Apply DataService to remaining pages** (FileAReport, MapView, Admin Panel, etc.)
2. **Add more state properties** as needed (pagination, sorting, user preferences)
3. **Implement real-time search** with debouncing for better performance
4. **Add data persistence** with Hive or SharedPreferences for offline support
5. **Create custom hooks** for common data fetching patterns

---

## ⚡ Performance Tips

- Use `Selector<FFAppState, List>()` instead of `Consumer` when listening to single properties
- Avoid rebuilding entire screens - use `Consumer` at leaf widget level
- Implement pagination in DataService for large lists
- Use StreamBuilder for real-time data, regular FutureBuilder for one-time fetches
- Clear large data sets when navigating away to free memory

---

## 🐛 Troubleshooting

**Problem**: Data not updating when I change filters
- **Solution**: Ensure you're using `context.read<FFAppState>().filterStatus = value;` to trigger notifyListeners()

**Problem**: StreamBuilder keeps rebuilding
- **Solution**: Check if DataService stream is emitting duplicate values

**Problem**: Navigation params not passing to widget
- **Solution**: Verify widget constructor accepts the parameters and initState stores them

---

## 📚 Resources

- [Provider Documentation](https://pub.dev/packages/provider)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Cloud Firestore Queries](https://firebase.flutter.dev/docs/firestore/usage)
- [Flutter Streams & StreamBuilder](https://dart.dev/guides/libraries/async-await)
