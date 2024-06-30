import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BaseWidgetContainer extends StatelessWidget {
  const BaseWidgetContainer({
    super.key,
    this.appBar,
    required this.body,
    this.canPop = true,
    this.onPopInvoked,
    this.resizeToAvoidBottomInset,
    this.scrollController,
    this.scrollPhysics,
    this.actvateScroll = false,
    this.floatingActionButton,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.drawer,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.drawerScrimColor,
    this.endDrawer,
    this.floatingActionButtonAnimator,
    this.floatingActionButtonLocation,
    this.onDrawerChanged,
    this.onEndDrawerChanged,
    this.primary = true,
    this.persistentFooterButtons,
    this.restorationId,
    this.scaffoldKey,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final bool? canPop;
  final Function(bool)? onPopInvoked;
  final bool? resizeToAvoidBottomInset;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final bool? actvateScroll;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Widget? drawer;
  final DragStartBehavior drawerDragStartBehavior;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final Color? drawerScrimColor;
  final Widget? endDrawer;
  final bool endDrawerEnableOpenDragGesture;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Function(bool)? onDrawerChanged;
  final Function(bool)? onEndDrawerChanged;
  final AlignmentDirectional persistentFooterAlignment;
  final List<Widget>? persistentFooterButtons;
  final bool primary;
  final String? restorationId;
  final Key? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop ?? true,
      onPopInvoked: onPopInvoked,
      child: Scaffold(
        appBar: appBar,
        body: actvateScroll ?? false
            ? SingleChildScrollView(
                controller: scrollController,
                physics: scrollPhysics ?? const NeverScrollableScrollPhysics(),
                child: body,
              )
            : body,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        floatingActionButton: floatingActionButton,
        backgroundColor: backgroundColor,
        bottomNavigationBar: bottomNavigationBar,
        bottomSheet: bottomSheet,
        drawer: drawer,
        drawerDragStartBehavior: drawerDragStartBehavior,
        drawerEdgeDragWidth: drawerEdgeDragWidth,
        drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
        drawerScrimColor: drawerScrimColor,
        endDrawer: endDrawer,
        endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
        extendBody: extendBody,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        floatingActionButtonAnimator: floatingActionButtonAnimator,
        floatingActionButtonLocation: floatingActionButtonLocation,
        onDrawerChanged: onDrawerChanged,
        onEndDrawerChanged: onEndDrawerChanged,
        persistentFooterAlignment: persistentFooterAlignment,
        persistentFooterButtons: persistentFooterButtons,
        primary: primary,
        restorationId: restorationId,
        key: scaffoldKey,
      ),
    );
  }
}
