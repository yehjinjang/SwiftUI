//
//  BaseTableViewCell.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/10/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    class var identifier: String { "BaseTableViewCell" }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() { }
    
    func setup(with contentType: CellContentType) { }
}
