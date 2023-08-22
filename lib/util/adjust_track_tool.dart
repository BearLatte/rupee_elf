import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_event.dart';

class ADJustTrackTool {
  static trackWith(String point) {
    AdjustEvent event = AdjustEvent(point);
    Adjust.trackEvent(event);
  }
}
