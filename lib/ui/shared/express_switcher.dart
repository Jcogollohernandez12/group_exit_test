import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_exito/core/resources/foundations/font_foundation.dart';
import 'package:group_exito/core/resources/gen/colors.gen.dart';
import 'package:group_exito/ui/shared/cubit/express_cubit.dart';

class ExpressSwitcher extends StatelessWidget {
  const ExpressSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpressCubit, bool>(
      builder: (BuildContext context, bool active) {
        return FloatingActionButton.extended(
          label: Text('Express', style: FontFoundation.title.regular16Lato.copyWith(color: ColorToken.exitoBlack)),
          backgroundColor: Colors.orange[800],
          onPressed: () => context.read<ExpressCubit>().toggle(),
          icon: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Switch(
                value: active,
                onChanged: (bool value) => context.read<ExpressCubit>().setActive(value),
                activeColor: Colors.white,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.orange[200],
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ],
          ),
        );
      },
    );
  }
}
