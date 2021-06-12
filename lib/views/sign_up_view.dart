import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel/core/router_manager.dart';
import 'package:travel/custom_theme.dart';
import 'package:travel/utils/utils.dart';
import 'package:travel/views/login_view.dart';
import 'package:travel/widgets/base/auth_base.dart';
import '../extensions/context_extensions.dart';

class SignUpView extends StatelessWidget {
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthBase(children: [
      SizedBox(height: context.phoneHeight * .1),
      _AppHeader(),
      SizedBox(height: context.phoneHeight * .05),
      _AppForm(formKey: this.registerFormKey),
      SizedBox(height: context.phoneHeight * .05),
      _AppRegister(formKey: this.registerFormKey)
    ]);
  }
}

class _AppHeader extends StatelessWidget {
  const _AppHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Travel',
          style: context.textTheme.headline4!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          'Kayıt Olun',
          style: context.textTheme.headline4!
              .copyWith(fontWeight: FontWeight.w300),
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text('Hesabınız mı var? /', style: context.textTheme.subtitle1),
            TextButton(
                onPressed: () {
                  RouteManager.newPage(LoginView());
                },
                child: Text(
                  'Giriş Yapın',
                  style:
                      context.textTheme.subtitle1!.copyWith(color: Colors.blue),
                ))
          ],
        )
      ],
    );
  }
}

class _AppForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const _AppForm({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: this.formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (String? val) {
              if (val!.isEmpty) {
                return "Lütfen e-posta adresinizi belirtin";
              }
              if (!Utils.controlMail(val)) {
                return "E-posta formatınızı hatalı girdiniz";
              }
              return null;
            },
            decoration: InputDecoration(
                labelText: 'E-posta adresiniz',
                prefixIcon: Icon(FontAwesomeIcons.mailBulk)),
          ),
          SizedBox(height: 10),
          TextFormField(
            validator: (String? val) {
              if (val!.length < 6) {
                return "Lütfen şifreniz için en az 6 karakter girin";
              }
              return null;
            },
            decoration: InputDecoration(
                labelText: 'Şifreniz',
                prefixIcon: Icon(FontAwesomeIcons.userLock)),
          ),
          SizedBox(height: 10),
          TextFormField(
            validator: (String? val) {
              if (val!.length < 3) {
                return "Adınız çok kısa";
              }
              return null;
            },
            decoration: InputDecoration(
                labelText: 'Adınız',
                prefixIcon: Icon(FontAwesomeIcons.userAlt)),
          ),
        ],
      ),
    );
  }
}

class _AppRegister extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const _AppRegister({Key? key, required this.formKey}) : super(key: key);

  void _register() {
    if (this.formKey.currentState!.validate()) {
      this.formKey.currentState!.save();
      print('ok');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                primary: context.primaryColor,
                padding: const EdgeInsets.all(appDefaultPadding - 10)),
            onPressed: _register,
            child: Text('Kayıt Ol',
                style: context.textTheme.headline6!
                    .copyWith(color: Colors.white))));
  }
}