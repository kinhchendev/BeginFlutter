import 'package:flutter/material.dart';
import 'package:journal/blocs/login_bloc.dart';
import 'package:journal/services/authentication.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late LoginBloc _loginBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = LoginBloc(AuthenticationService(), context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          child: Icon(
            Icons.account_circle,
            size: 88.0,
            color: Colors.white,
          ),
          preferredSize: Size.fromHeight(40.0),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 16.0, top: 32.0,
              right: 16.0, bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StreamBuilder(
                stream: _loginBloc.email,
                builder: (BuildContext context, AsyncSnapshot snapshot) =>
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Email Address',
                          icon: const Icon(Icons.mail_outline),
                          errorText: (snapshot.error != null) ? snapshot.error.toString() : null
                      ),
                      onChanged: _loginBloc.emailChanged.add,
                    ),
              ),
              StreamBuilder(
                stream: _loginBloc.password,
                builder: (BuildContext context, AsyncSnapshot snapshot) =>
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        icon: Icon(Icons.security),
                        errorText: (snapshot.error != null) ? snapshot.error.toString() : null,
                      ),
                      onChanged: _loginBloc.passwordChanged.add,
                    ),
              ),
              SizedBox(height: 48.0),
              _buildLoginAndCreateButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginAndCreateButtons() {
    debugPrint('builLoginAndCreateButton');
    return StreamBuilder(
      initialData: 'Login',
      stream: _loginBloc.loginOrCreateButton,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == 'Login') {
          return _buttonsLogin();
        } else if (snapshot.data == 'Create Account') {
          return _buttonsCreateAccount();
        } else {
          return _buttonsCreateAccount();
        }
      },
    );
  }

  Column _buttonsLogin() {
    debugPrint('buttonsLogin');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StreamBuilder(
          initialData: false,
          stream: _loginBloc.enableLoginCreateButton,
          builder: (BuildContext context, AsyncSnapshot snapshot) =>
              ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(16.0),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.grey.shade100;
                          } else {
                            return Colors.lightGreen.shade400;
                          }
                        }
                        ),
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.black54;
                        } else {
                          return Colors.black54;
                        }
                      }
                  ),
                ),
                onPressed: snapshot.data
                    ? () => _loginBloc.loginOrCreateChanged.add('Login')
                    : null,
                child: const Text('Login'),
              ),
        ),
        TextButton(
          onPressed: () {
            _loginBloc.loginOrCreateButtonChanged.add('Create Account');
          },
          child: const Text('Create Account'),
        ),
      ],
    );
  }

  Column _buttonsCreateAccount() {
    debugPrint('buttonsCreateAccount');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StreamBuilder(
          initialData: false,
          stream: _loginBloc.enableLoginCreateButton,
          builder: (BuildContext context, AsyncSnapshot snapshot) =>
              ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(16.0),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.grey.shade100;
                        } else {
                          return Colors.lightGreen.shade400;
                        }
                      }
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.black54;
                        } else {
                          return Colors.black54;
                        }
                      }
                  ),
                ),
                onPressed: snapshot.data
                    ? () => _loginBloc.loginOrCreateChanged.add('Create Account')
                    : null,
                child: const Text('Create Account'),
              ),
        ),
        TextButton(
          onPressed: () {
            _loginBloc.loginOrCreateButtonChanged.add('Login');
          },
          child: const Text('Login'),
        ),
      ],
    );
  }
}
