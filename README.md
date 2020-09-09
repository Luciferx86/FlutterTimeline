# timeline_horizontal

#### A Flutter Widget to make interactive Progress Timeline.

This widget can be used to make provide an interactive timeline view of a bigger process.
Fluid Animations while switching between stages.


### Installation

To use this package:

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
    progress_timeline: ^0.0.2
```

### How to Use

Import the library
```dart
import 'package:progress_timeline/progress_timeline.dart';
```

Create a `ProgressTimeline` object in the state of your Activity

```dart
class _MyPageState extends State<MyPage> {
  ProgressTimeline progressTimeline;
.
.
.
}
```
Create a list of all the stages in your entire process and initialize the `progressTimeline` variable in `initState`.

```dart
@override
  void initState() {
  List<SingleState> allStages = [
    SingleState(stateTitle: "Stage 1"),
    SingleState(stateTitle: "Stage 2"),
    SingleState(stateTitle: "Stage 3"),
    SingleState(stateTitle: "Stage 4"),
  ];
    screenProgress = new ProgressTimeline(
        states: allStages,
    );
    super.initState();
  }
```

Add `progressTimeline` to your `build` method.

```dart
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
           //add the widget
           progressTimeline,
        ],
      ),
    );
  }
```


## Features

### Goto Next Stage
call the `.gotoNextStage()` method to move forward to the next stage in the process.

```dart
.
  onPressed: () {
    screenProgress.gotoNextStage();
  },
.
``` 


### Goto Previous Stage
call the `.gotoPreviousStage()` method to move back to the last stage in the process.

```dart
.
  onPressed: () {
    screenProgress.gotoPreviousStage();
  },
.
```


### Fail Current Stage
call the `.failCurrentStage()` method to mark the current stage as failed.

```dart
.
  onPressed: () {
    screenProgress.failCurrentStage();
  },
.
```

## Customization

You can pass your own Icons, Colors and Sizes for the respective parts of the timeline.

### Pass Custom Icons for each type of stage

While initializing the `ProgressTimeline` widget, pass Icon values for these stages: checked, unchecked, failed, current

```dart
@override
  void initState() {
    screenProgress = new ProgressTimeline(
      states: allStages,
      //pass custom icons for each stage.
      checkedIcon: Icon(
        Icons.check_box,
        color: Colors.greenAccent,
      ),
      uncheckedIcon: ..,
      currentIcon: ..,
      failedIcon: ..,
      
    );
    super.initState();
  }
``` 

### Customize Connector properties

While initializing the `ProgressTimeline` widget, customize the connector properties to suit your need.

```dart
@override
  void initState() {
    screenProgress = new ProgressTimeline(
      states: allStages,
      connectorColor: Colors.blueAccent,
      connectorLength: 120.0,
      connectorWidth: 10.0,
    );
    super.initState();
  }
```

### Customize Icon Size

While initializing the `ProgressTimeline` widget, customize the Icon Size according to your preference.

```dart
@override
  void initState() {
    screenProgress = new ProgressTimeline(
      states: allStages,
      iconSize: 20.0,
      //NOTE: when using bigger icon sizes, modify the height parameter accordingly
      //default value is 100
      height: 200,
    );
    super.initState();
  }
```

### Customize Stage Title TextStyle

While initializing the `ProgressTimeline` widget, customize the TextStyle of how the stage title is displayed

```dart
@override
  void initState() {
    screenProgress = new ProgressTimeline(
      states: allStages,
      textStyle: TextStyle(
        fontSize: 24,
        color: Colors.pink
      ),
    );
    super.initState();
  }
```
## List of all customizable params


|      Params     |    Type   |                             default-value                            |
|:---------------:|:---------:|:--------------------------------------------------------------------:|
|      height     |   double  |                                  100                                 |
|   checkedIcon   |    Icon   |      Icon ( Icons.check_circle, color: Colors.green, size:25 );      |
|   currentIcon   |    Icon   |         Icon ( Icons.adjust, color: Colors.green, size:25 );         |
|    failedIcon   |    Icon   |    Icon ( Icons.highlight_off, color: Colors.redAccent, size:25 );   |
|  uncheckedIcon  |    Icon   | Icon ( Icons.radio_button_unchecked, color: Colors.green, size:25 ); |
|  connectorColor |   Color   |                             Colors.green                             |
| connectorLength |   double  |                                  40                                  |
|  connectorWidth |   double  |                                   5                                  |
|     iconSize    |   double  |                                  25                                  |
|    textStyle    | TextStyle |                              TextStyle()                             |


