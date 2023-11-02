import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/button/rounded_btn.dart';
import 'package:rt_10055_2D_configurator_suite/components/atom/input/text_field.dart';
import 'package:rt_10055_2D_configurator_suite/providers/auth_provider/auth_events.dart';
import 'package:rt_10055_2D_configurator_suite/providers/auth_provider/auth_state_controller.dart';
import 'package:rt_10055_2D_configurator_suite/providers/auth_provider/auth_states.dart';
import 'package:rt_10055_2D_configurator_suite/utils/size.dart';

class SignupPage extends HookConsumerWidget {
  const SignupPage({super.key});
  static const String name = '/signup';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController usernameController = useTextEditingController();
    final FocusNode usernameFocusNode = useFocusNode();
    final TextEditingController passwordController = useTextEditingController();
    final FocusNode passwordFocusNode = useFocusNode();

    final authState = ref.watch(authProvider);
    final authEvents = ref.watch(authProvider.notifier);
    final isButtonsEnabled = useState<bool>(true);

    final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

    /// This is the listener for the auth state
    /// these states come from the [AuthStateController]
    ///
    ref.listen<AuthStates>(
      authProvider,
      (oldsState, newState) {
        if (newState is AuthSuccessState) {
          isButtonsEnabled.value = true;
          if (newState.user != null) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text("User Created Successfully"),
              ),
            );
            context.go('/');
          }
        } else if (newState is AuthErrorState) {
          isButtonsEnabled.value = true;
          //TODO: change according to design
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(newState.errorMessage),
            ),
          );
        } else if (newState is AuthLoadingState) {
          isButtonsEnabled.value = false;
          //TODO: change according to designs
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Loading...'),
              duration: Duration(seconds: 1),
            ),
          );
        }
      },
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            width: getDeviceWidth(context),
            height: getDeviceHeight(context),
            child: Form(
              key: loginFormKey,
              child: Column(
                children: [
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: CeerTextField(
                      width: getDeviceWidth(context) * 0.3,
                      hint: 'EMAIL/USERNAME',
                      controller: usernameController,
                      focusNode: usernameFocusNode,
                      isObfuscated: false,
                      isReadOnly: !isButtonsEnabled.value,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: CeerTextField(
                      width: getDeviceWidth(context) * 0.3,
                      hint: 'PASSWORD',
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      isObfuscated: true,
                      isReadOnly: !isButtonsEnabled.value,
                    ),
                  ),
                  RoundedBtn(
                    width: getDeviceWidth(context) * 0.3,
                    isDisabled: !isButtonsEnabled.value,
                    onTap: () {
                      if (loginFormKey.currentState!.validate()) {
                        authEvents.mapEventsToStates(
                          AuthEvents.signUpWithemail(
                              nickname: usernameController.text,
                              password: passwordController.text),
                        );
                      }
                    },
                    text: 'SIGN UP',
                  ),
                  RoundedBtn(
                    width: getDeviceWidth(context) * 0.3,
                    isDisabled: !isButtonsEnabled.value,
                    onTap: () {
                      if (loginFormKey.currentState!.validate()) {
                        authEvents.mapEventsToStates(
                          AuthEvents.socialAuth(
                            type: SocialAuthType.google,
                          ),
                        );
                      }
                    },
                    text: 'Signup with Google',
                  ),
                  const Spacer()
                ],
              ),
            )));
  }
}
/*
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  static const String name = '/login';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final FocusNode usernameFocusNode = FocusNode();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  late final authState;
  late final authEvents;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authState = ref.watch(authProvider);
    authEvents = ref.watch(authProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    return AppTemplate(
        backgroundColor: Colors.black,
        body: MainTemplate(
            body: Column(
          children: [
            Padding(
              padding: marginBottom12,
              child: CeerTextField(
                width: getDeviceWidth(context) * 0.3,
                hint: 'EMAIL/USERNAME',
                controller: usernameController,
                focusNode: usernameFocusNode,
                isObfuscated: false,
              ),
            ),
            Padding(
              padding: marginBottom24,
              child: CeerTextField(
                width: getDeviceWidth(context) * 0.3,
                hint: 'PASSWORD',
                controller: passwordController,
                focusNode: passwordFocusNode,
                isObfuscated: true,
              ),
            ),
            RoundedBtn(
              width: getDeviceWidth(context) * 0.3,
              onTap: () {},
              text: 'LOGIN',
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, SignupPage.name);
              },
              child: Text(
                'Don\'t have an account? Sign up here.',
                style: bodyTextStyle,
              ),
            )
          ],
        )));
  }
}
*/
