//
//  ViewController.swift
//  TableViewWithSections
//
//  Created by siddharth on 17/12/18.
//  Copyright © 2018 clarionTechnologies. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let cellId = "cell"
    
    var twoDArray = [
        ExpandableNames(isExpanded: true, names: ["Akash", "Ananya", "Anuj", "Anurag", "Bhargav", "Janvi", "Kunal", "Neeraj", "Siddharth", "Sneha", "Sushrut"]),
         ExpandableNames(isExpanded: true, names: ["Ghodekar", "Shrivastav", "Manerikar", "Gokhale", "Shirodkar", "Ganorkar", "Mane", "Sathe", "Srikumar", "Singhatkar"]),
         ExpandableNames(isExpanded: true, names: ["abc", "xyz", "pqr", "mno", "fgh"])
            
    ]
    
    var showIndexPaths = false
    
    @objc func handleShowIndexPath(button: UIButton){
        print("Attempting Reload of indexPath")
        
        var indexPathToArray = [IndexPath]()
        let section = button.tag
        for section in twoDArray.indices {
            for row in twoDArray[section].names.indices{
                print(section, row)
                let indexPath = IndexPath(row: row, section: section)
                indexPathToArray.append(indexPath)
            }
        }
       

        showIndexPaths = !showIndexPaths
        let animationStyles = showIndexPaths	 ? UITableView.RowAnimation.right : .left
        tableView.reloadRows(at: indexPathToArray, with: animationStyles)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "ShowIndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.backgroundColor = UIColor.yellow
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        button.addTarget(self, action: #selector(handleOpenClose), for: .touchUpInside)
        
        button.tag = section
        return button
        
//       let label = UILabel()
//       label.text = "Header"
//       label.backgroundColor = UIColor.lightGray
//       return label
    }
    
    @objc func handleOpenClose(button: UIButton){
        print("Opening/Closing")
        
        // DELETING ROWS TO CLOSE
        var indexPaths = [IndexPath]()
        let section = button.tag
        for row in twoDArray[section].names.indices {
            print(0,row)
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        //twoDArray[section].removeAll()
        let isExpanded = twoDArray[section].isExpanded
        twoDArray[section].isExpanded = !isExpanded
        
        button.setTitle(isExpanded ? "Open" : "Close", for: .normal)
        
        if isExpanded{
            tableView.deleteRows(at: indexPaths, with: .fade)
        }else{
            tableView.insertRows(at: indexPaths, with: .fade)
        }

    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDArray[section].isExpanded{return 0}
        return twoDArray[section].names.count
        

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        let name = twoDArray[indexPath.section].names[indexPath.row]
        cell.textLabel?.text = name
        if showIndexPaths {
            cell.textLabel?.text = "\(name)     Section: \(indexPath.section), Row: \(indexPath.row)"
        }
             return cell
    }
}

