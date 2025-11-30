//
//  PostPLJobView+.swift
//  BOSS
//
//  Created by xing on 2025/11/29.
//

import SwiftUI

extension PostPLJobView {
    func postJob() {
        // 验证数据
        if let invalidMsg = invalidMsg {
            hud.show(invalidMsg)
            return
        }
        workPlaceName = draftJob.placeName
        workProvince = draftJob.province
        workCity = draftJob.city
        workContact = draftJob.contact
        
        vm.draftJob.companyName = "alibaba-提交之后"
        
        vm.postJob()
        
        // 判断是编辑还是新增
        if isEditing {
            hud.show("修改成功")
            
            if !naviPath.isEmpty {
                naviPath.removeLast()
            }
            
        } else {
            hud.show("发布成功")
            
            vm.jobs.append(vm.job)
            
            tabBarvm.selectedTab = "job"
        }
        // 需要置空
        vm.draftJob = PLJob()
    }
}
