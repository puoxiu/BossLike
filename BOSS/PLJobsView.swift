//
//  PLJobsView.swift
//  BOSS
//
//  Created by xing on 2025/11/28.
//
import SwiftUI

struct PLJobsView: View {
    @Environment(PLJobViewModel.self) var vm
    
    @State var naviPath = NavigationPath()
    
    var body: some View {
        
        // List是默认可以滑动的
        NavigationStack(path: $naviPath) {
            List {
                ForEach(vm.jobs) { job in
                    
                    // bug
                    //                    NavigationLink {
                    //                        // 跳到哪里去-- job详情页
                    //                        PLJobView()
                    //                    } label: {
                    //                        // 点击什么跳-- 某个job卡片
                    //                        PLJobCellView(job: job)
                    //                    }
                    Button {
                        vm.job = job
                        naviPath.append(Navi1.PLJobsToPLJob)
                    } label: {
                        PLJobCellView(job: job)
                    }
                    .buttonStyle(.borderless)
                }.listRowStyle()
            }
            .listStyle()
            .navigationDestination(for: Navi1.self) { navi in
                switch navi {
                case .PLJobsToPLJob:
                    PLJobView(naviPath: $naviPath)
                case .PLJobToEdit:
                    PostPLJobView(isEditing: true, naviPath: $naviPath)
                }
            }
        }
    }
}

#Preview {
    PLJobsView()
        .environment(PLJobViewModel())
}
