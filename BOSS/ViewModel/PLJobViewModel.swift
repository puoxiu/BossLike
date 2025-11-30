//
//  PLJobViewModel.swift
//  BOSS
//
//  Created by xing on 2025/11/29.
//

import Foundation


@Observable class PLJobViewModel {
    var job = PLJob()
    var draftJob = PLJob()
    var jobs: [PLJob] = [PLJob.job] // todo
    
    func postJob() {
//        job.updatedAt = Date()
        
        // todo 处理空格 异常输入处理
        job = draftJob
        
        // todo 存数据库
    }
    
    func toggleJobStatus() {
        job.isActive.toggle()
    }
    
    func removeJob() {
        // todo 数据库
        
    }
}
