//
//  PLJobView+.swift
//  BOSS
//
//  Created by xing on 2025/11/30.
//

import SwiftUI

extension PLJobView {
    func toggleJobStatus() {
        vm.toggleJobStatus()
        hud.show("\(isActive ? "上线成功" : "下线成功")")
    }
    func removeJob() {
        vm.removeJob()
        hud.show("删除成功")
        if !naviPath.isEmpty { naviPath.removeLast() }
    }
}
