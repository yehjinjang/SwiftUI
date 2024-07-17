//
//  CommonField.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/10/24.
//

import UIKit

protocol CommonField {
    var height: CGFloat? { get }
    
    func register(for tableView: UITableView)
    func dequeue(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
}

struct CellField<CellType: BaseTableViewCell>: CommonField {
    var cellContentType: CellContentType
    var height: CGFloat? = nil
    
    func register(for tableView: UITableView) {
        tableView.register(CellType.self, forCellReuseIdentifier: CellType.identifier)
    }
    
    func dequeue(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellType.identifier, for: indexPath) as? CellType else {
            return UITableViewCell()
        }
        cell.setup(with: cellContentType)
        
        return cell
    }
}
