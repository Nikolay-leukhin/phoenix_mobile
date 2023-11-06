import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:izobility_mobile/feature/auth/bloc/auth/auth_cubit.dart';
import 'package:izobility_mobile/routes/go_routes.dart';
import 'package:izobility_mobile/utils/logic/validators.dart';
import 'package:izobility_mobile/widgets/button/custom_button.dart';
import 'package:izobility_mobile/widgets/scaffold/auth_scaffold.dart';
import 'package:izobility_mobile/widgets/text_field/custom_text_field.dart';

class EnterNameScreen extends StatefulWidget {
  const EnterNameScreen({super.key});

  @override
  State<EnterNameScreen> createState() => _EnterNameScreenState();
}

class _EnterNameScreenState extends State<EnterNameScreen> {
  final TextEditingController nameController = TextEditingController();

  String? fieldError;
  bool buttonActive = false;

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 32,
          ),
          SvgPicture.asset(
            'assets/icons/logo.svg',
            width: 180,
          ),
          const SizedBox(
            height: 32,
          ),
          CustomTextField(
            hintText: 'Ваше имя',
            controller: nameController,
            width: double.infinity,
            labelText: "Как вас зовут",
            error: fieldError != null,
            errorText: fieldError,
            onChange: (v) {
              setState(() {
                fieldError = Validator.nameValidator((v ?? '').trim());
                buttonActive = fieldError == null;
              });
            },
          ),
          const SizedBox(
            height: 16,
          ),
          CustomButton(
              text: 'Далее',
              isActive: buttonActive,
              onTap: () {
                BlocProvider.of<AuthCubit>(context).registerData!.name =
                    nameController.text.trim();
                context.push(RouteNames.authCreatePassword);
              },
              width: double.infinity)
        ],
      ),
    );
  }
}
