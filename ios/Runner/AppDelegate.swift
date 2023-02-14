import UIKit
import Flutter



//class AppDelegate: UIResponder, UIApplicationDelegate,


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate  {
    
    let appGroup = "group.com.myairline.mobileapp.uat"

    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
      UNUserNotificationCenter.current().delegate = self

      //insider api key 9NSEqzLBz0quco87ih2AwhG0IUV7suyj
      
      Insider.initWithLaunchOptions(launchOptions, partnerName: "myairlineuat", appGroup: appGroup)
      Insider.register(withQuietPermission: false)
      
      
      GeneratedPluginRegistrant.register(with: self)
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
