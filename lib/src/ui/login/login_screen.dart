import 'package:aerolinea/src/blocs/login_bloc/bloc.dart';
import 'package:aerolinea/src/repository/user_repository.dart';
import 'package:aerolinea/src/ui/register/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:aerolinea/src/Assets/RoundedButton.dart';
import 'package:aerolinea/src/Assets/Notificaciones.dart';
import 'package:aerolinea/src/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:aerolinea/src/Assets/RoundedButton.dart';
import 'package:aerolinea/src/Assets/Notificaciones.dart';
import 'package:aerolinea/src/blocs/authentication bloc/bloc.dart';
//code for designing the UI of our text field where the user writes his email id or password

const kTextFieldDecoration = InputDecoration(
    hintText: 'Enter a value',
    hintStyle: TextStyle(color: Colors.grey),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ));

class LoginScreen extends StatelessWidget {
  @override
  final UserRepository _userRepository;
  LoginScreen({Key? key, required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(userRepository: _userRepository),
            child: LoginForm(userRepository: _userRepository)));
  }
}

//Formulario de Login
class LoginForm extends StatefulWidget {
  final UserRepository? _userRepository;

  LoginForm({Key? key, required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

final _auth = FirebaseAuth.instance;

String? email;
String? password;
bool showSpinner = false;

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late LoginBloc _LoginBloc;

  UserRepository? get _userRepository => widget._userRepository;

//Parte a probar
  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _LoginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    UserRepository _userRepository = new UserRepository();
    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      if (state.isFailure) {
        notificacion(
            context, 'Error Inicio de Sesión', 'Los datos no son correctos', 1);
        Scaffold.of(context).hideCurrentSnackBar();
      }
      if (state.isSubmitting) {
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
              content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                Text('Ingresando...'),
                CircularProgressIndicator(),
              ])));
      }
      if (state.isSuccess) {
        notificacion(context, 'Bienvenido', 'Inicio de sesión correcto', 0);
        Scaffold.of(context).hideCurrentSnackBar();
        BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: ListView(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 35, 191, 211),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(0),
                      child: Text(
                        'Inicio de Sesión',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.white),
                      )),
                  const SizedBox(
                    height: 75,
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isEmailValid ? 'Correo inválido' : null;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      icon: const Icon(Icons.email),
                      hintText: 'Correo',
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    autocorrect: false,
                    textAlign: TextAlign.center,
                    decoration: kTextFieldDecoration.copyWith(
                        icon: const Icon(Icons.lock), hintText: 'Contraseña'),
                    validator: (_) {
                      return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  RoundedButton(
                      colour: Colors.lightBlueAccent,
                      title: 'Iniciar Sesión',
                      onPressed: () {
                        _onFormSubmitted();
                      }),
                  RoundedButton(
                      colour: Colors.blueAccent,
                      title: 'Registrarse',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen(
                                    userRepository: _userRepository)));
                      }),
                  RoundedButton(
                      colour: const Color.fromARGB(255, 184, 184, 184),
                      title: 'Invitado',
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return Container();
                        }));
                      }),
                ],
              ),
            ));
      },
    ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _LoginBloc.add(EmailChanged(email: _emailController.text.trim()));
  }

  void _onPasswordChanged() {
    _LoginBloc.add(PasswordChanged(password: _passwordController.text.trim()));
  }

  void _onFormSubmitted() {
    _LoginBloc.add(LoginWithCredentialsPressed(
        email: _emailController.text, password: _passwordController.text));
  }
}
