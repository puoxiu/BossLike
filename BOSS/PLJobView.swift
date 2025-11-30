//
//  PLJobView.swift
//  BOSS
//
//  Created by xing on 2025/11/29.
//

import SwiftUI

struct PLJobView: View {
    @Environment(HUD.self) var hud
    @Environment(PLJobViewModel.self) var vm
    @Binding var naviPath: NavigationPath
    
    var job: PLJob {vm.job}
    var isActive: Bool { vm.job.isActive }
    var offLineTitle: String {isActive ? "" : "[已下线]"}
    
    @State var showActiveDialog = false
    @State var showRemoveDialog = false
    @State var showRemoveAlert = false
    
    var body: some View {
        List {
            // 头部视图
            VStack(alignment: .leading, spacing: kStackSpacing) {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(job.business).labelBG2()
                            Text("新到").labelWA()
                            Text("3人想去").size13s()
                        }
                        Text(job.title + offLineTitle).size18b().tc()
                    }
                    Spacer()
                    
                    Text("\(job.hourlyWage)/h").accent().headline()
                }.padding(.bottom, -4)
                
                // 第二层
                HStack {
                    Text(job.placeName)
                    if job.tax == "不报税" {
                        Text(job.tax).accentBorder()
                    } else if job.tax == "报税" {
                        Text(job.tax).redBorder()
                    }
                    Text("\(job.updatedAt.toStr)发布").secondary()
                }
                
                // 3
                HStack(spacing: kStackSpacing) {
                    HStack(spacing: kIconSpacing) {
                        Image("station").iconStyle()
                        Text("\(job.province)-\(job.city)").semib()
                        Button("导航") {
                            // 可选值 解包
                            if let url = URL(string: "https://maps.google.com?q=\(job.placeName)") {
                                UIApplication.shared.open(url)
                            } else {
                                print("err map")
                            }
                        }.btnStyle()
                    }
                    HStack(spacing: kIconSpacing) {
                        Image("want").iconStyle()
                        Text("招\(job.wantNum)人")
                    }
                    
                    HStack {
                        Button("编辑") {
                            vm.draftJob = job
                            naviPath.append(Navi1.PLJobToEdit)
                        }.buttonStyle(.borderless).accent()
                        
                        Button(isActive ? "下线" : "上线") {
                            showActiveDialog = true
                        }.buttonStyle(.borderless).accent()
                            .confirmationDialog("确定\(isActive ? "下线" : "上线")吗？", isPresented: $showActiveDialog, titleVisibility: .visible) {
                                Button("确定") { toggleJobStatus() }
                                // Button("取消", role: .cancel) { }
                                Button("取消") { }
                            }
                        Button("删除") {
                            showRemoveDialog = true
                        }
                        .buttonStyle(.borderless).accent()
                        .confirmationDialog("确定删除这条工作吗？", isPresented: $showRemoveDialog, titleVisibility: .visible) {
                            Button("删除", role: .destructive) {
                                showRemoveAlert = true
                            }
                            Button("取消") {}
                        }
                        .alert("删除后不可恢复，请谨慎操作", isPresented: $showRemoveAlert) {
                            Button("确定", role: .destructive) { removeJob()}
                            Button("取消", role: .cancel) { }
                        }
                        
                    }
                }
            }
            .textStyle2().cellStyle()
            
            // 公司
            Button {
                
            } label: {
                HStack(spacing: kIconSpacing) {
                    Image("company").iconStyle()
                    Text("\(job.companyName)").size16semib().oneLineStyle()
                    Spacer()
                    Group {
                        Text("更多工作")
                        Image(systemName: "chevron.right")
                    }.secondary()
                }
            }.textStyle().cellStyle()
            
            // 工作详情页
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: kStackSpacingS) {
                    HStack(spacing: kIconSpacing) {
                        Image("time").iconStyle()
                        Text("工作时间").subTStyle()
                        Spacer()
                    }
                    // Text("10:00-06:00").secondary()
                    HStack(spacing: 2) {
                        Text("\(job.startHour)"); Text(":").colonStyle(); Text(job.startMin == 0 ? "00" : "\(job.startMin)")
                        Text("-")
                        Text("\(job.endHour)"); Text(":").colonStyle(); Text(job.endMin == 0 ? "00" : "\(job.endMin)")
                    }
                    if job.has2 {
                        // 如果有两个工作时间段
                        HStack(spacing: 2) {
                            Text("\(job.startHour2)"); Text(":").colonStyle(); Text(job.startMin2 == 0 ? "00" : "\(job.startMin2)")
                            Text("-")
                            Text("\(job.endHour2)"); Text(":").colonStyle(); Text(job.endMin2 == 0 ? "00" : "\(job.endMin2)")
                        }
                    }
                    if !job.otherTime.isEmpty { Text(job.otherTime).allowMulti() }
                }
                exDivider()
                // 工作内容
                if !job.workContent.isBlank {
                    VStack(alignment: .leading, spacing: kStackSpacingS) {
                        HStack(spacing: kIconSpacing) {
                            Image("need").iconStyle()
                            Text("工作内容").subTStyle()
                        }
                        Text(job.workContent).allowMulti()
                        
                    }
                    exDivider()
                }
                // 工作要求
                VStack(alignment: .leading, spacing: kStackSpacingS) {
                    HStack(spacing: kIconSpacing) {
                        Image("need").iconStyle()
                        Text("工作要求").subTStyle()
                    }
                    HStack {
                        Text(job.needExp).labelWAL()
                        Text(job.needEdu).labelWAL()
                        Text(job.needLan).labelWAL()
                        Text(job.needFrame).labelWAL()
                        Text(job.otherNeed).labelWAL()
                    }
                    if !job.otherNeed.isBlank {
                        HStack {
                            Text("本科及以上, 编码能力较强, 有实际项目经验")
                                .allowMulti()
                        }
                    }
                }
                exDivider()
                // 公司福利
                VStack(alignment: .leading, spacing: kStackSpacingS) {
                    HStack(spacing: kIconSpacing) {
                        Image("need").iconStyle()
                        Text("公司福利").subTStyle()
                    }
                    HStack {
                        //                        Text("双休").labelWAL()
                        //                        Text("下午茶").labelWAL()
                        
                        if job.noOvertime { Text("双休").labelWAL()}
                        if job.moveFee { Text("报销交通费").labelWAL() }
                    }
                    if !job.otherBenefit.isBlank {
                        HStack {
                            Text(job.otherBenefit).allowMulti()
                        }
                    }
                }
            }.textStyle2().cellStyle()
            
            
            // 应聘方式
            VStack(alignment: .leading, spacing: kStackSpacingS) {
                Text("应聘方式\(job.contactType)").subTStyleL()
                HStack {
                    Text("\(job.contact)").size20b().tc().allowMulti()
                    Spacer()
                    Button("复制") {
                        UIPasteboard.general.string = "010-32849299"
                        // 弹窗提示
                        hud.show("已复制")
                    }.btnStyle().padding(6)
                }
                Text("可以提交发送简历，并约定时间").size14().gray()
            }.cellStyle()
            
            //
            Color.clear.frame(height: 100).listRowStyle()
        }.listStyle()
            .navigationTitle("长期兼职")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        // todo 判断?
                        // 右滑 unikit
                        naviPath.removeLast()
                    } label: {
                        Image(systemName: "chevron.left").secondary().padding(6)
                    }
                }
            }
    }
}
//
//
#Preview {
    // 传入绑定数据
    PLJobView(naviPath: .constant(NavigationPath()))
        .environment(HUD())
        .environment(PLJobViewModel())
}

