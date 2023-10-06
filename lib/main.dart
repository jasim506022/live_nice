import 'package:flutter/material.dart';

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
        // the application has a blue toolbar. Then, without quitting the app,
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
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class ButtonData {
  String size;
  bool isSelected;

  ButtonData(this.size, this.isSelected);
}

class _HomeScreenState extends State<HomeScreen> {
  List<ButtonData> buttons = [
    ButtonData("S", false),
    ButtonData("M", false),
    ButtonData("L", false),
    ButtonData("XL", false),
    ButtonData("XXL", false),
    ButtonData("XXXL", false),
  ];

  int selectedButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Size Selector'),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            bool isSmallScreen = constraints.maxWidth < 600;
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: buttons.asMap().entries.map((entry) {
                  int index = entry.key;
                  ButtonData button = entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          for (int i = 0; i < buttons.length; i++) {
                            buttons[i].isSelected = (i == index);
                          }
                        });

                        String selectedSize = buttons[index].size;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Selected Size: $selectedSize'),
                          ),
                        );
                      },
                      child: Text(
                        button.size,
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          button.isSelected ? Colors.yellow : Colors.grey,
                        ),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(
                            vertical: isSmallScreen ? 8.0 : 16.0,
                            horizontal: isSmallScreen ? 16.0 : 32.0,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ));
  }
}
