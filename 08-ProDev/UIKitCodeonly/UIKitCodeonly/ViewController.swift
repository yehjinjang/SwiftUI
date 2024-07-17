//
//  ViewController.swift
//  UIKitCodeonly
//
//  Created by Jungman Bae on 7/8/24.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.title = "Button"
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "ViewController"
        view.backgroundColor = .white
        
        view.addSubview(button)
        
        button.addAction(UIAction { [weak self] action in
            let hostingController = UIHostingController(rootView: SwiftUIView(name: "Nancy"))
            self?.navigationController?.pushViewController(hostingController, animated: true)
        }, for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }


}

