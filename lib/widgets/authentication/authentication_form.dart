import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../image_pickers/user_image_picker.dart';

class AuthenticationForm extends StatefulWidget {
  final Future<void> Function({
    required String email,
    required String password,
    required BuildContext context,
    File? image,
    String? username,
    bool isLogin,
  }) submitHandler;

  const AuthenticationForm({
    Key? key,
    required this.submitHandler,
  }) : super(key: key);

  @override
  _AuthenticationFormState createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  late final GlobalKey<FormState> _formKey;
  String? _email;
  String? _username;
  String? _password;
  XFile? _selectedImage;
  var _isSigningUp = false;
  var _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_isSigningUp)
                    UserImagePicker(
                      onImageSelected: _setImage,
                    ),
                  TextFormField(
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    key: const ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email address',
                    ),
                    validator: (value) {
                      String? error;

                      if (value == null) {
                        error = 'Please enter an email address';
                      } else if (!value.contains('@')) {
                        error = 'Please enter a valid email address';
                      }

                      return error;
                    },
                    onSaved: (value) => _email = value,
                  ),
                  if (_isSigningUp)
                    TextFormField(
                      key: const ValueKey('username'),
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        String? error;

                        if (value == null) {
                          error = 'Enter a username';
                        } else if (value.isEmpty) {
                          error = 'Enter a username';
                        }

                        return error;
                      },
                      onSaved: (value) => _username = value,
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      String? error;

                      if (value == null) {
                        error = 'Please enter a password';
                      } else if (value.length < 8) {
                        error = 'Password must be at least 8 characters';
                      }

                      return error;
                    },
                    onSaved: (value) => _password = value,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _isAuthenticating
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : ElevatedButton(
                          onPressed: _submit,
                          child: Text(_isSigningUp ? 'Sign Up' : 'Sign In'),
                        ),
                  if (!_isAuthenticating)
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _isSigningUp = !_isSigningUp;
                        });
                      },
                      child: Text(
                        _isSigningUp
                            ? 'Already have an account'
                            : 'Create new account',
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedImage == null && _isSigningUp) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please select an image'),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        );
      } else {
        setState(() {
          _isAuthenticating = true;
        });

        FocusScope.of(context).unfocus();
        _formKey.currentState!.save();

        await widget.submitHandler(
          email: _email!.trim(),
          password: _password!.trim(),
          username: _username,
          isLogin: !_isSigningUp,
          context: context,
          image: _selectedImage == null ? null : File(_selectedImage!.path),
        );

        setState(() {
          _isAuthenticating = false;
        });
      }
    }
  }

  void _setImage(XFile image) {
    setState(() {
      _selectedImage = image;
    });
  }
}
