import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext context,
  ) submitFn;
  const AuthForm(
    this.submitFn,
    this.isLoading, {
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmit() {
    if (_formKey.currentState == null) {
      return;
    }
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword,
        _userName.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      margin: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: const ValueKey('email'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                  ),
                  onSaved: (value) {
                    if (value != null) {
                      _userEmail = value;
                    }
                  },
                ),
                if (!_isLogin)
                  TextFormField(
                    key: const ValueKey('username'),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 4) {
                        return "Please enter a valid username";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: "Username"),
                    onSaved: (value) {
                      if (value != null) {
                        _userName = value;
                      }
                    },
                  ),
                TextFormField(
                  key: const ValueKey('password'),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 5) {
                      return "Please enter a valid password";
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Password"),
                  onSaved: (value) {
                    if (value != null) {
                      _userPassword = value;
                    }
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                if (widget.isLoading) const CircularProgressIndicator(),
                if (!widget.isLoading)
                  ElevatedButton(
                    onPressed: _trySubmit,
                    child: Text(
                      _isLogin ? "Login" : "Signup",
                    ),
                  ),
                if (!widget.isLoading)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(_isLogin
                        ? "Create new account"
                        : "I already have an account"),
                  ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
