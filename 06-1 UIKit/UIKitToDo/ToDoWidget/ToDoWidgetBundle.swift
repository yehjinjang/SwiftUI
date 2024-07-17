//
//  ToDoWidgetBundle.swift
//  ToDoWidget
//
//  Created by 장예진 on 5/24/24.
//

import WidgetKit
import SwiftUI

//@main
struct ToDoWidgetBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        ToDoWidget()
//        ToDoWidgetLiveActivity()
    }
}
