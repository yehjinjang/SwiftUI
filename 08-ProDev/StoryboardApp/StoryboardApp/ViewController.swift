//
//  ViewController.swift
//  StoryboardApp
//
//  Created by Jungman Bae on 7/8/24.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBSegueAction func openSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: SwiftUIView(name: "Nancy"))
    }
    
}
