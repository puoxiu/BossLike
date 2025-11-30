//
//  PLJobCellView.swift
//  BOSS
//
//  Created by xing on 2025/11/28.
//

import SwiftUI

struct PLJobCellView: View {
    let job: PLJob
    var body: some View {
        VStack(spacing: 8) {
            // 第1层--职位信息
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(job.business).labelBG2()
                        Text("新到").labelWA()
                        Text("3人想去").size13s()
                    }
                    HStack {
                        Text(job.title).tc().headline().oneLineStyle()
                        if job.tax == "不报税" {
                            Text(job.tax).accentBorder()
                        } else if job.tax == "报税" {
                            Text(job.tax).redBorder()
                        }
                    }
                }
                Spacer()
                
                Text("\(job.hourlyWage)/h").accent().headline()
            }
            
            // 第2层--职位label
            OverflowGrid(horizontalSpacing: 5) {
                Text(job.needExp).labelBG()
                Text(job.needEdu).labelBG()
                Text(job.needLan).labelBG()
                Text(job.needFrame).labelBG()
                
                if job.noOvertime {
                    Text("965").labelBG()
                }
            }
            .foregroundStyle(.blue)
            //infinity表示沾满父视图
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // 第3层--工作地点描述
            HStack {
                Text(job.placeName).tc().lineLimit(1)
                Spacer()
                Text("\(job.province)-\(job.city)").accent().semib().oneLineStyle()
            }.size14()
        }
        .cellPaddingRadius()
        .cellOutPadding()
    }
}

#Preview {
    PLJobCellView(job: PLJob.job)
}
