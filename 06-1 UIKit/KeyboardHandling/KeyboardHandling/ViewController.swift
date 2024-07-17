//
//  ViewController.swift
//  KeyboardHandling
//
//  Created by 장예진 on 5/23/24.
//

import UIKit

class ViewController: UIViewController {
    
    let textField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "insert here"
        textField.translatesAutoresizingMaskIntoConstraints  = false
        
        view.addSubview(textField)
        
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)  
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //키보드를 내리는 뷰 설정
    @objc func tapHandler(_ sender: UIView){
        // cursor 를 날려서 키보드가없어지게 하는 것임 
        textField.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        print("keyboard up")
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?
                               NSValue)?.cgRectValue{
            let keyboardHeight = keyboardSize.height
            if view.frame.origin.y == 0 {
                //위 쪽으로 뷰를 프레임만큼
                view.frame.origin.y -= keyboardHeight
            }
        }
    }
    
    @objc func keyboardWillHide(_ notificatioin: NSNotification) {
        print("keyboard down")
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }


}

