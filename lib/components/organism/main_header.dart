import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rt_10055_2D_configurator_suite/theme/typography.dart';

class MainHeader extends StatelessWidget {
  bool loggedIn;
  final VoidCallback onLogoTap;
  final VoidCallback onAccountTap;
  final VoidCallback onLogoutTap;
  String accountImage;

  MainHeader(
      {super.key,
      required this.loggedIn,
      required this.onLogoTap,
      required this.onAccountTap,
      required this.onLogoutTap,
      required this.accountImage});

  @override
  Widget build(BuildContext context) {
    String logoIcon = 'assets/icons/logo.png';

    return Container(
      color: const Color(0xFF8B8764),
      padding: const EdgeInsets.only(top: 4, bottom: 4, right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text('hui'),
          GestureDetector(
            onTap: onLogoTap,
            child: Image.asset(
              logoIcon,
            ),
          ),

          Row(
            children: [
              if (loggedIn)
                InkWell(
                    onTap: onLogoutTap,
                    child: Text('Logout',
                        style:
                            paragraphTextStyle.copyWith(color: Colors.white))),
              const SizedBox(
                width: 8,
              ),
              InkWell(
                onTap: onAccountTap,
                child: loggedIn
                    ? Image(
                        image: NetworkImage(accountImage),
                        errorBuilder: (context, object, stacktrace) {
                          print(stacktrace);
                          return const Icon(
                            Icons.person_outlined,
                            color: Colors.white,
                          );
                        })
                    : const Icon(
                        Icons.person_outlined,
                        color: Colors.white,
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
