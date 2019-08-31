//
//  HomeViewController.swift
//  ASSnippet
//

import UIKit

class HomeViewController: UIViewController {

    
    // MARK: - Class Properties
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            //tableView.delegate = self
            tableView.estimatedRowHeight = 100.0
            tableView.rowHeight = UITableView.automaticDimension
            tableView.register(UINib(nibName: "HomeTableCell", bundle: nil), forCellReuseIdentifier: "HomeTableCell")
            tableView.tableFooterView = UIView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"

        // Do any additional setup after loading the view.
    }

}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ServiceData.savedServices.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell") as! HomeTableCell
        let data = ServiceData.savedServices[indexPath.row]
        cell.titleLabel.text = data.name
        var subArray:[String] = []
        for object in data.subServices! {
            subArray.append(object.name!)
        }
        cell.dataSource = subArray
        cell.collectionView.collectionViewLayout.invalidateLayout()
        cell.collectionView.reloadData()
        cell.selectionStyle = .none
        return cell
    }
    
}
