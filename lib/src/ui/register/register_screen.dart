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

import '../../models/usuario.dart';

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

bool validado = false;
bool visible = true;
String validar = 'Validar';

bool shoSpinner = false;
DateTime? pickedDate = DateTime.now();

TextEditingController tecDate = TextEditingController();
TextEditingController tecNumber = TextEditingController();
TextEditingController tecNumber2 = TextEditingController();
TextEditingController tecPasaport = TextEditingController();
TextEditingController tecName = TextEditingController();
TextEditingController tecLastName = TextEditingController();
String? dateBirth;
TextEditingController tecNationality = TextEditingController();
TextEditingController tecEmail = TextEditingController();
TextEditingController tecCode = TextEditingController();
TextEditingController tecCode2 = TextEditingController();
TextEditingController tecAddress = TextEditingController();
TextEditingController tecPassword = TextEditingController();

class _RegisterFormState extends State<RegisterForm> {
  late RegisterBloc _registerBloc;

  UserRepository? get _userRepository => widget._userRepository;

  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    tecDate.addListener(onFormValidated);
    tecNumber.addListener(onFormValidated);
    tecNumber2.addListener(onFormValidated);
    tecPasaport.addListener(onFormValidated);
    tecName.addListener(onFormValidated);
    tecLastName.addListener(onFormValidated);
    tecNationality.addListener(onFormValidated);
    tecEmail.addListener(onFormValidated);
    tecCode.addListener(onFormValidated);
    tecCode2.addListener(onFormValidated);
    tecAddress.addListener(onFormValidated);
    tecPassword.addListener(onFormValidated);
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
          onFormValidated();
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                  Text('Cargando...'),
                  CircularProgressIndicator(),
                ])));
        }

        if (state.isRecord) {
          Scaffold.of(context).hideCurrentSnackBar();

          _clearFields();
          Navigator.pop(context);
          notificacion(
              context, 'Gracias', 'Te has registrado correctamente', 0);
        }
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
                    controller: tecPasaport,
                    enabled: (visible),
                    maxLength: 13,
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.center,
                    validator: (value) {
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
                    controller: tecName,
                    enabled: (visible),
                    keyboardType: TextInputType.name,
                    textAlign: TextAlign.center,
                    validator: (value) {
                      return value!.isEmpty ? "*Campo obligatorio" : null;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        icon: const Icon(Icons.person),
                        hintText: 'Ingrese su Nombre')),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                    controller: tecLastName,
                    enabled: (visible),
                    keyboardType: TextInputType.name,
                    textAlign: TextAlign.center,
                    validator: (value) {
                      return value!.isEmpty ? "*Campo obligatorio" : null;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        icon: const Icon(Icons.person),
                        hintText: 'Ingrese su Apellido')),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                    controller: tecNationality,
                    enabled: (visible),
                    keyboardType: TextInputType.name,
                    textAlign: TextAlign.center,
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
                          controller: tecCode,
                          enabled: (visible),
                          keyboardType: TextInputType.phone,
                          maxLength: 3,
                          textAlign: TextAlign.center,
                          validator: (Y) {
                            return !state.isCodeValid ? "*Error" : null;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              icon: const Icon(Icons.phone), hintText: '502')),
                    ),
                    Expanded(
                      flex: 6,
                      child: TextFormField(
                          controller: tecNumber,
                          enabled: (visible),
                          maxLength: 8,
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.center,
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
                      child: TextFormField(
                          controller: tecCode2,
                          enabled: (visible),
                          maxLength: 3,
                          keyboardType: TextInputType.name,
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value!.isEmpty) {
                            } else {
                              !state.isCode2Valid ? "*Error" : null;
                            }
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              icon: const Icon(Icons.phone), hintText: '+502')),
                    ),
                    Expanded(
                      flex: 6,
                      child: TextFormField(
                          controller: tecNumber2,
                          enabled: (visible),
                          maxLength: 8,
                          keyboardType: TextInputType.name,
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value!.isEmpty) {
                            } else {
                              !state.isNumber2Valid
                                  ? "*Ingrese un número válido"
                                  : null;
                            }
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Emergencia')),
                    ),
                  ],
                ),
                TextFormField(
                    controller: tecAddress,
                    enabled: (visible),
                    keyboardType: TextInputType.name,
                    textAlign: TextAlign.center,
                    decoration: kTextFieldDecoration.copyWith(
                        icon: const Icon(Icons.home),
                        hintText: 'Ingrese su Dirección')),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  controller: tecEmail,
                  enabled: (visible),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  validator: (value) {
                    return !state.isEmailValid
                        ? "Ingrese un Correo Válido"
                        : null;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      icon: const Icon(Icons.email),
                      hintText: 'Ingrese su correo'),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                    controller: tecPassword,
                    enabled: (visible),
                    obscureText: true,
                    textAlign: TextAlign.center,
                    validator: (value) {
                      return !state.isPasswordValid
                          ? "La contraseña debe contener mayúsculas, minúsculas, letras y un caracter especial '!?/'"
                          : null;
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
                        child: TextFormField(
                      controller: tecDate,
                      decoration: kTextFieldDecoration.copyWith(
                          icon: const Icon(Icons.baby_changing_station),
                          hintText: 'Fecha de Nacimiento'),
                      textAlign: TextAlign.center,
                      readOnly: true,
                      //set it true, so that user will not able to edit text
                      onTap: () async {
                        pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                          setState(() {
                            tecDate.text = formattedDate;
                            dateBirth = formattedDate;
                          });
                        } else {}
                      },
                      validator: (value) {
                        return value!.isEmpty
                            ? "Ingrese su fecha de nacimiento"
                            : null;
                      },
                    ))),
                Row(
                  children: <Widget>[
                    Expanded(
                        flex: 4,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue, onPrimary: Colors.white),
                            child: Text(validar),
                            onPressed: () {
                              setState(() {
                                if (validar == "Cancelar") {
                                  validar = "Validar";
                                  validado = false;
                                } else {
                                  if (_formKey.currentState!.validate()) {
                                    validar = "Cancelar";
                                    validado = true;
                                  }
                                }
                              });

                              //Validar debe cambiar de nombre porque sera el mismo botón para cancelar
                            })),
                    const Expanded(flex: 2, child: Text('')),
                    Expanded(
                        flex: 4,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue, onPrimary: Colors.white),
                            child: const Text('Registrarse'),
                            onPressed: () {
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
                                  _onRegister();
                                } catch (e) {
                                  AlertaUnBoton(
                                      context, 'Error', e.toString(), 'Aceptar',
                                      pAccion: () => Navigator.pop(context));
                                }
                              }
                            })),
                  ],
                )
              ])),
        );
      }),
    );
  }

  void onFormValidated() {
    _registerBloc.add(Validate(
        email: tecEmail.text,
        password: tecPassword.text,
        code: tecCode.text,
        code2: tecCode2.text,
        number: tecNumber.text,
        number2: tecNumber2.text,
        pasaport: tecPasaport.text));
  }

  void _onRegister() {
    Usuario usuario = Usuario(
        apellido: tecLastName.text,
        codigoPais: tecCode.text,
        codigoPaisEmer: tecCode2.text,
        correo: tecEmail.text,
        direccion: tecAddress.text,
        fechaNacimiento: tecDate.text,
        nacionalidad: tecNationality.text,
        nombre: tecName.text,
        pasaporte: tecPasaport.text,
        telefono: tecNumber.text,
        telefonoEmer: tecNumber2.text);

    _registerBloc.add(Register(
        email: tecEmail.text, password: tecPassword.text, usuario: usuario));
  }

  void _clearFields() {
    tecDate.clear();
    tecNumber.clear();
    tecNumber2.clear();
    tecPasaport.clear();
    tecName.clear();
    tecLastName.clear();
    tecNationality.clear();
    tecEmail.clear();
    tecCode.clear();
    tecCode2.clear();
    tecAddress.clear();
    tecPassword.clear();
    validar = 'Validar';
  }
}
