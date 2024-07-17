//
//  JournalDetailTableViewController.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/10/24.
//

import UIKit

final class JournalDetailTableViewController: UITableViewController {
    private let viewModel: JournalDetailTableViewModel
    
    init(viewModel: JournalDetailTableViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
    }
    
    private func register() {
        viewModel.fields.forEach { field in
            field.register(for: self.tableView)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let field = viewModel.fields[indexPath.row]
        return field.dequeue(for: tableView, at: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.fields.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = viewModel.fields[indexPath.row].height {
            return height
        } else {
            return UITableView.automaticDimension
        }
    }
}
