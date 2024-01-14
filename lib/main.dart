import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppState extends ChangeNotifier {
  String currentFontFamily = "Lora";
  double currentFontSize = 28;
  Color currentFontColor = Colors.red;
  List<Widget> textList = [];

  Map<String, Color> colorMap = {
    "red": Colors.red,
    "blue": Colors.blue,
    "yellow": Colors.yellow,
    "green": Colors.green,
    "purple": Colors.purple,
    "black": Colors.black,
    "pink": Colors.pink,
    // Add more color mappings as needed
  };
  void updateFontColor(String newColor) {
    currentFontColor = colorMap[newColor.toLowerCase()] ?? Colors.black;
    notifyListeners();
  }

  void updateFontSize(double newSize) {
    currentFontSize = newSize;
    notifyListeners();
  }

  void updateFontFamily(String newFontFamily) {
    currentFontFamily = newFontFamily;
    notifyListeners();
  }

  void addTextList() {
    textList.add(SelectedText());
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // color: Colors.red,
                height: 0.8 / 10 * screenHeight,
                width: screenWidth,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => {},
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.undo), // Icon for undo
                            Text(
                              'Undo',
                              style: TextStyle(
                                  fontFamily: "Lora",
                                  fontWeight: FontWeight.w700),
                            ), // Text for undo
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => {},
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.redo), // Icon for undo
                            Text(
                              'Redo',
                              style: TextStyle(
                                  fontFamily: "Lora",
                                  fontWeight: FontWeight.w700),
                            ), // Text for undo
                          ],
                        ),
                      ),
                    ]),
              ),
              Container(
                child: Center(child: Consumer<AppState>(
                  builder: (context, appState, child) {
                    return Stack(
                      children: appState.textList,
                    );
                  },
                )),
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                decoration: (BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.blue[50],
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black45,
                      offset: Offset(0, 2), // Set the shadow offset (x, y)
                      blurRadius: 5.0, // Set the blur radius
                      spreadRadius: 1.0, // Set the spread radius
                    ),
                  ],
                )),
                height: 7 / 10 * screenHeight,
                width: screenWidth,
              ),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FontFamilyDropdownApp(),
                  FontSizeDropdownApp(),
                  FontColorDropdownApp(),
                ],
              )),
            ],
          ),
        )),
      ),
      appBar: AppBar(
        title: Text(
          "My Text Editor",
          style: TextStyle(color: Colors.blue[50], fontFamily: "Lora"),
        ),
        backgroundColor: Colors.blue[600],
      ),
      floatingActionButton: Container(
        margin:
            EdgeInsets.fromLTRB(0, 0, 0, 10.0), // Adjust the margin as needed
        child: FloatingActionButton(
          onPressed: () {
            Provider.of<AppState>(context, listen: false).addTextList();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

List<double> fontSizes = [
  2,
  4,
  6,
  8,
  10,
  12,
  14,
  16,
  18,
  20,
  22,
  24,
  26,
  28,
  30
];

List<String> fontFamilies = [
  "Lora",
  "Poppins-LightItalic",
  "Poppins-Bold",
  "Poppins-Medium",
  "Roboto-Black",
  "Roboto-Bold",
  "Roboto-Italic",
];

List<String> fontColors = [
  "red",
  "green",
  "blue",
  "yellow",
  "purple",
  "black",
  "pink",
];

class FontSizeDropdownApp extends StatelessWidget {
  const FontSizeDropdownApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Font Size", style: TextStyle(color: Colors.deepPurple)),
          FontSizeDropdownExample()
        ],
      ),
      margin: EdgeInsets.all(10.0),
    );
  }
}

class FontSizeDropdownExample extends StatefulWidget {
  const FontSizeDropdownExample({super.key});

  @override
  State<FontSizeDropdownExample> createState() =>
      _FontSizeDropdownExampleState();
}

class _FontSizeDropdownExampleState extends State<FontSizeDropdownExample> {
  double dropdownValue = 20.0;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<double>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (double? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
        Provider.of<AppState>(context, listen: false).updateFontSize(value!);
      },
      items: fontSizes.map<DropdownMenuItem<double>>((double value) {
        return DropdownMenuItem<double>(
          value: value,
          child: Text("$value"),
        );
      }).toList(),
    );
  }
}

class FontFamilyDropdownApp extends StatelessWidget {
  const FontFamilyDropdownApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Font Family", style: TextStyle(color: Colors.deepPurple)),
          FontFamilyDropdownExample()
        ],
      ),
      margin: EdgeInsets.all(10.0),
    );
  }
}

class FontFamilyDropdownExample extends StatefulWidget {
  const FontFamilyDropdownExample({super.key});

  @override
  State<FontFamilyDropdownExample> createState() =>
      _FontFamilyDropdownExampleState();
}

class _FontFamilyDropdownExampleState extends State<FontFamilyDropdownExample> {
  String dropdownValue = fontFamilies.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      // elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
        Provider.of<AppState>(context, listen: false).updateFontFamily(value!);
      },
      items: fontFamilies.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class FontColorDropdownApp extends StatelessWidget {
  const FontColorDropdownApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Font Color", style: TextStyle(color: Colors.deepPurple)),
          FontColorDropdownExample()
        ],
      ),
      margin: EdgeInsets.all(10.0),
    );
  }
}

class FontColorDropdownExample extends StatefulWidget {
  const FontColorDropdownExample({super.key});

  @override
  State<FontColorDropdownExample> createState() =>
      _FontColorDropdownExampleState();
}

class _FontColorDropdownExampleState extends State<FontColorDropdownExample> {
  String dropdownValue = fontColors.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      // elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          // currentFontColor = value;
        });
        Provider.of<AppState>(context, listen: false).updateFontColor(value!);
      },
      items: fontColors.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class SelectedText extends StatefulWidget {
  @override
  _SelectedTextState createState() => _SelectedTextState();
}

class _SelectedTextState extends State<SelectedText> {
  Offset offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<AppState>(builder: (context, appState, child) {
        return Container(
          child: Positioned(
            left: offset.dx,
            top: offset.dy,
            child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    offset = Offset(offset.dx + details.delta.dx,
                        offset.dy + details.delta.dy);
                  });
                },
                onTap: () {},
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: TextField(
                        // controller: _controller,
                        style: TextStyle(
                            color: appState.currentFontColor,
                            fontSize: appState.currentFontSize,
                            fontFamily: appState.currentFontFamily),
                        decoration: InputDecoration(
                          fillColor: Colors.amber,
                          border: OutlineInputBorder(),
                          hintText: 'Type something...',
                        ),
                        maxLines: null, // Allows multiple lines of text
                      ),
                    ),
                  ),
                )),
          ),
        );
      }),
    );
  }
}
