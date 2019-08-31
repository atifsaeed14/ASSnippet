//
//  SplashViewController.swift
//  ASSnippet
//

import UIKit

class SplashViewController: UIViewController {

    
    // MARK: - Properties
    
    var serverData: [Data] = []

    let appDelegate = AppDelegate.getAppDelegate()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
           // activityIndicator.color = themeColor
        }
    }
    
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showLoading()
        
        APIClient.fetchData().execute(onSuccess: { (dataResult) in
            self.hideLoading()
            ServiceData.savedServices = dataResult.data ?? []
            self.showHomeController()

        }) { (error) in
            self.hideLoading()
            if ServiceData.savedServices.count > 0 {
                self.showHomeController()
            } else {
                if let localizedError = error as? APIClientError {
                    print(localizedError.errorDescription)
                    self.showAlert(text: localizedError.errorDescription)
                }
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // MARK: - Helping Methods
    
    func showLoading() {
        view.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    func hideLoading() {
        DispatchQueue.main.async { [weak weakSelf = self] in
            weakSelf?.view.isUserInteractionEnabled = true
            weakSelf?.activityIndicator.stopAnimating()
            weakSelf?.activityIndicator.isHidden = true
        }
    }
    
    func showHomeController() {
        let navigationController = UINavigationController()
        navigationController.setViewControllers([RouteManager.homeViewController()], animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak weakSelf = self] in
            weakSelf?.hideLoading()
            self.appDelegate.changeRootViewController(withController: navigationController)
        }
    }
    
    func showAlert(text: String) {
        let alertController = UIAlertController(title: ApplicationTitle, message:
            text, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
