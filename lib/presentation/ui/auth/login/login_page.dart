import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footloose_app/domain/use_cases/login_user.dart';
import 'package:footloose_app/domain/use_cases/save_user.dart';
import 'package:footloose_app/injection/injection.dart';
import 'package:footloose_app/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:footloose_app/presentation/routes/app_routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        loginUser: getIt<LoginUser>(),
        saveUser: getIt<SaveUser>(),
      ),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = context.read<AuthBloc>();
  }

  void _onLoginUser() {
    _authBloc.add(
      OnLoginUser(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  Future<void> _invalidLogin() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Credenciales Incorrectas'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Verifique que el email y/o la contraseña sean los correctos',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SuccessLoginUser) {
            Navigator.pushReplacementNamed(context, AppRoutes.productList);
          } else if (state is FailureLoginUser) {
            _invalidLogin();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: CircleAvatar(
                    maxRadius: 30,
                    child: Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 20,
                ),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 20,
                ),
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Contraseña',
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 30),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is LoadingLoginUser) {
                    return const CircularProgressIndicator();
                  }
                  return OutlinedButton(
                    onPressed: _onLoginUser,
                    child: const Text(
                      'Iniciar sesión',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
