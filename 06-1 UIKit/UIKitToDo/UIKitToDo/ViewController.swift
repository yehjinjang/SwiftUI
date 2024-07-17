//
//  ViewController.swift
//  UIKitToDo
//
//  Created by 장예진 on 5/24/24.
//

import UIKit
import UserNotifications

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView!
    var todos: [ToDo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "To-Do List"
        setupTableView()
        setupNavigationBar()
        loadData()
        requestNotificationAuthorization()

        // Long Press Gesture Recognizer 추가
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        tableView.addGestureRecognizer(longPressGesture)
    }

    // 테이블 뷰 설정 함수
    func setupTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ToDoCell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // 네비게이션 바 설정
    func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToDo))
        navigationItem.rightBarButtonItem = addButton
    }

    // 새로운 할 일 추가
    @objc func addToDo() {
        let addVC = AddToDoViewController()
        addVC.delegate = self
        let navController = UINavigationController(rootViewController: addVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }

    // 저장된 할 일 데이터 로드
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "todos"),
           let savedTodos = try? JSONDecoder().decode([ToDo].self, from: data) {
            todos = savedTodos
        }
        sortTodos()
    }

    // 할 일 데이터 저장 함수 + 위젯 활동 추가
    func saveData() {
        if let data = try? JSONEncoder().encode(todos) {
            UserDefaults.standard.set(data, forKey: "todos")
            UserDefaults(suiteName: "group.com.UIKitToDo.widget")?.set(data, forKey: "todos")
            print("Data saved: \(todos)")
        }
    }

    // 할 일 정렬 함수
    func sortTodos() {
        todos.sort(by: {
            if $0.isPending != $1.isPending {
                return !$0.isPending
            } else if $0.isFavorite != $1.isFavorite {
                return $0.isFavorite && !$1.isFavorite
            } else {
                return ($0.dueDate ?? Date.distantFuture) < ($1.dueDate ?? Date.distantFuture)
            }
        })
    }

    // 테이블 뷰 행의 개수를 반환해줌
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    // 테이블 뷰 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        let toDo = todos[indexPath.row]
        var config = cell.defaultContentConfiguration()
        config.text = toDo.isFavorite ? "⭐️ " + toDo.title : toDo.title

        if let dueDate = toDo.dueDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .short
            config.secondaryText = formatter.string(from: dueDate)
        } else if toDo.isPending {
            config.secondaryText = "yet"
            config.secondaryTextProperties.color = .red
        } else {
            config.secondaryText = ""
        }
        cell.contentConfiguration = config
        cell.accessoryType = toDo.isCompleted ? .checkmark : .none
        return cell
    }

    // - 할 일 편집 화면으로 전환
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDo = todos[indexPath.row]
        let editVC = AddToDoViewController()
        editVC.delegate = self
        editVC.toDo = toDo
        editVC.index = indexPath.row
        let navController = UINavigationController(rootViewController: editVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // 오른쪽 swipe - 삭제
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            self.todos.remove(at: indexPath.row)
            self.saveData()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    // 왼쪽 swipe - isFavorite
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoriteAction = UIContextualAction(style: .normal, title: "Favorite") { (action, view, completionHandler) in
            self.todos[indexPath.row].isFavorite.toggle()
            self.sortTodos()
            self.saveData()
            self.tableView.reloadData()
            completionHandler(true)
        }
        favoriteAction.backgroundColor = .systemYellow
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }

    // 알람 권한 요청
    func requestNotificationAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if let error = error {
                print("Notification authorization error: \(error)")
            }
        }
    }

    // Long Press Gesture Recognizer를 처리하는 메서드 추가
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let point = gesture.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: point) {
                showStatusOptions(for: indexPath)
            }
        }
    }

    // 상태 변경 옵션을 표시하는 메서드 추가
    func showStatusOptions(for indexPath: IndexPath) {
        let toDo = todos[indexPath.row]
        let alertController = UIAlertController(title: "Change Status", message: "Select the new status for this task", preferredStyle: .actionSheet)

        let completeAction = UIAlertAction(title: "Complete", style: .default) { _ in
            self.todos[indexPath.row].isCompleted = true
            self.todos[indexPath.row].isPending = false
            self.sortTodos()
            self.saveData()
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }

        let pendingAction = UIAlertAction(title: "Pending", style: .default) { _ in
            self.todos[indexPath.row].isCompleted = false
            self.todos[indexPath.row].isPending = true
            self.sortTodos()
            self.saveData()
            self.tableView.reloadData()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(completeAction)
        alertController.addAction(pendingAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
}

// AddToDoViewController의 델리게이트 메서드 구현
extension MainViewController: AddToDoViewControllerDelegate {
    // 새로운 할 일이 추가되었을 때 호출되는 함수
    func didAddToDo(_ toDo: ToDo) {
        todos.append(toDo)
        sortTodos()
        saveData()
        tableView.reloadData()
    }

    // 할 일이 수정되었을 때 호출되는 함수
    func didEditToDo(_ toDo: ToDo, at index: Int) {
        todos[index] = toDo
        sortTodos()
        saveData()
        tableView.reloadData()
    }
}
