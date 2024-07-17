//
//  AddJournalViewController.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/9/24.
//

import UIKit

protocol JournalSendable: NSObject {
    func sendJournal(_ journal: Journal)
}

final class AddJournalViewController: UIViewController {
    // MARK: - Components
    private lazy var mainContainer: UIStackView = {
        let mainContainer = UIStackView()
        mainContainer.axis = .vertical
        mainContainer.alignment = .center
        mainContainer.distribution = .fill
        mainContainer.spacing = 40
        
        return mainContainer
    }()
    
    private lazy var topStackView: UIStackView = {
        let topStackView = UIStackView()
        topStackView.axis = .vertical
        topStackView.alignment = .fill
        topStackView.distribution = .fill
        topStackView.spacing = 0
        topStackView.backgroundColor = .systemCyan
        
        return topStackView
    }()
    
    private lazy var switchView: UISwitch = {
        let switchView = UISwitch()
        
        return switchView
    }()
    
    private lazy var switchLabel: UILabel = {
        let switchLabel = UILabel()
        switchLabel.text = "switch label"
        
        return switchLabel
    }()
    
    private lazy var switchContainer: UIStackView = {
        let switchContainer = UIStackView()
        switchContainer.axis = .horizontal
        switchContainer.alignment = .fill
        switchContainer.distribution = .fill
        switchContainer.spacing = 8
        
        return switchContainer
    }()
    
    private lazy var journalTextField: UITextField = {
        let journalTextField = UITextField()
        journalTextField.placeholder = "Journal Title"
        
        return journalTextField
    }()
    
    private lazy var journalTextView: UITextView = {
        let journalTextView = UITextView()
        journalTextView.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        
        return journalTextView
    }()
    
    private lazy var journalImageView: UIImageView = {
        let journalImageView = UIImageView()
        journalImageView.image = UIImage(systemName: "face.smiling")
        
        return journalImageView
    }()
    
    weak var delegate: JournalSendable?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavigationItems()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        switchContainer.addArrangedSubview(switchView)
        switchContainer.addArrangedSubview(switchLabel)
        
        mainContainer.addArrangedSubview(topStackView)
        mainContainer.addArrangedSubview(switchContainer)
        mainContainer.addArrangedSubview(journalTextField)
        mainContainer.addArrangedSubview(journalTextView)
        mainContainer.addArrangedSubview(journalImageView)
        
        view.addSubview(mainContainer)
        
        mainContainer.translatesAutoresizingMaskIntoConstraints = false
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        switchContainer.translatesAutoresizingMaskIntoConstraints = false
        journalTextField.translatesAutoresizingMaskIntoConstraints = false
        journalTextView.translatesAutoresizingMaskIntoConstraints = false
        journalImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let global = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: global.topAnchor, constant: 20),
            mainContainer.leadingAnchor.constraint(equalTo: global.leadingAnchor, constant: 20),
            mainContainer.trailingAnchor.constraint(equalTo: global.trailingAnchor, constant: -20),
            
            topStackView.widthAnchor.constraint(equalToConstant: 252),
            topStackView.heightAnchor.constraint(equalToConstant: 44),
            
            journalTextField.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 8),
            journalTextField.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -8),

            journalTextView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 8),
            journalTextView.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -8),
            journalTextView.heightAnchor.constraint(equalToConstant: 128),
            
            journalImageView.widthAnchor.constraint(equalToConstant: 200),
            journalImageView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    private func configureNavigationItems() {
        navigationItem.title = "New Entry"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveEntry)
        )
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancel)
        )
    }
    
    @objc private func saveEntry() {
        guard let title = journalTextField.text else { return }
        guard let description = journalTextView.text else { return }
        
        delegate?.sendJournal(
            Journal(
                rating: 5,
                journalTitle: title,
                journalDescription: description,
                photoUrl: "face.smiling"
            )
        )
        dismiss(animated: true)
    }
    
    @objc private func cancel() {
        dismiss(animated: true)
    }
}
