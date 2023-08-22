import 'package:facebook_app_events/facebook_app_events.dart';

enum FacebookTrackType { registration, addToCard }

class FacebookTrankTool {
  static trackWith(FacebookTrackType point) {
    final FacebookAppEvents facebookAppEvents = FacebookAppEvents();
    switch (point) {
      case FacebookTrackType.registration:
        facebookAppEvents.logCompletedRegistration();
      case FacebookTrackType.addToCard:
        facebookAppEvents.logAddToCart(
          id: 'id',
          currency: '0000',
          price: 0.0,
          type: '000',
        );
    }
  }
}
