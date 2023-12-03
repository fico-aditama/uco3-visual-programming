import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(PomodoroApp());
}

class PomodoroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    PomodoroTimerScreen(),
    TaskManagementScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro Timer'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Pomodoro',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tasks',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class PomodoroTimerScreen extends StatefulWidget {
  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimerScreen> {
  int minutes = 25;
  int seconds = 0;
  bool isRunning = false;
  bool isBreak = false;
  AudioCache audioPlayer = AudioCache();

  void _sendDataToPython(String data) async {
    final Uri url = Uri.parse('http://localhost:5000/api/data'); // Convert string to Uri
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'data': data}),
    );

    if (response.statusCode == 200) {
      print('Data sent successfully');
    } else {
      print('Failed to send data. Error: ${response.body}');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              isBreak ? 'Take a Break!' : 'Focus on Task!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              '$minutes:${seconds.toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Text(isRunning ? 'Pause' : 'Start'),
                  onPressed: () {
                    setState(() {
                      isRunning = !isRunning;
                      if (isRunning) {
                        startTimer();
                        audioPlayer.play('tick_sound.mp3'); // Play tick sound
                      } else {
                        // audioPlayer.stop(); // Stop tick sound
                      }
                    });
                  },
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  child: Text('Reset'),
                  onPressed: () {
                    setState(() {
                      resetTimer();
                      // audioPlayer.stop(); // Stop tick sound
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer timer) {
      if (!isRunning) {
        timer.cancel();
      } else {
        setState(() {
          if (seconds > 0) {
            seconds--;
          } else {
            if (minutes > 0) {
              minutes--;
              seconds = 59;
            } else {
              isBreak = !isBreak;
              if (isBreak) {
                minutes = 5; // Break duration 5 minutes
              } else {
                minutes = 25; // Focus duration 25 minutes
              }
            }
          }
        });
      }
    });
  }

  void resetTimer() {
    minutes = 25;
    seconds = 0;
    isRunning = false;
    isBreak = false;
  }
}

class TaskManagementScreen extends StatefulWidget {
  @override
  _TaskManagementScreenState createState() => _TaskManagementScreenState();
}

class _TaskManagementScreenState extends State<TaskManagementScreen> {
  List<String> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index]),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // Add code to edit task
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showAddTaskDialog(context);
        },
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String newTask = '';
        return AlertDialog(
          title: Text('Add Task'),
          content: TextField(
            onChanged: (value) {
              newTask = value;
            },
          ),
          actions: [
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                setState(() {
                  tasks.add(newTask);
                  _PomodoroTimerState()._sendDataToPython(newTask); // Call from _PomodoroTimerState instance
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Pomodoro App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('On Going Tasks'),
            onTap: () {
              _navigateToScreen(context, 'On Going Tasks');
            },
          ),
          ListTile(
            title: Text('Complete Tasks'),
            onTap: () {
              _navigateToScreen(context, 'Complete Tasks');
            },
          ),
          ListTile(
            title: Text('Detail Category Tasks'),
            onTap: () {
              _navigateToScreen(context, 'Detail Category Tasks');
            },
          ),
          ListTile(
            title: Text('Search Tasks'),
            onTap: () {
              _navigateToScreen(context, 'Search Tasks');
            },
          ),
          ListTile(
            title: Text('Calendar Tasks'),
            onTap: () {
              _navigateToScreen(context, 'Calendar Tasks');
            },
          ),
          ListTile(
            title: Text('Add Tasks'),
            onTap: () {
              _navigateToScreen(context, 'Add Tasks');
            },
          ),
          ListTile(
            title: Text('Update Tasks'),
            onTap: () {
              _navigateToScreen(context, 'Update Tasks');
            },
          ),
          ListTile(
            title: Text('Delete Tasks'),
            onTap: () {
              _navigateToScreen(context, 'Delete Tasks');
            },
          ),
          ListTile(
            title: Text('Set Deadline Tasks'),
            onTap: () {
              _navigateToScreen(context, 'Set Deadline Tasks');
            },
          ),
        ],
      ),
    );
  }

  void _navigateToScreen(BuildContext context, String screen) {
    // Placeholder function, you can implement navigation logic here
    print('Navigate to $screen');
    Navigator.of(context).pop();
  }
}
