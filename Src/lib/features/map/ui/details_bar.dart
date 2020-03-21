/// Authored by `@yuwonom (Michael Yuwono)`

import 'dart:async';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:vsa/features/map/viewmodels/details_viewmodel.dart';
import 'package:vsa/state.dart';
import 'package:vsa/themes/theme.dart';

class DetailsBar extends StatefulWidget {
  DetailsBar(this.viewModel) : assert(viewModel != null);

  final DetailsViewModel viewModel;

  @override
  _DetailsBarState createState() => _DetailsBarState();
}

class _DetailsBarState extends State<DetailsBar> with TickerProviderStateMixin {
  static const Duration animationDuration = const Duration(milliseconds: 100);
  static const double appBarSized = 60.0;
  static const double heightMinimized = 25.0;
  static const double heightMaximized = 150.0;

  double currentHeight = heightMinimized;

  AnimationController _drawerController;
  Animation<double> _drawerAnimation;

  String _timeDisplay = "00:00:00";
  StreamSubscription _timerStream;

  @override
  void initState() {
    super.initState();
    _drawerController = AnimationController(duration: animationDuration, vsync: this);
    _drawerAnimation = Tween(begin: heightMinimized, end: heightMaximized).animate(_drawerController);

    _timerStream = Stream.periodic(Duration(seconds: 1)).listen((_) {
      if (!widget.viewModel.connectedToBroker) {
        return;
      }

      setState(() {
        final diff = DateTime.now().difference(widget.viewModel.startTime);
        _timeDisplay = _getRideDurationDisplay(diff.inMilliseconds);
      });
    });
  }

  @override
  Widget build(BuildContext context) => StoreBuilder<AppState>(builder: _buildPage);

  Widget _buildPage(BuildContext context, Store<AppState> store) {
    final content = Container(
      height: currentHeight,
      color: AppColors.white,
      child: _createDetails(context),
    );

    final gesture = GestureDetector(
      onVerticalDragUpdate: _updateHeight,
      onVerticalDragEnd: _finalizeHeight,
      child: content,
    );

    final animatedBuilder = AnimatedBuilder(
      animation: _drawerController,
      builder: (BuildContext context, Widget child) => gesture,
    );

    return animatedBuilder;
  }

  void _updateHeight(DragUpdateDetails details) => setState(() {
        final targetHeight = (details.globalPosition.dy - appBarSized).clamp(heightMinimized, heightMaximized);
        currentHeight = lerpDouble(currentHeight, targetHeight, 0.3);
      });

  void _finalizeHeight(DragEndDetails details) {
    final projectedHeight = currentHeight + (details.velocity.pixelsPerSecond.dy * (animationDuration.inMilliseconds / 1000));
    final diffToMin = (projectedHeight - heightMinimized).abs();
    final diffToMax = (projectedHeight - heightMaximized).abs();
    final target = diffToMin < diffToMax ? heightMinimized : heightMaximized;

    final drawerCurve = CurvedAnimation(parent: _drawerController, curve: Curves.easeOut);
    _drawerAnimation = Tween(begin: currentHeight, end: target).animate(drawerCurve);
    _drawerAnimation.addListener(() => setState(() => currentHeight = _drawerAnimation.value));

    setState(() {
      _drawerController.reset();
      _drawerController.forward();
    });
  }

  Widget _createDetails(BuildContext context) {
    final divider = Container(
      color: AppColors.black,
      width: 1.5,
      height: 100.0,
    );

    final details = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Column(
          children: <Widget>[
            _createItem(_timeDisplay, "Elapsed Time"),
            _createItem(widget.viewModel.securityLevelText, "Security Level"),
          ],
        ),
        divider,
        Column(
          children: <Widget>[
            _createItem(widget.viewModel.currentSpeedText, "Speed (km/h)"),
            _createItem(widget.viewModel.averageSpeedText, "Avg (km/h)"),
          ],
        ),
        divider,
        Column(
          children: <Widget>[
            _createItem(widget.viewModel.distanceText, "Distance (km)"),
            _createItem("${widget.viewModel.accuracyText} m", "Accuracy"),
          ],
        ),
      ],
    );

    final handle = Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Icon(Icons.drag_handle, color: AppColors.darkGray, size: 24.0),
    );

    return OverflowBox(
      alignment: Alignment.bottomCenter,
      maxHeight: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget> [
          details,
          handle,
        ],
      ),
    );
  }

  Widget _createItem(String title, String description) => Padding(
      padding: AppEdges.tinyVertical,
      child: Column(
        children: <Widget>[
          Padding(
            padding: AppEdges.tinyVertical,
            child: Text(title, style: AppTextStyles.subtitle1.copyWith(color: AppColors.black), textAlign: TextAlign.center),
          ),
          Text(description, style: AppTextStyles.caption.copyWith(color: AppColors.black, letterSpacing: 0.4), textAlign: TextAlign.center),
        ],
      ),
    );

  String _getRideDurationDisplay(int milliseconds) {
    var seconds = (milliseconds / 1000).truncate();
    var minutes = (seconds / 60).truncate();
    var hours = (minutes / 60).truncate();

    var ss = (seconds % 60).toStringAsFixed(0).padLeft(2, "0");
    var mm = (minutes % 60).toStringAsFixed(0).padLeft(2, "0");
    var hh = hours.toStringAsFixed(0).padLeft(2, "0");
    return "$hh:$mm:$ss";
  }

  @override
  void dispose() {
    _drawerController.dispose();
    _timerStream.cancel();
    super.dispose();
  }
}