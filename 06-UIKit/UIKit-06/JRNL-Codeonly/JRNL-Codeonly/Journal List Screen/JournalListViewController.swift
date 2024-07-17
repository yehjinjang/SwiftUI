//
//  ViewController.swift
//  JRNL-Codeonly
//
//  Created by Jungman Bae on 5/13/24.
//

import UIKit

// PLUS: 새 저널항목 추가화면에서 전ㄹ 목록화면으로 데이터전달, 테이븍ㄹ 뷰에서 행 제거하기, 텍스트필드 및 텍스트 델리게이트 메서드 구현, 지도기능 추가

//class JournalListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddJournalControllerDelegate {
//    lazy var tableView: UITableView = {
//        let tableView = UITableView()
//        return tableView
//    }()
//    var sampleJournalEntryData = SampleJournalEntryData()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        sampleJournalEntryData.createSampleJournalEntryData()
//
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(JournalListTableViewCell.self, forCellReuseIdentifier: "journalCell")
//
//        view.backgroundColor = .white
//        
//        view.addSubview(tableView)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        
//        let safeArea = view.safeAreaLayoutGuide
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
//        ])
//        
//        navigationItem.title = "Journal"
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
//                                                            target: self,
//                                                            action: #selector(addJournal))
//    }
//    
//    // MARK: - UITableViewDataSource
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        sampleJournalEntryData.journalEntries.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath) as! JournalListTableViewCell
//        let journalEntry = sampleJournalEntryData.journalEntries[indexPath.row]
//        cell.configureCell(journalEntry: journalEntry)
//        return cell
//    }
//    
//    // MARK: - UITableViewDelegate
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let journalEntry = sampleJournalEntryData.journalEntries[indexPath.row]
//        let journalDetailViewController = JournalDetailViewController(journalEntry: journalEntry)
//        show(journalDetailViewController, sender: self)
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        90
//    }
//
//    
//    // MARK: - Methods
//    @objc private func addJournal() {
//        let addJournalViewController = AddJournalViewController()
//        let navController = UINavigationController(rootViewController: addJournalViewController)
//        addJournalViewController.delegate = self
//        present(navController, animated: true)
//    }
//    
//    public func saveJournalEntry(_ journalEntry: JournalEntry) {
//        sampleJournalEntryData.journalEntries.append(journalEntry)
//        tableView.reloadData()
//    }
//
//}

class JournalListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddJournalControllerDelegate {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    var sampleJournalEntryData = SampleJournalEntryData()

    override func viewDidLoad() {
        super.viewDidLoad()
        sampleJournalEntryData.createSampleJournalEntryData()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(JournalListTableViewCell.self, forCellReuseIdentifier: "journalCell")

        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        navigationItem.title = "Journal"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addJournal))
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleJournalEntryData.journalEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath) as! JournalListTableViewCell
        let journalEntry = sampleJournalEntryData.journalEntries[indexPath.row]
        cell.configureCell(journalEntry: journalEntry)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let journalEntry = sampleJournalEntryData.journalEntries[indexPath.row]
        let journalDetailViewController = JournalDetailViewController(journalEntry: journalEntry)
        show(journalDetailViewController, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    // 행 삭제 기능 구현
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            sampleJournalEntryData.journalEntries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - Methods
    @objc private func addJournal() {
        let addJournalViewController = AddJournalViewController()
        let navController = UINavigationController(rootViewController: addJournalViewController)
        addJournalViewController.delegate = self
        present(navController, animated: true)
    }
    
    public func saveJournalEntry(_ journalEntry: JournalEntry) {
        sampleJournalEntryData.journalEntries.append(journalEntry)
        tableView.reloadData()
    }
}
