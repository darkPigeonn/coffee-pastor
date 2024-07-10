import UIKit
import Flutter
import GoogleMaps
import flutter_local_notifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
        // This is required to make any communication available in the action isolate.
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
        GeneratedPluginRegistrant.register(with: registry)
    }

    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }

    GeneratedPluginRegistrant.register(with: self)

        // TODO: Add your Google Maps API
    GMSServices.provideAPIKey("AIzaSyDiFvuhWWNGn99d3VtIZlZxZaozMIpiTDA")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
