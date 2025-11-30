//
//  PostPLJobView.swift
//  BOSS
//
//  Created by xing on 2025/11/29.
//

import SwiftUI

struct PostPLJobView: View {
    var isEditing = false //默认是新增工作
    // 从存储
    @AppStorage("workPlaceName") var workPlaceName = ""
    @AppStorage("workProvince") var workProvince = ""
    @AppStorage("workCity") var workCity = ""
    @AppStorage("workContact") var workContact = ""
    
    // 从
    @Environment(PLJobViewModel.self) var vm
    @Environment(HUD.self) var hud
    @Environment(TabBarViewModel.self) var tabBarvm
    
    @Binding var naviPath: NavigationPath
    
    //   @Environment(TabBarViewModel.self) var tabbarVM
    //   @Binding var naviPath: NavigationPath
           var draftJob: PLJob { vm.draftJob }
    var invalidMsg: String? {
        if draftJob.title.isBlank { return "工作名称不能为空" }
        if draftJob.title.count > 50 { return "工作名称不能超过50字" }
        if draftJob.hourlyWage < 20 || vm.draftJob.hourlyWage > 100000 { return "基本时薪太低或太高" }
        if draftJob.placeName.isBlank { return "工作地点不能为空" }
        if draftJob.city.isBlank  { return "工作地城市不能为空" }
        if draftJob.contact.isBlank  { return "应聘方式不能为空" }
        if draftJob.otherTime.count > 100 { return "时间说明不能超100字" }
        if draftJob.otherNeed.count > 300 { return "工作要求不能超300字" }
        if draftJob.workContent.count > 500 { return "工作内容不能超500字" }
        if draftJob.otherBenefit.count > 300 { return "工作福利不能超300字" }
        if draftJob.placeName.count > 50 { return "工作地点不能超50字" }
        if draftJob.city.count > 20 { return "工作地城市不能超20字" }
        if draftJob.contact.count > 300 { return "应聘方式不能超200字" }
        return nil
    }
    
    var body: some View {
        @Bindable var vm = vm
        
        ScrollView(showsIndicators: false) {
            VStack(spacing: kStackSpacingS) {
                // MARK: - 基本信息
                VStack(alignment: .leading, spacing: kStackSpacing) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("工作业种").littleTStyle()
                            Picker("工作业种", selection: $vm.draftJob.business) {
                                ForEach(kBusinessArr, id: \.self) { Text($0) }
                            }.pStyle()
                        }
                        VStack(alignment: .leading) {
                            Text("工作名称").littleTStyle()
                            TextField("iOS程序员", text: $vm.draftJob.title).tfStyle()
                        }
                    }
                    VStack(alignment: .leading) {
                        Text("是否报税").littleTStyle()
                        Picker("是否报税", selection: $vm.draftJob.tax) {
                            ForEach(kTaxArr, id: \.self) { Text($0) }
                        }.pickerStyle(.segmented)
                    }.padding(.bottom,5)
                    HStack {
                        Text("基本时给：").littleTStyle()
                        TextField("", value: $vm.draftJob.hourlyWage, formatter: NumberFormatter())
                            .size18ab().multilineTextAlignment(.center).kerning(2)
                            .keyboardType(.numberPad).tfStyle().frame(width: 88)
                        Text("请填写最低时给").size13s()
                    }
                    HStack {
                        Text("招聘人数：").littleTStyle()
                        
                        Picker("招聘人数", selection: $vm.draftJob.wantNum) {
                            ForEach(kWantNumArr, id: \.self) { Text("\($0)人") }//字符串插值
                        }.pStyle()
                        Text("请填写最多招聘人数").size13s()
                    }
                    
                }.padding().bg()
                // MARK: - 工作时间
                VStack(alignment: .leading, spacing: kStackSpacingS) {
                    Text("工作时间").littleTStyle()
                    HStack {
                        HStack(spacing: 3) {
                            Picker("起始小时", selection: $vm.draftJob.startHour) {ForEach(0..<25) { Text("\($0)") }}.pStyle()
                            Text(":").colonStyle()
                            Picker("起始分钟", selection: $vm.draftJob.startMin) {
                               ForEach([0,30], id: \.self) { Text($0 == 0 ? "00" : "\($0)") }
                            }.pStyle()
                            Image(systemName: "minus")
                            Picker("结束小时", selection: $vm.draftJob.endHour) {ForEach(0..<25) { Text("\($0)") }}.pStyle()
                            Text(":").colonStyle()
                            Picker("结束分钟", selection: $vm.draftJob.endMin) {
                               ForEach([0,30], id: \.self) { Text($0 == 0 ? "00" : "\($0)") }
                            }.pStyle()
                        }
                        Button {
                            // 带有动画
                            withAnimation { vm.draftJob.has2.toggle() }
                        } label: {
                            Image(systemName: vm.draftJob.has2 ? "minus.circle.fill" : "plus.circle.fill")
                                .foregroundStyle(vm.draftJob.has2 ? .red : .accent)
                        }.font(.title2).padding(.horizontal,3)
                    }
                    
                    if vm.draftJob.has2 {
                        HStack(spacing: 3) {
                            Picker("起始小时2", selection: $vm.draftJob.startHour2) {ForEach(0..<25) { Text("\($0)") }}.pStyle()
                            Text(":").colonStyle()
                            Picker("起始分钟2", selection: $vm.draftJob.startMin2) {
                                ForEach([0,30], id: \.self) { Text($0 == 0 ? "00" : "\($0)") }
                            }.pStyle()
                            Image(systemName: "minus")
                            Picker("结束小时2", selection: $vm.draftJob.endHour2) {ForEach(0..<25) { Text("\($0)") }}.pStyle()
                            Text(":").colonStyle()
                            Picker("结束分钟2", selection: $vm.draftJob.endMin2) {
                                ForEach([0,30], id: \.self) { Text($0 == 0 ? "00" : "\($0)") }
                            }.pStyle()
                        }
                    }
                    
                    Text("追加说明").littleTStyle()
                    TextField("具体时间段可相谈", text: $vm.draftJob.otherTime, axis: .vertical)
                        .tfStyleMultiS()
                    
                }.push(to: .leading).padding().bg()
                
                // MARK: - 工作要求
                VStack(alignment: .leading, spacing: kStackSpacing) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("经验").littleTStyle()
                            Picker("经验", selection: $vm.draftJob.needExp) {ForEach(kExpArr, id: \.self) { Text($0) }}.pStyle()
                        }
                        VStack(alignment: .leading) {
                            Text("学历").littleTStyle()
                            Picker("学历", selection: $vm.draftJob.needEdu) {ForEach(kEduArr, id: \.self) { Text($0) }}.pStyle()
                        }
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text("语言").littleTStyle()
                            Picker("语言", selection: $vm.draftJob.needLan) {ForEach(kLanArr, id: \.self) { Text($0) }}.pStyle()
                        }
                        VStack(alignment: .leading) {
                            Text("框架").littleTStyle()
                            Picker("框架", selection: $vm.draftJob.needFrame) {ForEach(kFrameArr, id: \.self) { Text($0) }}.pStyle()
                        }
                    }
                    VStack(alignment: .leading) {
                        Text("更多要求/加分项（选填）").littleTStyle()
                        TextField("", text: $vm.draftJob.otherNeed, axis: .vertical).tfStyleMultiM()
                    }
                }.padding().bg()
                // MARK: - 工作内容
                VStack(alignment: .leading) {
                    Text("工作内容（选填）").littleTStyle()
                    TextField("", text: $vm.draftJob.workContent, axis: .vertical).tfStyleMultiM()
                }.padding().bg()
                // MARK: - 公司福利
                VStack(alignment: .leading, spacing: kStackSpacing) {
                    Text("公司福利").littleTStyle()
                    HStack {
                        Text("交通费报销").onTapGesture {vm.draftJob.moveFee.toggle()}.toggleStyle(isTap: vm.draftJob.moveFee)
                        Text("不加班").onTapGesture {vm.draftJob.noOvertime.toggle()}.toggleStyle(isTap: vm.draftJob.noOvertime)
                    }
                    VStack(alignment: .leading) {
                        Text("更多福利（选填）").littleTStyle()
                        TextField("", text: $vm.draftJob.otherBenefit, axis: .vertical).tfStyleMultiM()
                    }
                }.padding().bg()
                // MARK: - 工作地点
                VStack(alignment: .leading, spacing: kStackSpacing) {
                    VStack(alignment: .leading) {
                        Text("工作地名称").littleTStyle()
                        TextField("", text: $vm.draftJob.placeName).tfStyle()
                        if !workPlaceName.isEmpty {
                            HStack(spacing: 3) {
                                Text("上次填的：").size13s()
                                Button { vm.draftJob.placeName = workPlaceName } label: {
                                    Text(workPlaceName).labelBG()
                                }
                            }
                        }
                    }
                    HStack {
                        Text("省份：").littleTStyle()
                        Picker("省份", selection: $vm.draftJob.province) {
                            ForEach(kProvinceArr, id: \.self) { Text($0) }
                        }.pStyle()
                        if !workProvince.isEmpty {
                            HStack(spacing: 3) {
                                Text("上次填的：").size13s()
                                Button { vm.draftJob.province = workProvince } label: {
                                    Text(workProvince).labelBG()
                                }
                            }
                        }
                    }
                    HStack {
                        Text("城市：").littleTStyle()
                        TextField("", text: $vm.draftJob.city).tfStyle().frame(width: 115)
                        if !workCity.isEmpty {
                            HStack(spacing: 3) {
                                Text("上次填的：").size13s()
                                Button { vm.draftJob.city = workCity } label: {
                                    Text(workCity).labelBG()
                                }
                            }
                        }
                    }
                }.padding().bg()
                // MARK: - 联系方式
                VStack(alignment: .leading, spacing: kStackSpacingS) {
                    Text("联系方式/应聘方式").littleTStyle()
                    HStack {
                        Picker("联系方式种类", selection: $vm.draftJob.contactType) {
                            ForEach(kContactTypeArr, id: \.self) { Text($0) }
                        }.pStyle()
                        TextField("12345", text: $vm.draftJob.contact).tfStyle()
                    }
                    if !workContact.isEmpty {
                        HStack(spacing: 3) {
                            Text("上次填的：").size13s()
                            Button { vm.draftJob.contact = workContact } label: {
                                Text(workContact).labelBG()
                            }
                        }
                    }
                    Text("据调查，99%的人材都喜欢用微信联系").size13().red()
                }.padding().bg()
                
                // MARK: - 提交按钮
                Button {
                    postJob()
                } label: {
                    Text("提交").appleStyle()
                }.padding().bg()
                
            }.tc().bg2()
            postBottomEView().bg()
        }
    }
    
}
//
#Preview {
    PostPLJobView(naviPath: .constant(NavigationPath()))
        .environment(PLJobViewModel()) // 注入PLJobViewModel
        .environment(HUD()) // 注入HUD
}
