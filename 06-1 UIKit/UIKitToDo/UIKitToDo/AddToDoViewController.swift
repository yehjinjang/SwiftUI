//
//  AddToDoViewController.swift
//  UIKitToDo
//
//  Created by 장예진 on 5/24/24.
//


import UIKit
import UserNotifications

protocol AddToDoViewControllerDelegate: AnyObject {
    func didAddToDo(_ toDo: ToDo)
    func didEditToDo(_ toDo: ToDo, at index: Int)
}

class AddToDoViewController: UIViewController {
    var textField: UITextField!
    var datePicker: UIDatePicker!
    var isRecurringSwitch: UISwitch!
    weak var delegate: AddToDoViewControllerDelegate?
    
    var toDo: ToDo?
    var index: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = toDo == nil ? "Add To-Do" : "Edit To-Do"
        view.backgroundColor = .white
        setupNavigationBar()
        setupTextField()
        setupDatePicker()
        setupRecurringSwitch()
        loadData()
    }

    // 네비게이션 바 
    func setupNavigationBar() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.leftBarButtonItem = cancelButton
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem = saveButton
    }

    // 할 일 제목 입력 텍필설정
    func setupTextField() {
        textField = UITextField()
        textField.placeholder = "Insert To-Do"
        textField.borderStyle = .roundedRect
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    // 날짜 선택기 설정
    func setupDatePicker() {
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    // 반복 작업 스위치 설정
    func setupRecurringSwitch() {
        let label = UILabel()
        label.text = "Repeat Weekly"
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20)
        ])

        isRecurringSwitch = UISwitch()
        view.addSubview(isRecurringSwitch)
        isRecurringSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            isRecurringSwitch.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 10),
            isRecurringSwitch.centerYAnchor.constraint(equalTo: label.centerYAnchor)
        ])
    }

    // 기존 할 일 데이터를 로드하는
    func loadData() {
        if let toDo = toDo {
            textField.text = toDo.title
            datePicker.date = toDo.dueDate ?? Date()
            isRecurringSwitch.isOn = toDo.isRecurring
        }
    }

    // 취소 버튼 액션
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }

    // 저장 버튼 액션
    @objc func save() {
        guard let text = textField.text, !text.isEmpty else { return }
        let toDo = ToDo(
            title: text,
            isCompleted: self.toDo?.isCompleted ?? false,
            isFavorite: self.toDo?.isFavorite ?? false,
            dueDate: datePicker.date,
            isRecurring: isRecurringSwitch.isOn
        )
        if let index = index {
            delegate?.didEditToDo(toDo, at: index)
        } else {
            delegate?.didAddToDo(toDo)
        }
        scheduleNotification(for: toDo)
        dismiss(animated: true, completion: nil)
    }

    // 알림 스케줄링
    func scheduleNotification(for toDo: ToDo) {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = toDo.title
        content.sound = .default

        guard let dueDate = toDo.dueDate else { return }

        var triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dueDate)

        if toDo.isRecurring {
            triggerDate.weekday = Calendar.current.component(.weekday, from: dueDate)
        }

        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: toDo.isRecurring)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
