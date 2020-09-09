library progress_timeline;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ScreenProgress extends StatefulWidget {
  final List<SingleState> states;
  double height;
  Icon checkedIcon;
  Icon currentIcon;
  Icon failedIcon;
  Icon uncheckedIcon;
  Color connectorColor;
  double connectorLength;
  double connectorWidth;
  double iconSize;
  TextStyle textStyle;

  ScreenProgress(
      {@required this.states,
      this.height,
      this.checkedIcon,
      this.currentIcon,
      this.failedIcon,
      this.iconSize,
      this.textStyle,
      this.connectorLength,
      this.connectorWidth,
      this.connectorColor,
      this.uncheckedIcon});

  _ScreenProgressState state = new _ScreenProgressState();

  void gotoNextStage() {
    state.gotoNextStage();
  }

  void failCurrentStage() {
    state.failCurrentStage();
  }

  void gotoPreviousStage() {
    state.gotoPreviousStage();
  }

  @override
  _ScreenProgressState createState() => state;
}

class _ScreenProgressState extends State<ScreenProgress> {
  int currentStageIndex = 0;
  List<SingleState> states;
  double height = 100;

  final _controller = ItemScrollController();

  @override
  void initState() {
    states = widget.states;
    if (widget.height != null) {
      height = widget.height;
    }
    super.initState();
  }

  void gotoNextStage() {
    setState(() {
      if (currentStageIndex < states.length) {
        currentStageIndex++;
        _controller.scrollTo(
            index: currentStageIndex - 1,
            duration: Duration(milliseconds: 1000),
            curve: Curves.fastOutSlowIn);
      }
    });
  }

  void gotoPreviousStage() {
    setState(() {
      if (currentStageIndex >= 0) {
        states[currentStageIndex].isFailed = false;
      }

      if (currentStageIndex > 0) {
        currentStageIndex--;
        _controller.scrollTo(
            index: currentStageIndex - 1 >= 0
                ? currentStageIndex - 1
                : currentStageIndex,
            duration: Duration(milliseconds: 1000),
            curve: Curves.fastOutSlowIn);
      }
    });
  }

  void failCurrentStage() {
    setState(() {
      states[currentStageIndex].isFailed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: ScrollablePositionedList.builder(
        itemCount: buildStates().length,
        itemScrollController: _controller,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return buildStates()[index];
        },
      ),
    );
  }

  List<Widget> buildStates() {
    List<Widget> allStates = [];
    int len = states.length;
    print(len);
    for (var i = 0; i < states.length; i++) {
      print(i);
      allStates.add(_RenderedState(
        textStyle: widget.textStyle,
        connectorLength: widget.connectorLength,
        connectorWidth: widget.connectorWidth,
        connectorColor: widget.connectorColor,
        iconSize: widget.iconSize,
        checkedIcon: widget.checkedIcon,
        failedIcon: widget.failedIcon,
        currentIcon: widget.currentIcon,
        uncheckedIcon: widget.uncheckedIcon,
        stateNumber: i + 1,
        isCurrent: i == currentStageIndex,
        isFailed: states[i].isFailed,
        isChecked: i < currentStageIndex,
        stateTitle: states[i].stateTitle,
        isLeading: i == 0,
        isTrailing: i == states.length - 1,
      ));
    }

    return allStates;
  }
}

class _RenderedState extends StatelessWidget {
  Icon checkedIcon;
  Icon currentIcon;
  Icon failedIcon;
  Icon uncheckedIcon;
  bool isChecked;
  String stateTitle;
  TextStyle textStyle;
  bool isLeading;
  bool isTrailing;
  int stateNumber;
  bool isFailed;
  bool isCurrent;
  double iconSize;
  Color connectorColor;

  double connectorLength;
  double connectorWidth;

  _RenderedState(
      {@required this.isChecked,
      @required this.stateTitle,
      @required this.stateNumber,
      double iconSize,
      Color connectorColor,
      double connectorLength,
      double connectorWidth,
      TextStyle textStyle,
      this.failedIcon,
      this.currentIcon,
      this.checkedIcon,
      this.uncheckedIcon,
      this.isFailed = false,
      this.isCurrent,
      this.isLeading = false,
      this.isTrailing = false})
      : this.iconSize = iconSize ?? 25,
        this.connectorColor = connectorColor ?? Colors.green,
        this.connectorLength =
            connectorLength != null ? connectorLength / 2 : 40,
        this.connectorWidth = connectorWidth ?? 5,
        this.textStyle = textStyle ?? TextStyle();

  Widget line() {
    return Container(
      color: connectorColor,
      height: connectorWidth,
      width: connectorLength,
    );
  }

  Widget spacer() {
    return Container(
      width: 3.0,
    );
  }

  Widget getCheckedIcon() {
    return this.checkedIcon != null
        ? Icon(
            this.checkedIcon.icon,
            color: this.checkedIcon.color,
            size: iconSize,
          )
        : Icon(
            Icons.check_circle,
            color: Colors.green,
            size: iconSize,
          );
  }

  Widget getFailedIcon() {
    return this.failedIcon != null
        ? Icon(
            this.failedIcon.icon,
            color: this.failedIcon.color,
            size: iconSize,
          )
        : Icon(
            Icons.highlight_off,
            color: Colors.redAccent,
            size: iconSize,
          );
  }

  Widget getCurrentIcon() {
    return this.currentIcon != null
        ? Icon(
            this.currentIcon.icon,
            color: this.currentIcon.color,
            size: iconSize,
          )
        : Icon(
            Icons.adjust,
            color: Colors.green,
            size: iconSize,
          );
  }

  Widget getUnCheckedIcon() {
    return this.uncheckedIcon != null
        ? Icon(
            this.uncheckedIcon.icon,
            color: this.uncheckedIcon.color,
            size: iconSize,
          )
        : Icon(
            Icons.radio_button_unchecked,
            color: Colors.green,
            size: iconSize,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: isLeading
              ? const EdgeInsets.only(left: 30.0)
              : isTrailing
                  ? const EdgeInsets.only(right: 30.0)
                  : const EdgeInsets.all(0.0),
          child: Row(
            children: [
              if (!isLeading) line(),
              renderCurrentState(),
              if (!isTrailing) line(),
            ],
          ),
        ),
        Container(
            child: Text(
          stateTitle,
          style: textStyle,
        )),
      ],
    );
  }

  Widget renderCurrentState() {
    if (isFailed != null && isFailed) {
      return getFailedIcon();
    } else if (isChecked != null && isChecked) {
      return getCheckedIcon();
    } else if (isCurrent != null && isCurrent) {
      return getCurrentIcon();
    }
    return getUnCheckedIcon();
  }
}

class SingleState {
  bool isFailed;
  String stateTitle;

  SingleState({@required this.stateTitle, this.isFailed});
}
