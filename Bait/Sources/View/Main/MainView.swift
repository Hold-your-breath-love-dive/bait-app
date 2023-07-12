//
//  MainView.swift
//  Bait
//
//  Created by Mercen on 2023/07/12.
//

import SwiftUI
import OpenTDS

struct MainView: View {
    var body: some View {
        NavigationView {
            TossTabView {
                HomeView()
                    .tossTabItem("홈", Image("Home"))
                CommunityView()
                    .tossTabItem("커뮤니티", Image("Community"))
                StartGameView()
                    .tossTabItem("메뉴", Image("Menu"))
            }
        }
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
