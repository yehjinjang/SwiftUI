//
//  AddJournalViewController.swift
//  JRNL-Codeonly
//
//  Created by Jungman Bae on 5/13/24.
//

import UIKit
import CoreLocation
//
//protocol AddJournalControllerDelegate: NSObject {
//    func saveJournalEntry(_ journalEntry: JournalEntry)
//}
//
//class AddJournalViewController: UIViewController {
//    weak var delegate: AddJournalControllerDelegate?
////    의존 분리를 위해 직접 뷰 컨트롤러를 담기보다, 델리게이트 프로토콜을 이용한다.
////    weak var journalListViewController: JournalListViewController?
//    
//    private lazy var mainContainer: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.alignment = .center
//        stackView.distribution = .fill
//        stackView.spacing = 40
//        return stackView
//    }()
//    
//    private lazy var ratingView: UIStackView = {
//        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 252, height: 44))
//        stackView.axis = .horizontal
//        stackView.backgroundColor = .systemCyan
//        return stackView
//    }()
//    
//    private lazy var toggleView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.alignment = .fill
//        stackView.distribution = .fill
//        stackView.spacing = 8
//        let switchComponent = UISwitch()
//        let labelComponent = UILabel()
//        labelComponent.text = "Switch Label"
//        stackView.addArrangedSubview(switchComponent)
//        stackView.addArrangedSubview(labelComponent)
//        
//        return stackView
//    }()
//    
//    private lazy var titleTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Journal Title"
//        return textField
//    }()
//    
//    private lazy var bodyTextView: UITextView = {
//        let textView = UITextView()
//        textView.text = "Journal Body"
//        return textView
//    }()
//    
//    private lazy var imageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(systemName: "face.smiling")
//        return imageView
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        navigationItem.title = "New Entry"
//        view.backgroundColor = .white
//        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
//                                                            target: self,
//                                                            action: #selector(save))
//        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
//                                                           target: self,
//                                                           action: #selector(cancel))
//        
//        mainContainer.addArrangedSubview(ratingView)
//        mainContainer.addArrangedSubview(toggleView)
//        mainContainer.addArrangedSubview(titleTextField)
//        mainContainer.addArrangedSubview(bodyTextView)
//        mainContainer.addArrangedSubview(imageView)
//        
//        view.addSubview(mainContainer)
//        
//        let safeArea = view.safeAreaLayoutGuide
//        
//        mainContainer.translatesAutoresizingMaskIntoConstraints = false
//        ratingView.translatesAutoresizingMaskIntoConstraints = false
//        toggleView.translatesAutoresizingMaskIntoConstraints = false
//        titleTextField.translatesAutoresizingMaskIntoConstraints = false
//        bodyTextView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            mainContainer.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
//            mainContainer.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
//            mainContainer.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
//            
//            ratingView.widthAnchor.constraint(equalToConstant: 252),
//            ratingView.heightAnchor.constraint(equalToConstant: 44),
//            
//            titleTextField.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 8),
//            titleTextField.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -8),
//            
//            bodyTextView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 8),
//            bodyTextView.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -8),
//            bodyTextView.heightAnchor.constraint(equalToConstant: 128),
//            
//            imageView.widthAnchor.constraint(equalToConstant: 200),
//            imageView.heightAnchor.constraint(equalToConstant: 200)
//
//        ])
//        
//    }
//    
//    @objc func save() {
//        guard let title = titleTextField.text, !title.isEmpty,
//              let body = bodyTextView.text, !body.isEmpty else {
//            return
//        }
//        let journalEntry = JournalEntry(rating: 3, title: title, body: body,
//                                        photo: UIImage(systemName: "face.smiling"))!
//        delegate?.saveJournalEntry(journalEntry)
//        dismiss(animated: true)
//    }
//    
//    @objc func cancel() {
//        dismiss(animated: true)
//    }
//    
//    
//    /*
//     // MARK: - Navigation
//     
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     // Get the new view controller using segue.destination.
//     // Pass the selected object to the new view controller.
//     }
//     */
//    
//}

protocol AddJournalControllerDelegate: AnyObject {
    func saveJournalEntry(_ journalEntry: JournalEntry)
}

class AddJournalViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, CLLocationManagerDelegate {
    weak var delegate: AddJournalControllerDelegate?
    
    private var locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    
    private lazy var mainContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 40
        return stackView
    }()
    
    private lazy var ratingView: UIStackView = {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 252, height: 44))
        stackView.axis = .horizontal
        stackView.backgroundColor = .systemCyan
        return stackView
    }()
    
    private lazy var toggleView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        let switchComponent = UISwitch()
        switchComponent.addTarget(self, action: #selector(locationSwitchToggled(_:)), for: .valueChanged)
        let labelComponent = UILabel()
        labelComponent.text = "Include Location"
        stackView.addArrangedSubview(switchComponent)
        stackView.addArrangedSubview(labelComponent)
        
        return stackView
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Journal Title"
        textField.borderStyle = .roundedRect
        textField.delegate = self
        return textField
    }()
    
    private lazy var bodyTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Journal Body"
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 5
        textView.delegate = self
        return textView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "face.smiling")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "New Entry"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(save))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(cancel))
        
        mainContainer.addArrangedSubview(ratingView)
        mainContainer.addArrangedSubview(toggleView)
        mainContainer.addArrangedSubview(titleTextField)
        mainContainer.addArrangedSubview(bodyTextView)
        mainContainer.addArrangedSubview(imageView)
        
        view.addSubview(mainContainer)
        
        let safeArea = view.safeAreaLayoutGuide
        
        mainContainer.translatesAutoresizingMaskIntoConstraints = false
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        toggleView.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        bodyTextView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            mainContainer.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            mainContainer.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            ratingView.widthAnchor.constraint(equalToConstant: 252),
            ratingView.heightAnchor.constraint(equalToConstant: 44),
            
            titleTextField.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 8),
            titleTextField.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -8),
            
            bodyTextView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 8),
            bodyTextView.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -8),
            bodyTextView.heightAnchor.constraint(equalToConstant: 128),
            
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    @objc func locationSwitchToggled(_ sender: UISwitch) {
        if sender.isOn {
            locationManager.requestLocation()
        } else {
            currentLocation = nil
        }
    }
    
    @objc func save() {
        guard let title = titleTextField.text, !title.isEmpty,
              let body = bodyTextView.text, !body.isEmpty else {
            return
        }
        
        let latitude = currentLocation?.coordinate.latitude
        let longitude = currentLocation?.coordinate.longitude
        
        if let journalEntry = JournalEntry(rating: 3, title: title, body: body, photo: UIImage(systemName: "face.smiling"), latitude: latitude, longitude: longitude) {
            delegate?.saveJournalEntry(journalEntry)
            dismiss(animated: true)
        } else {
            // JournalEntry 생성 실패 처리 (예: 사용자에게 알림 표시)
            let alert = UIAlertController(title: "Error", message: "Failed to save journal entry.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    @objc func cancel() {
        dismiss(animated: true)
    }
    
    // UITextFieldDelegate and UITextViewDelegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        navigationItem.rightBarButtonItem?.isEnabled = false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        navigationItem.rightBarButtonItem?.isEnabled = false
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        updateSaveButtonState()
    }

    private func updateSaveButtonState() {
        let title = titleTextField.text ?? ""
        let body = bodyTextView.text ?? ""
        navigationItem.rightBarButtonItem?.isEnabled = !title.isEmpty && !body.isEmpty && (currentLocation != nil)
    }
    
    // CLLocationManagerDelegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            updateSaveButtonState()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}
