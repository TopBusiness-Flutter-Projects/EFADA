// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:efada/controller/system_controller.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:efada/config/app_config.dart';
import 'package:efada/screens/Login.dart';
import 'package:efada/utils/FunctinsData.dart';
import 'package:efada/utils/Utils.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: 60.0, end: 120.0).animate(controller);
    controller.forward();

    Route route;

    Future.delayed(Duration(seconds: 3), () {
      getBooleanValue('isLogged').then((value) {
        if (value) {
          final SystemController _systemController =
              Get.put(SystemController());
          _systemController.getSystemSettings();
          Utils.getStringValue('rule').then((rule) {
            Utils.getStringValue('zoom').then((zoom) {
              AppFunction.getFunctions(context, rule, zoom);
            });




          });
        } else {
          if (mounted) {
            route = MaterialPageRoute(builder: (context) => LoginScreen());
            Navigator.pushReplacement(context, route);
          }
        }
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) {
                        return Container(
                          height: animation.value,
                          width: animation.value,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: ExactAssetImage(AppConfig.appLogo),
                            ),
                          ),
                        );
                      },
                    ),

                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 80.0, left: 40, right: 40),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> getBooleanValue(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }
}
