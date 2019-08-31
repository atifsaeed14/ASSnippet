//
//  RouteManager.swift
//  ASSnippets
//

import UIKit
import Foundation

class RouteManager {
    
    static func splashViewController() -> SplashViewController {
        return  SplashViewController(nibName: "SplashViewController", bundle: nil)
    }
    
    static func homeViewController() -> HomeViewController {
        return  HomeViewController(nibName: "HomeViewController", bundle: nil)
    }
    
}
