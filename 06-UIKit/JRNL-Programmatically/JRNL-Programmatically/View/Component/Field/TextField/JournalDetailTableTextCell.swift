//
//  JournalDetailTableTextCell.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/10/24.
//

import UIKit

final class JournalDetailTableTextCell: BaseTableViewCell {
    override class var identifier: String { "JournalDetailTableTextCell" }
    
    // MARK - Components
    private lazy var textView: UITextView = {
        let textView = UITextView()
        
        return textView
    }()
    
    override func configureUI() {
        contentView.addSubview(textView)

        textView.translatesAutoresizingMaskIntoConstraints = false

        let marginGuide = layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: marginGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor)
        ])
    }

    override func setup(with contentType: CellContentType) {
        if case let .text(textString) = contentType {
            textView.text = textString
        }
    }
}
