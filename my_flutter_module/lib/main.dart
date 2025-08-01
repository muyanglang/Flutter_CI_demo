import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());
// void main() {
//   WidgetsFlutterBinding.ensureInitialized(); // 确保初始化
//   String initialRoute = PlatformDispatcher.instance.defaultRouteName;
//   runApp(MyApp(pageIndex: initialRoute));
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MethodChannel _oneChannel = const MethodChannel('one_page');
  final MethodChannel _twoChannel = const MethodChannel('two_page');
  final BasicMessageChannel _messageChannel = const BasicMessageChannel(
    'messageChannel',
    StandardMessageCodec(),
  );
  String pageIndex = 'one';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _messageChannel.setMessageHandler((message) {
      print('来自iOS的消息: $message');
      return Future(() {});
    });

    _oneChannel.setMethodCallHandler((call) {
      pageIndex = call.method;
      print(pageIndex);
      setState(() {});
      return Future(() {});
    });
    _twoChannel.setMethodCallHandler((call) {
      pageIndex = call.method;
      print(pageIndex);
      setState(() {});
      return Future(() {});
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: _rootPage(pageIndex),
    );
  }

  // 根据pageIndex来返回页面
  Widget _rootPage(String pageIndex) {
    switch (pageIndex) {
      case 'one':
        return Scaffold(
          appBar: AppBar(title: Text(pageIndex)),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // const MethodChannel('one_page').invokeMethod('exit');
                  _oneChannel.invokeMethod('exit');
                },
                child: Text(pageIndex),
              ),

              TextField(onChanged: (value) => {_messageChannel.send(value)}),
            ],
          ),
          // Center(
          //   child: ElevatedButton(
          //     onPressed: () {
          //       // const MethodChannel('one_page').invokeMethod('exit');
          //       _oneChannel.invokeMethod('exit');
          //     },
          //     child: Text(pageIndex),
          //   ),
          // ),
        );
      case 'two':
        return Scaffold(
          appBar: AppBar(title: Text(pageIndex)),
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                // const MethodChannel('two_page').invokeMethod('exit');
                _twoChannel.invokeMethod('exit');
              },
              child: Text(pageIndex),
            ),
          ),
        );

      default:
        return Scaffold(
          appBar: AppBar(title: Text(pageIndex)),
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                const MethodChannel('default_page').invokeMethod('exit');
              },
              child: Text(pageIndex),
            ),
          ),
        );
    }
  }

  // @override
  // Widget build(BuildContext context){
  //   return Container();
  // }
}

// class MyaApp extends StatelessWidget {
//   final String pageIndex;
//   const MyApp({super.key, required this.pageIndex});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
//         // counter didn't reset back to zero; the application is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       // home: const MyHomePage(title: 'Flutter Demo Home Page'),
//       home: _rootPage(pageIndex),
//     );
//   }

//   // 根据pageIndex来返回页面
//   Widget _rootPage(String pageIndex) {
//     switch (pageIndex) {
//       case 'one':
//         return Scaffold(
//           appBar: AppBar(title: Text(pageIndex)),
//           body: Center(
//             child: ElevatedButton(
//               onPressed: () {
//                 const MethodChannel('one_page').invokeMethod('exit');
//               },
//               child: Text(pageIndex),
//             ),
//           ),
//         );
//       case 'two':
//         return Scaffold(
//           appBar: AppBar(title: Text(pageIndex)),
//           body: Center(
//             child: ElevatedButton(
//               onPressed: () {
//                 const MethodChannel('two_page').invokeMethod('exit');
//               },
//               child: Text(pageIndex),
//             ),
//           ),
//         );

//       default:
//         return Scaffold(
//           appBar: AppBar(title: Text(pageIndex)),
//           body: Center(
//             child: ElevatedButton(
//               onPressed: () {
//                 const MethodChannel('default_page').invokeMethod('exit');
//               },
//               child: Text(pageIndex),
//             ),
//           ),
//         );
//     }
//   }
// }

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
