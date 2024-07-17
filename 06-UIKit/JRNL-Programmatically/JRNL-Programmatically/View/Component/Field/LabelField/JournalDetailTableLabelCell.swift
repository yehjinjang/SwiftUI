//
//  JournalDetailTableLabelCell.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/10/24.
//

import UIKit

final class JournalDetailTableLabelCell: BaseTableViewCell {
    override class var identifier: String { "JournalDetailTableLabelCell" }
    
    // MARK - Components
    private lazy var label: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override func configureUI() {
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let marginGuide = layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: marginGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
        ])
    }
    
    override func setup(with contentType: CellContentType) {
        if case let .label(labelString, labelAlignment) = contentType {
            label.text = labelString
            label.textAlignment = labelAlignment
        }
    }
}
