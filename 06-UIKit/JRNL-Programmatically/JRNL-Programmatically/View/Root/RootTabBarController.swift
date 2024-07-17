//
//  RootTabBarController.swift
//  JRNL-Programmatically
//
//  Created by jinwoong Kim on 5/9/24.
//

import UIKit

final class RootTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        start()
    }
    
    private func start() {
        let pages: [TabBarPage] = TabBarPage.allCases
        let controllers = pages.map(configureTabController(_:))
        
        prepareTaBbarController(with: controllers)
    }
    
    private func prepareTaBbarController(
        with tabControllers: [UIViewController]
    ) {
        setViewControllers(tabControllers, animated: false)
        selectedIndex = TabBarPage.journal.pageOrderNumber
    }
    
    private func configureTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)
        navController.tabBarItem = UITabBarItem(
            title: page.pageTitle,
            image: UIImage(systemName: page.pageIconString),
            tag: page.pageOrderNumber
        )
        
        switch page {
            case .journal:
                let journalListViewController = JournalListViewController(
                    viewModel: JournalListViewModel()
                )
                navController.pushViewController(journalListViewController, animated: false)
            case .map:
                let mapViewController = MapViewController()
                navController.pushViewController(mapViewController, animated: false)
        }
        
        return navController
    }
}

extension RootTabBarController {
    enum TabBarPage: String, CaseIterable {
        case journal
        case map
        
        var pageTitle: String {
            rawValue.capitalized
        }
        
        var pageOrderNumber: Int {
            switch self {
                case .journal:
                    return 0
                case .map:
                    return 1
            }
        }
        
        var pageIconString: String {
            switch self {
                case .journal:
                    return "person.fill"
                case .map:
                    return "map"
            }
        }
    }
}
