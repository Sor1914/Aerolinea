import 'package:aerolinea/src/blocs/register_bloc/bloc.dart';
import 'package:aerolinea/src/repository/user_repository.dart';
import 'package:aerolinea/src/ui/login/login_screen.dart';
import 'package:aerolinea/src/util/validators.dart';
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
import 'package:intl/intl.dart';

class RegisterScreen extends StatelessWidget {
  @override
  final UserRepository _userRepository;
  RegisterScreen({Key? key, required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<RegisterBloc>(
            create: (context) => RegisterBloc(userRepository: _userRepository),
            child: RegisterForm(userRepository: _userRepository)));
  }
}

class RegisterForm extends StatefulWidget {
  final UserRepository? _userRepository;

  RegisterForm({Key? key, required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

final _formKey = GlobalKey<FormState>();
final _auth = FirebaseAuth.instance;
late String pasaporte;
late String nombre;
late String apellido;
late String fechaNacimiento;
late String nacionalidad;
late String email;
late String codigoPais;
late String telefono;
late String codigoPaisEmer;
late String telefonoEmergencia;
late String direccion;
late String password;
bool validado = false;
bool visible = true;
String validar = 'Validar';

bool shoSpinner = false;

TextEditingController dateInput = TextEditingController();
TextEditingController numeroInput = TextEditingController();
TextEditingController emergenciaInput = TextEditingController();

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late RegisterBloc _registerBloc;

  UserRepository? get _userRepository => widget._userRepository;

  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isFailure) {
          notificacion(
              context, 'Error en Registro', 'Hubo un error al registrarlo', 1);
          Scaffold.of(context).hideCurrentSnackBar();
        }
        if (state.isSubmittin) {
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
        if (state.isRecord) {
          notificacion(
              context, 'Gracias', 'Te has registrado correctamente', 0);
          Scaffold.of(context).hideCurrentSnackBar();
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
              content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                Text('Ingresando...'),
                CircularProgressIndicator(),
              ])));
      },
      child:
          BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: _formKey,
              child: ListView(children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 35, 191, 211),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    transform: Matrix4.rotationZ(0),
                    child: Text(
                      'Registro',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.white),
                    )),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    enabled: (visible),
                    maxLength: 13,
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      pasaporte = value;

                      //Do something with the user input.
                    },
                    validator: (_) {
                      return !state.isPasaportValid
                          ? "Pasarpote inválido"
                          : null;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        icon: const Icon(Icons.numbers),
                        hintText: 'Ingrese su Número de Pasaporte')),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                    enabled: (visible),
                    keyboardType: TextInputType.name,
                    textAlign: TextAlign.center,
                    validator: (value) {
                      return nombre.isEmpty ? "*Campo obligatorio" : null;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        icon: const Icon(Icons.person),
                        hintText: 'Ingrese su Nombre')),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                    enabled: (visible),
                    keyboardType: TextInputType.name,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      apellido = value;
                      //Do something with the user input.
                    },
                    validator: (Y) {
                      return apellido.isEmpty ? "*Campo obligatorio" : null;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        icon: const Icon(Icons.person),
                        hintText: 'Ingrese su Apellido')),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                    enabled: (visible),
                    keyboardType: TextInputType.name,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      nacionalidad = value;
                      //Do something with the user input.
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        icon: const Icon(Icons.flag),
                        hintText: 'Ingrese su Nacionalidad')),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: TextFormField(
                          enabled: (visible),
                          keyboardType: TextInputType.phone,
                          maxLength: 3,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            codigoPais = value;
                          },
                          validator: (Y) {
                            return !state.isCodeValid ? "*Error" : null;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              icon: const Icon(Icons.phone), hintText: '502')),
                    ),
                    Expanded(
                      flex: 6,
                      child: TextFormField(
                          enabled: (visible),
                          maxLength: 8,
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            telefono = value;
                          },
                          validator: (Y) {
                            return !state.isNumberValid
                                ? "*Ingrese un número válido"
                                : null;
                          },
                          onEditingComplete: () async {},
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Numero de Teléfono')),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: TextField(
                          enabled: (visible),
                          maxLength: 3,
                          keyboardType: TextInputType.name,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            codigoPaisEmer = value;
                          },
                          onEditingComplete: () async {},
                          decoration: kTextFieldDecoration.copyWith(
                              icon: const Icon(Icons.phone), hintText: '+502')),
                    ),
                    Expanded(
                      flex: 6,
                      child: TextField(
                          enabled: (visible),
                          maxLength: 8,
                          keyboardType: TextInputType.name,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            telefonoEmergencia = value;
                          },
                          onEditingComplete: () async {},
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Emergencia')),
                    ),
                  ],
                ),
                TextField(
                    enabled: (visible),
                    keyboardType: TextInputType.name,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      direccion = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        icon: const Icon(Icons.home),
                        hintText: 'Ingrese su Dirección')),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  enabled: (visible),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      icon: const Icon(Icons.email),
                      hintText: 'Ingrese su correo'),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                    enabled: (visible),
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                      //Do something with the user input.
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        icon: const Icon(Icons.password),
                        hintText: 'Ingrese su contraseña')),
                const SizedBox(
                  height: 8.0,
                ),
                /*Ingreso de fecha de nacimiento*/
                Container(
                    padding: EdgeInsets.all(0),
                    // height: MediaQuery.of(context).size.width / 3,
                    child: Center(
                        child: TextField(
                      controller: dateInput,
                      decoration: kTextFieldDecoration.copyWith(
                          icon: const Icon(Icons.baby_changing_station),
                          hintText: 'Fecha de Nacimiento'),
                      readOnly: true,
                      //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));
                        if (pickedDate != null) {
                          print(pickedDate);
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                          print(formattedDate);
                          setState(() {
                            dateInput.text = formattedDate;
                            fechaNacimiento = formattedDate;
                          });
                        } else {}
                      },
                    ))),
                Row(
                  children: <Widget>[
                    Expanded(
                        flex: 4,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue, onPrimary: Colors.white),
                            child: const Text('Guardar'),
                            onPressed: () {
                              //Validar debe cambiar de nombre porque sera el mismo botón para cancelar
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                              }
                            })),
                    const Expanded(flex: 2, child: Text('')),
                    Expanded(
                        flex: 4,
                        child: RoundedButton(
                            colour: Colors.blueAccent,
                            title: 'Registrarse',
                            onPressed: () async {
                              if (validado == false) {
                                AlertaUnBoton(
                                    context,
                                    'Error',
                                    'Por favor valide primero los datos',
                                    'Aceptar',
                                    pAccion: () => Navigator.pop(context));
                              } else {
                                setState(() {
                                  showSpinner = true;
                                });
                                try {
                                  final newUser = await _auth
                                      .createUserWithEmailAndPassword(
                                          email: email, password: password);
                                  if (newUser != null) {
                                    //var respuesta = await Usuarios.addUsuario(
                                    //  idUsuario: newUser.user.uid.toString(),
                                    //    pasaporte: pasaporte.toString(),
                                    //  nombre: nombre.toString(),
                                    //apellido: apellido.toString(),
                                    //       codigoPais: codigoPais.toString(),
                                    //      telefono: telefono.toString(),
                                    //     codigoPaisEmer: codigoPaisEmer.toString(),
                                    //    telefonoEmer: telefonoEmergencia.toString(),
                                    //     correo: email.toString(),
                                    //     direccion: direccion.toString(),
                                    //    fechaNacimiento: fechaNacimiento.toString(),
                                    //    nacionalidad: nacionalidad.toString(),
                                    //      rol: '0',
                                    //     usuarioCrea: 'CreaciónUsuarios',
                                    //     fechaCrea: DateTime.now().toString(),
                                    //     usuarioMod: '',
                                    //     fechaMod: '',
                                    //     estado: '1');
                                    Navigator.pushNamed(
                                        context, 'login_screen');
                                    notificacion(context, 'Registro',
                                        'Se ha registrado correctamente', 0);
                                  }
                                } catch (e) {
                                  AlertaUnBoton(
                                      context, 'Error', e.toString(), 'Aceptar',
                                      pAccion: () => Navigator.pop(context));
                                }
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            })),
                  ],
                )
              ])),
        );
      }),
    );
  }
}
