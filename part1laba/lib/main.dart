--- a/lib/main.dart;
+++ b/lib/main.dart;

@@ -1,82 +1,93 @@
 import 'package:flutter/material.dart';
+ import 'package:provider/provider.dart';
 
 import 'screen1.dart';
 import 'screen2.dart';
 import 'screen3.dart';
 import 'screen4.dart';
 
 void main() {
-  runApp(const MyApp());
+  runApp(
+    ChangeNotifierProvider(
+      create: (_) => TabModel(),
+      child: const MyApp(),
+    ),
+  );
+}
+
+class TabModel extends ChangeNotifier {
+  int _currentIndex = 0;
+
+  int get currentIndex => _currentIndex;
+
+  void setIndex(int index) {
+    if (index == _currentIndex) return;
+    _currentIndex = index;
+    notifyListeners();
+  }
 }
 
 class MyApp extends StatelessWidget {
   const MyApp({super.key});
 
   // This widget is the root of your application.
   @override
   Widget build(BuildContext context) {
     return const MaterialApp(
       debugShowCheckedModeBanner: false,
       home: BottomNavLab(),
     );
   }
 }
 
-class BottomNavLab extends StatefulWidget {
+class BottomNavLab extends StatelessWidget {
   const BottomNavLab({super.key});
 
-  @override
-  State<BottomNavLab> createState() => _BottomNavLabState();
-}
-
-class _BottomNavLabState extends State<BottomNavLab> {
-  int currentIndex = 0;
-
-  final List<Widget> screens = const [
+  static const List<Widget> screens = [
     Screen1(),
     Screen2(),
     Screen3(),
     Screen4(),
   ];
 
   @override
   Widget build(BuildContext context) {
+    final currentIndex = context.watch<TabModel>().currentIndex;
+
     return Scaffold(
       appBar: AppBar(
         title: const Text ('Lab 05 Exercise A'),
         foregroundColor: Colors.white,
       ),
       body: screens[currentIndex],
       bottomNavigationBar: BottomNavigationBar(
         type: BottomNavigationBarType.fixed,
         fixedColor: Colors.white,
         backgroundColor: Colors.blue,
         iconSize: 30,
         currentIndex: currentIndex,
         onTap: (int index) {
-          setState(() {
-            currentIndex = index;
-          });
+          context.read<TabModel>().setIndex(index);
         },
         items: const [
           BottomNavigationBarItem(
             icon: Icon(Icons.home),
             label: 'Home',
           ),
           BottomNavigationBarItem(
             icon: Icon(Icons.alarm),
             label: 'Alarm',
           ),
           BottomNavigationBarItem(
             icon: Icon(Icons.business),
             label: 'Business',
           ),
           BottomNavigationBarItem(
             icon: Icon(Icons.school),
             label: 'School',
           ),
         ],
       ),
     );
   }
 }