//
//  BOSSApp.swift
//  BOSS
//
//  Created by xing on 2025/11/28.
//

import SwiftUI

@main
struct BOSSApp: App {
//    init() {}
    @UIApplicationDelegateAdaptor(AppDelegate.self) var dalegate
    // 注入
    @State var hud = HUD()
    @State var plJobVM = PLJobViewModel()
    @State var tabBarVM = TabBarViewModel()
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
//            PLJobView()
            TabBarView()
                .hud(isPresented: $hud.isPresented) { Text(hud.title) }
                .environment(hud)
                .environment(plJobVM)
                .environment(tabBarVM)
        }
    }
}



@MainActor class AppDelegate: NSObject, UIApplicationDelegate {
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      
      UISegmentedControl.appearance().selectedSegmentTintColor = .accent
      UISegmentedControl.appearance().setTitleTextAttributes([
         .font: UIFont.systemFont(ofSize: 17,weight: .medium),
         .foregroundColor: UIColor(Color.aTC)
      ], for: .normal)
      UISegmentedControl.appearance().setTitleTextAttributes([
         .font: UIFont.systemFont(ofSize: 17,weight: .semibold),
         .foregroundColor: UIColor(Color.white)
      ], for: .selected)//选中后字体
      
      return true
   }
}

