import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoggedIn = false;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = _prefs.getBool('isLoggedIn') ?? false;
    });
  }

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username == 'admin' && password == '12345678') {
      _prefs.setBool('isLoggedIn', true);
      setState(() {
        isLoggedIn = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid username or password'),
      ));
    }
  }

  void _logout() {
    _prefs.setBool('isLoggedIn', false);
    setState(() {
      isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? HomePage(logout: _logout) : LoginForm(login: _login, usernameController: _usernameController, passwordController: _passwordController);
  }
}

class LoginForm extends StatelessWidget {
  final VoidCallback login;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  LoginForm({required this.login, required this.usernameController, required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Forget Password',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: login,
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 19),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}






class HomePage extends StatefulWidget {
  final VoidCallback logout;

  HomePage({required this.logout});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isSearchBarVisible = false;
  String _searchTerm = '';

  final List<Map<String, dynamic>> jobDescriptions = [
    {
      'jobTitle': 'Software Engineer',
      'jobCategory': 'Information Technology',
      'salaryRange': '\$60,000 - \$100,000',
      'experienceLevel': 'Mid Level',
      'industry': 'Technology',
      'location': 'Karachi'
    },
    {
      'jobTitle': 'Marketing Manager',
      'jobCategory': 'Marketing',
      'salaryRange': '\$50,000 - \$80,000',
      'experienceLevel': 'Senior Level',
      'industry': 'Marketing',
      'location': 'Lahore'
    },
    {
      'jobTitle': 'Graphic Designer',
      'jobCategory': 'Design',
      'salaryRange': '\$40,000 - \$70,000',
      'experienceLevel': 'Entry Level',
      'industry': 'Design',
      'location': 'Islamabad'
    },
    {
      'jobTitle': 'Accountant',
      'jobCategory': 'Finance',
      'salaryRange': '\$50,000 - \$90,000',
      'experienceLevel': 'Mid Level',
      'industry': 'Finance',
      'location': 'Lahore'
    },
    {
      'jobTitle': 'Project Manager',
      'jobCategory': 'Project Management',
      'salaryRange': '\$70,000 - \$120,000',
      'experienceLevel': 'Senior Level',
      'industry': 'Business',
      'location': 'Rawalpindi'
    },
    {
      'jobTitle': 'Sales Representative',
      'jobCategory': 'Sales',
      'salaryRange': '\$40,000 - \$80,000',
      'experienceLevel': 'Entry Level',
      'industry': 'Sales',
      'location': 'Karachi'
    },
    {
      'jobTitle': 'Human Resources Specialist',
      'jobCategory': 'Human Resources',
      'salaryRange': '\$50,000 - \$90,000',
      'experienceLevel': 'Mid Level',
      'industry': 'Human Resources',
      'location': 'Islamabad'
    },
    {
      'jobTitle': 'Data Analyst',
      'jobCategory': 'Data Analysis',
      'salaryRange': '\$60,000 - \$100,000',
      'experienceLevel': 'Mid Level',
      'industry': 'Technology',
      'location': 'Lahore'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: _isSearchBarVisible
              ? TextField(
            decoration: InputDecoration(
              hintText: 'Search....',
              hintStyle: TextStyle(color: Colors.white),
            ),
            style: TextStyle(color: Colors.white),
            onChanged: (value) {
              setState(() {
                _searchTerm = value;
              });
            },
          )
              : Text(
            'Home Page',
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: _isSearchBarVisible
                  ? Icon(
                Icons.close,
                color: Colors.white,
              )
                  : Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _isSearchBarVisible = !_isSearchBarVisible;
                  if (!_isSearchBarVisible) {
                    _searchTerm = '';
                  }
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                ),
                child: Text(
                  'Jobs',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: Text('Add & Post Jobs'),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('This feature will be added soon!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Search Jobs'),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('This feature will be added soon!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Logout'),
                onTap: widget.logout,
              ),
            ],
          ),
        ),
        body: LayoutBuilder(
        builder: (context, constraints) {
      final containerWidth = constraints.maxWidth / (constraints.maxWidth >= 1200 ? 4 : 2);
      return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: constraints.maxWidth >= 1200 ? 4 : 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
      ),
    itemCount: jobDescriptions.length,
    itemBuilder: (context, index) {
    final job = jobDescriptions[index];

    bool matchesSearch = job.values.any((value) {
    return value.toString().toLowerCase().contains(_searchTerm.toLowerCase());
    });

    if (_searchTerm.isEmpty || matchesSearch) {
    return SizedBox(
    width: containerWidth,
    child: Padding(
    padding: const EdgeInsets.only(top: 20, left: 20),
    child: Card(
    elevation: 0,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        job['jobTitle'],
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Category: ${job['jobCategory']}'),
      Text('Salary Range: ${job['salaryRange']}'),
      Text('Experience Level: ${job['experienceLevel']}'),
      Text('Industry: ${job['industry']}'),
      Text('Location: ${job['location']}'),
    ],
    ),
    ),
    ),
    );
    } else {
      return Container();
    }
    },
      );
        },
        ),
    );
  }
}




