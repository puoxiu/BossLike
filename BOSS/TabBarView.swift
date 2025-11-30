//
//  TabBarView.swift
//  BOSS
//
//  Created by xing on 2025/11/29.
//

import SwiftUI

struct TabBarView: View {
    @Environment(TabBarViewModel.self) var vm
//    @State private var selectedTab = "job"
    
    var body: some View {
        @Bindable var vm = vm
        
        TabView(selection: $vm.selectedTab) {
            // IOS18
            Tab("工作", systemImage: "yensign.circle", value: "job") {
                PLJobsView().toolbarBackground(.visible, for: .tabBar)
            }
            
            Tab("添加", systemImage: "plus.circle", value: "postJob") {
                PostJobView().toolbarBackground(.visible, for: .tabBar)
            }
            
//            Tab("工作", systemImage: "yensign.circle") {
//                PLJobsView().toolbarBackground(.visible, for: .tabBar)
//            }
        }
        
    }
}

//
#Preview {
   TabBarView()
}
