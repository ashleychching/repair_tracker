import 'package:flutter/material.dart';
import 'report.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFFEFAE0),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: currentPageIndex == 0 || currentPageIndex == 1  // Show header only for Home and Report pages
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical:50),
                color: const Color(0xFFFEFAE0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo on the left
                    Image.asset(
                      'assets/images/FIXCITYWORD.png',  // Replace with your logo path
                      height: 30,  // Adjust size of logo
                    ),
                    // Profile image on the right
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('assets/profile.jpg'), // Replace with your profile image path
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: NavigationBar(
          backgroundColor: const Color(0xFFDDA15E),
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: const Color(0xFF606C38), // Light green
          indicatorShape: const CircleBorder(), // Circle shape for indicator

          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home, color: Colors.white),
              icon: Icon(Icons.home_outlined, color: Colors.white),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.add, color: Colors.white),
              icon: Icon(Icons.add, color: Colors.white),
              label: '',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.account_circle, color: Colors.white),
              icon: Icon(Icons.account_circle_outlined, color: Colors.white),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: <Widget>[
        /// Home page
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text(
                'Home page',
                style: theme.textTheme.titleLarge,
              ),
            ),
          ),
        ),

        /// report page
        const ReportFormPage(),

        /// Profile page
        ListView.builder(
          reverse: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Hello',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.colorScheme.onPrimary),
                  ),
                ),
              );
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Hi!',
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: theme.colorScheme.onPrimary),
                ),
              ),
            );
          },
        ),
      ][currentPageIndex],
    );
  }
}

class ReportFormPage extends StatefulWidget {
  const ReportFormPage({super.key});

  @override
  ReportFormPageState createState() => ReportFormPageState();
}

class ReportFormPageState extends State<ReportFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Declare controllers for each form field
  final _titleController = TextEditingController();
  final _commentController = TextEditingController();
  final _addressController = TextEditingController();

  // Submit form
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Create a Report instance when form is submitted
      Report newReport = Report(
        _titleController.text,
        _commentController.text,
        _addressController.text,
        null,  // No latitude
        null,  // No longitude
        [],    // Handle images if needed
      );

      // Do something with the Report (e.g., save or print it)
      print("Report Submitted: ${newReport.title}");
    }
  }

  @override
  void dispose() {
    // Dispose of controllers to avoid memory leaks
    _titleController.dispose();
    _commentController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _commentController,
              decoration: const InputDecoration(
                labelText: 'Comment',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a comment';
                }
                return null;
              },
              maxLines: 5, // Make the comment box taller
              minLines: 3, // Set a minimum height
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Submit Report'),
            ),
          ],
        ),
      ),
    );
  }
}