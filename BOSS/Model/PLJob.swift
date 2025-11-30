//
//  PLJob.swift
//  BOSS
//
//  Created by xing on 2025/11/29.
//

import Foundation

struct PLJob: Identifiable {
    var id = UUID().uuidString
    var isActive = true
    var title = ""
    var business = "互联网"
    var tax = "面谈"
    var hourlyWage = 100 //时给
    var wantNum = 3
    var contactType = "微信"
    var contact = ""
    //工作时间地点内容
    var startHour = 10
    var startMin = 0
    var endHour = 20
    var endMin = 0
    var has2 = false
    var startHour2 = 10
    var startMin2 = 0
    var endHour2 = 20
    var endMin2 = 0
    var otherTime = ""
    var placeName = ""
    var province = "浙江"
    var city = ""
    var workContent = ""
    //要求
    var needExp = "1-3年"
    var needEdu = "本科"
    var needLan = "Swift"
    var needFrame = "SwiftUI"
    var otherNeed = ""
    //福利
    var moveFee = true
    var noOvertime = true
    var otherBenefit = ""
    //其他
    var companyName = ""
    var userID = ""
    var updatedAt = Date()   // 发布时间默认显示当前时间
    
    static let job = PLJob(title: "iOS程序员", tax: "不报税", contact: "12345", has2: true, startHour2: 14, endHour2: 22, otherTime: "可以根据实际情况调整", placeName: "阿里巴巴西溪园区", province: "浙江", city: "杭州", workContent: "iOS开发实习生秋招生快来快来快来快来快来快来", otherNeed: "负责", otherBenefit: "什么都有啊啊什么都有啊啊什么都有啊啊什么都有啊啊什么都有啊啊",companyName:"阿里巴巴-test")
}
