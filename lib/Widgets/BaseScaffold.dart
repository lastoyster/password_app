import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import '/UI/ui.dart';
import '/Widgets/widgets.dart';
import 'package:connectivity/connectivity.dart';

class BaseScaffold extends StatefulWidget {
  final String header;
  final Widget? bottom;
  final Widget? drawer;
  final bool isLoading;
  final bool withBottomSpace;
  final String? subHeader;
  final IconData appBarIcon;
  final List<Widget> widgets;
  final Function? appBarAction;

  const BaseScaffold({
    required this.header,
    required this.widgets,
    this.appBarIcon = FontAwesome5.chevron_left,
    this.drawer,
    this.bottom,
    this.subHeader,
    this.appBarAction,
    this.isLoading = false,
    this.withBottomSpace = false,
  });

  @override
  _BaseScaffoldState createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  late final StreamSubscription<ConnectivityResult> subscription;
  late final KeyboardVisibilityController keyboardVisibilityController;
  bool internetConnection = true;
  bool keyboardVisibility = false;

  @override
  void initState() {
    super.initState();

    keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange.listen((bool visible) {
      if (mounted) {
        setState(() {
          keyboardVisibility = visible;
        });
      }
    });

    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        internetConnection = result != ConnectivityResult.none;
      });
    });

    checkConnectivity();
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      internetConnection = connectivityResult != ConnectivityResult.none;
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: !internetConnection
          ? const NoInternet()
          : Scaffold(
              key: drawerKey,
              drawer: widget.drawer,
              body: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
                    child: CustomScrollView(
                      slivers: buildSlivers(),
                    ),
                  ),
                  getBottomWidget(),
                ],
              ),
            ),
    );
  }

  List<Widget> buildSlivers() {
    List<Widget> slivers = [
      SliverAppBar(
        backgroundColor: Palette.primaryLight,
        leadingWidth: 24.0,
        leading: GestureDetector(
          onTap: handleAppBarTap,
          child: Icon(
            widget.appBarIcon,
            color: Palette.primaryDark,
          ),
        ),
      ),
      Header(
        header: widget.header,
        subHeader: widget.subHeader,
      ),
      const SliverToBoxAdapter(child: Spacers.h32),
    ];

    slivers.addAll(widget.widgets.map((widget) => SliverToBoxAdapter(child: widget)).toList());

    if (widget.withBottomSpace) {
      slivers.add(const SliverToBoxAdapter(child: Spacers.customSpacer(100.0)));
    }

    return slivers;
  }

  void handleAppBarTap() {
    if (widget.appBarIcon == FontAwesome5.times) {
      SystemNavigator.pop();
    } else if (widget.drawer == null) {
      if (widget.appBarAction == null) {
        Navigator.pop(context);
      } else {
        widget.appBarAction!();
      }
    } else {
      drawerKey.currentState!.openDrawer();
    }
  }

  Widget getBottomWidget() {
    if (widget.isLoading) {
      return Container(
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 40.0),
        child:  Loading(),
      );
    } else if (widget.bottom != null && !keyboardVisibility) {
      return Container(
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 40.0),
        child: widget.bottom!,
      );
    } else {
      return const SizedBox();
    }
  }
}
