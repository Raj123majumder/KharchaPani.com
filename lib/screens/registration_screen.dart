import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_app/models/user_model.dart';
import 'package:expenses_app/screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff0095FF),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(_emailController.text, _passwordController.text);
        },
        child: Text(
          "SignUp",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(
          size: 18,
        ),
        title: Text(
          "SignUp",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
            child: Container(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      'assets/homePage.jpeg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Textinput(
                      "First Name",
                      _firstNameController,
                      _passwordController,
                      false,
                      false,
                      TextInputAction.next,
                      Icon(Icons.person)),
                  SizedBox(
                    height: 20,
                  ),
                  Textinput(
                      "Second Name",
                      _secondNameController,
                      _passwordController,
                      false,
                      false,
                      TextInputAction.next,
                      Icon(Icons.person)),
                  SizedBox(
                    height: 20,
                  ),
                  Textinput("Email", _emailController, _passwordController,
                      false, true, TextInputAction.next, Icon(Icons.email)),
                  SizedBox(
                    height: 20,
                  ),
                  Textinput(
                      "Password",
                      _passwordController,
                      _confirmPasswordController,
                      true,
                      false,
                      TextInputAction.next,
                      Icon(Icons.password)),
                  SizedBox(
                    height: 20,
                  ),
                  Textinput(
                      "Confirm Password",
                      _confirmPasswordController,
                      _passwordController,
                      true,
                      false,
                      TextInputAction.done,
                      Icon(Icons.password)),
                  SizedBox(
                    height: 20,
                  ),
                  loginButton,
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        postDetailsToFirestore();
      }).catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = await _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.uid = user!.uid;
    userModel.email = user.email;
    userModel.firstName = _firstNameController.text;
    userModel.secondName = _secondNameController.text;

    await firebaseFirestore
        .collection('users_info')
        .doc(user!.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: 'Successfully Registered');

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: ((context) => HomePage())),
        (route) => false);
  }
}

Widget Textinput(
    String label,
    TextEditingController controller1,
    TextEditingController controller2,
    bool isPassword,
    bool isEmail,
    TextInputAction action,
    Widget prefix) {
  return TextFormField(
    controller: controller1,
    obscureText: isPassword,
    autofocus: false,
    validator: (value) {
      if (label == "Email") {
        if (value!.isEmpty) {
          return 'Please enter some text';
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      } else if (label == "Password") {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return 'Please enter Password';
        }
        if (!regex.hasMatch(value)) {
          return 'Password must be at least 6 characters';
        }
        return null;
      } else if (label == "Confirm Password") {
        if (value!.isEmpty) {
          return 'Please enter some text';
        }
        if (controller1.text != controller2.text) {
          return 'Password does not match';
        }
        return null;
      } else if (label == "First Name") {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return 'Please enter first name';
        } else if (!regex.hasMatch(value)) {
          return 'First name must be at least 3 characters';
        }
        return null;
      } else if (label == "Second Name") {
        if (value!.isEmpty) {
          return 'Please enter Second Name';
        }
        return null;
      }
    },
    keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
    onSaved: (newValue) => controller1.text = newValue!,
    textInputAction: action,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      labelText: label,
      hintText: label,
      prefixIcon: prefix,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
  );
}
