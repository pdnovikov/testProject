//
//  SecondViewController.swift
//  eduardTestProject
//
//  Created by Novikov on 13.09.17.
//  Copyright © 2017 Novikov. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class SecondViewController: UIViewController, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    
        var mans = [People]()
        override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.dataSource = self
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
            }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Name : \(mans[indexPath.row].name!)" + "\nEmail : \(mans[indexPath.row].email!)" + "\nBirthday : \(mans[indexPath.row].birthday!)"
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mans.count
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let manager = DataCoreManger()
        mans = manager.getAll()
        tableView.reloadData()
    }
}

