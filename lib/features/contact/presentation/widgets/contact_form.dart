import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../core/core.dart';
import '../../../../core/constants/app_urls.dart';

enum _FormStatus { idle, sending, success, error }

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  _FormStatus _status = _FormStatus.idle;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  String? _validateRequired(String? value, String message) =>
      (value == null || value.trim().isEmpty) ? message : null;

  String? _validateEmail(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return context.tr('Entrez votre email', 'Enter your email');
    final valid = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(text);
    return valid ? null : context.tr('Email invalide', 'Invalid email');
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _status = _FormStatus.sending);

    try {
      final response = await http
          .post(
            Uri.parse(AppUrls.formEndpoint),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'name': _nameCtrl.text.trim(),
              'email': _emailCtrl.text.trim(),
              'message': _messageCtrl.text.trim(),
            }),
          )
          .timeout(const Duration(seconds: 15));

      if (!mounted) return;
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _nameCtrl.clear();
        _emailCtrl.clear();
        _messageCtrl.clear();
        setState(() => _status = _FormStatus.success);
      } else {
        setState(() => _status = _FormStatus.error);
      }
    } on http.ClientException {
      if (mounted) setState(() => _status = _FormStatus.error);
    } on TimeoutException {
      if (mounted) setState(() => _status = _FormStatus.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: p.border),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeOutCubic,
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween(begin: 0.96, end: 1.0).animate(animation),
            child: child,
          ),
        ),
        child: _status == _FormStatus.success
            ? _SuccessView(
                key: const ValueKey('success'),
                onReset: () => setState(() => _status = _FormStatus.idle),
              )
            : _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    final sending = _status == _FormStatus.sending;
    final t = context.text;

    return Form(
      key: _formKey,
      child: Column(
        key: const ValueKey('form'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.tr('Envoyer un message', 'Send a message'),
              style: t.blockTitle),
          const SizedBox(height: 22),
          TextFormField(
            controller: _nameCtrl,
            textInputAction: TextInputAction.next,
            decoration: _decoration(
              context.tr('Nom / Entreprise', 'Name / Company'),
              Icons.person_outline,
            ),
            validator: (value) => _validateRequired(
              value,
              context.tr('Entrez votre nom', 'Enter your name'),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailCtrl,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: _decoration('Email', Icons.mail_outline),
            validator: _validateEmail,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _messageCtrl,
            minLines: 4,
            maxLines: 6,
            decoration: _decoration('Message', null),
            validator: (value) => _validateRequired(
              value,
              context.tr('Écrivez votre message', 'Write your message'),
            ),
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: sending ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                disabledBackgroundColor: AppColors.accent.withValues(
                  alpha: 0.5,
                ),
                disabledForegroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: sending
                    ? const SizedBox(
                        key: ValueKey('loading'),
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Row(
                        key: const ValueKey('label'),
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.send_rounded, size: 18),
                          const SizedBox(width: 8),
                          Text(context.tr('Envoyer', 'Send'), style: t.button),
                        ],
                      ),
              ),
            ),
          ),
          if (_status == _FormStatus.error)
            Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Text(
                context.tr(
                  'Envoi impossible pour le moment. Réessayez ou écrivez-moi '
                      'directement par email.',
                  'Could not send right now. Please try again or email me '
                      'directly.',
                ),
                style: const TextStyle(color: Colors.redAccent, fontSize: 13),
              ),
            ),
        ],
      ),
    );
  }

  InputDecoration _decoration(String label, IconData? icon) {
    final p = context.palette;
    OutlineInputBorder border(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: color),
    );

    return InputDecoration(
      labelText: label,
      alignLabelWithHint: true,
      labelStyle: TextStyle(color: p.textSecondary),
      floatingLabelStyle: const TextStyle(color: AppColors.accent),
      prefixIcon: icon == null ? null : Icon(icon, size: 20),
      filled: true,
      fillColor: p.surfaceAlt,
      enabledBorder: border(p.border),
      focusedBorder: border(AppColors.accent),
      errorBorder: border(Colors.redAccent),
      focusedErrorBorder: border(Colors.redAccent),
    );
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView({super.key, required this.onReset});

  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final t = context.text;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOutBack,
            builder: (context, value, child) =>
                Transform.scale(scale: value, child: child),
            child: Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: AppColors.accent,
                size: 48,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(context.tr('Message envoyé !', 'Message sent!'),
              style: t.blockTitle),
          const SizedBox(height: 8),
          Text(
            context.tr(
              'Merci, je vous réponds très vite.',
              'Thank you, I’ll get back to you very soon.',
            ),
            style: t.body,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: onReset,
            child: Text(
              context.tr('Envoyer un autre message', 'Send another message'),
            ),
          ),
        ],
      ),
    );
  }
}
