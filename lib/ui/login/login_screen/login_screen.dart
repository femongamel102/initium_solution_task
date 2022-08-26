import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:initium_project/bussiness_logic/app_bloc/bloc.dart';
import 'package:initium_project/bussiness_logic/app_bloc/state.dart';
import 'package:initium_project/shared/navigate.dart';
import 'package:initium_project/ui/common/custom_app_bar.dart';
import 'package:initium_project/ui/common/custom_txt_field.dart';
import 'package:initium_project/ui/common/register_btn.dart';
import 'package:initium_project/ui/home/widgets/logo_widget.dart';
import '../../home/home_screen/home_page.dart';

final registerformKey = GlobalKey<FormState>();
final nameController = TextEditingController();

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBloc = AppBloc.get(context);
    return Scaffold(
      backgroundColor: Colors.white,
      //a custom app bar widget
      appBar: customAppBar(
        context,
        'Login',
        const SizedBox(),
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: backIcon(context),
        ),
      ),
      body: SingleChildScrollView(
        //this form for the name textfiled for validation
        child: Form(
          key: registerformKey,
          child: Column(
            children: [
              //this an image widget
              const LogoWidget(imgPath: 'assets/images/initiumBanner.png'),
              const SizedBox(height: 30),
              //using custom text filed design
              CustomFormTxtField(controller: nameController),
              //if name is validate,enroll button will navigate to the questions
              BlocBuilder<AppBloc, AppStates>(
                builder: (context, state) => ButtonWidget('Login', () async {
                  if (registerformKey.currentState!.validate()) {
                    //save guest in shared preferences
                    appBloc.setCurrentGuest(nameController.text);
                    //change logged in bool
                    appBloc.changeLoggedIn();
                    //navigate to question screen
                    navigateAndFinish(context, const HomePage());
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
