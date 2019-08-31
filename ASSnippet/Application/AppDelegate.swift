//
//  AppDelegate.swift
//  ASSnippet
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    // MARK: - Parameters
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)

        // Initial controller
        showSplashController()
        
        // Environment
        #if Production
            print("Production")
        #endif
        
        #if Staging
            print("Staging")
        #endif
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}


// MARK: - Private Methods

extension AppDelegate {
    
    class func getAppDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    class func getApplication() -> UIApplication {
        return UIApplication.shared
    }
    
    func changeRootViewController(withController rootViewController: UIViewController) {
        if let snapshot = (UIApplication.shared.keyWindow?.snapshotView(afterScreenUpdates: true)) {
            rootViewController.view.addSubview(snapshot);
            
            self.window?.rootViewController = rootViewController
            self.window?.makeKeyAndVisible()
            
            UIView.transition(with: snapshot, duration: 0.5, options: .transitionCrossDissolve, animations: {
                snapshot.layer.opacity = 0;
            }, completion: { (status) in
                snapshot.removeFromSuperview()
            })
        } else {
            self.window?.rootViewController = rootViewController
            self.window?.makeKeyAndVisible()
        }
    }
    
    func showSplashController() {
        changeRootViewController(withController: RouteManager.splashViewController())
    }
    
}


// MARK: - Properties
// MARK: - Lifecycle Methods
// MARK: - Helping Methods
// MARK: - Action Methods
// MARK: - Custom Configurations
// MARK: - Private Methods

