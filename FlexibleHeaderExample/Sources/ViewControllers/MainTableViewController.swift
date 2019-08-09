//
//  MainTableViewController.swift
//  FlexibleHeaderExample
//
//  Created by DongHeeKang on 05/08/2019.
//  Copyright © 2019 k-lpmg. All rights reserved.
//

import UIKit

final class MainTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    private let sections = SectionType.allCases
    
    // MARK: - Overridden: UITableViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setProperties()
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].headerTitle
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = sections[indexPath.section].cellTitleFor(row: indexPath.row)
        cell.textLabel?.font = .systemFont(ofSize: 15, weight: .light)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        }
        
        sections[indexPath.section].didSelectAt(row: indexPath.row, with: self)
    }
    
    // MARK: - Private methods
    
    private func setProperties() {
        title = "FlexibleHeader Examples"
        view.backgroundColor = .white
    }
    
}
