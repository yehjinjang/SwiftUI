//
//  ViewController.swift
//  MyCalender
//
//  Created by 장예진 on 4/26/24.
//

import UIKit
import HorizonCalendar

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCalendar ()

    }
    private func createCalendar(){
        let cal  = UICalendarView()
        let calendar = Calendar.current
        let startDate = calendar.date(from: DateComponents(year: 2023, month: 1, day: 1))!
        let endDate = calendar.date(from: DateComponents(year: 2024, month: 12, day: 31))!
                                    
        let content = CalendarViewContent(calendar : calendar,
                                          visibleDateRange : startDate...endDate,
                                          monthsLayout: .vertical(options: VerticalMonthsLayoutOptions())
        )
            .interMonthSpacing(100)
 
        let calendarView = CalendarView(initialContent: content)
        calendarView.daySelectionHandler  = { day in
            let output = "Selected:" + String(describing: day.components)
            print(output)
        }
        view.addSubview(calendarView)
        calendarView.translatesAutoresizingMaskIntoConstraints  = false
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            calendarView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

