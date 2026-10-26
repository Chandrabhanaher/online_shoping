import 'package:flutter/material.dart';

class UserRegisterScreen extends StatefulWidget {
  const UserRegisterScreen({super.key});

  @override
  State<UserRegisterScreen> createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Create Account',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'First name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.givenName],
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? 'Enter your first name'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Last name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.familyName],
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? 'Enter your last name'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                      validator: (value) {
                        final email = value?.trim() ?? '';
                        if (email.isEmpty) {
                          return 'Enter your email';
                        }
                        if (!email.contains('@') || !email.contains('.')) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Phone number',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone_outlined),
                      ),
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.telephoneNumber],
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? 'Enter your phone number'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.newPassword],
                      validator: (value) => value == null || value.isEmpty
                          ? 'Enter your password'
                          : null,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => _formKey.currentState?.validate(),
                      child: const Text('Submit'),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already registered?'),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
