//
//  JournalTableCell.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/9/24.
//

import UIKit

final class JournalTableCell: BaseTableViewCell {
    override class var identifier: String { "JournalTableCell" }
    
    // MARK: - Components
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "title label"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        return titleLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "description label"
        
        return descriptionLabel
    }()
    
    private lazy var thumbnailView: UIImageView = {
        let thumbnailView = UIImageView()
        thumbnailView.image = UIImage(systemName: "face.smiling")?.withRenderingMode(.automatic)
        thumbnailView.contentMode = .scaleAspectFit
        
        return thumbnailView
    }()
    
    override func configureUI() {
        addSubview(thumbnailView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let global = safeAreaLayoutGuide
        let marginGuide = layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            thumbnailView.topAnchor.constraint(equalTo: global.topAnchor),
            thumbnailView.leadingAnchor.constraint(equalTo: global.leadingAnchor),
            thumbnailView.bottomAnchor.constraint(equalTo: global.bottomAnchor),
            thumbnailView.widthAnchor.constraint(equalToConstant: 90),
            
            titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: 8),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: 8)
        ])
    }
    
    func setup(with journal: Journal) {
        titleLabel.text = journal.journalTitle
        descriptionLabel.text = journal.journalDescription
        thumbnailView.image = UIImage(systemName: journal.photoUrl ?? "")
    }
}
