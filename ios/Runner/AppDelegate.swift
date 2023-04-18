import UIKit
import Flutter


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate  {

    let appGroupUat = "group.com.myairline.mobileapp.uat"

    let appGroup = "group.com.myairline.mobileapp"

    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
      UNUserNotificationCenter.current().delegate = self

      if let bundleIdentifier = Bundle.main.bundleIdentifier {
          print("Bundle Identifier: \(bundleIdentifier)")
          Insider.initWithLaunchOptions(launchOptions, partnerName: bundleIdentifier == "com.myairline.mobileapp.uat" ? "myairlineuat" : "myairline" , appGroup: bundleIdentifier == "com.myairline.mobileapp.uat" ? appGroupUat : appGroup)
          Insider.register(withQuietPermission: false)
      }
      
      GeneratedPluginRegistrant.register(with: self)
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    

    
    
 

    
    
    
    
}

