//
//  View+Style.swift
//  BOSS
//
//  Created by xing on 2025/11/28.
//

import SwiftUI

extension View {
    func btnStyle() -> some View { size15().buttonStyle(.borderless).accent() }
    
    func textStyle() -> some View { size15().tc().lineSpacing(6) }
    func textStyle2() -> some View { size15().tc2().lineSpacing(6) }
    
    func oneLineStyle() -> some View { lineLimit(1).truncationMode(.middle) }
    
    //List里面的东西
    func subTStyle() -> some View { tc().size16semib() }
    func subTStyleL() -> some View { tc().headline() }
    
    //cell
    func cellPaddingRadius() -> some View { padding(.vertical).padding(.horizontal,12).bg().radius(8) }//带radius
    func cellOutPadding() -> some View { padding([.top, .horizontal], 9) }
    
    //list
    func listRowStyle() -> some View {
        listRowInsets(EdgeInsets()).listRowSeparator(.hidden).listRowBackground(Color.clear)
    }
    func listStyle() -> some View {
        listStyle(.inset).scrollContentBackground(.hidden).bg2().environment(\.defaultMinListRowHeight, 0)
    }
    
    //总的
    func cellStyle() -> some View { cellPaddingRadius().cellOutPadding().listRowStyle() }
    
    //Form里面
    func littleTStyle() -> some View { size13().tc2().fontWeight(.light) }
    func pStyle() -> some View { frame(height: kTFAndPHeight).border(borderColor: Color(.systemGray4)) }
    func tfStyle() -> some View {
        // 并且修改键盘
        frame(height: kTFAndPHeight).padding(.horizontal, 9).border(borderColor: Color(.systemGray4)).submitLabel(.done)
    }
    
    // todo 函数封装
    func tfStyleMultiS() -> some View {
        frame(minHeight: kTFAndPHeight).padding(.horizontal, 9).border(borderColor: Color(.systemGray4))
            .lineLimit(1...4).lineSpacing(4).fixedSize(horizontal: false, vertical: true)
    }
    func tfStyleMultiM() -> some View {
        frame(minHeight: kTFAndPHeight).padding(.horizontal, 9).border(borderColor: Color(.systemGray4))
            .lineLimit(3...8).lineSpacing(4).fixedSize(horizontal: false, vertical: true)
    }
    func tfStyleMultiL() -> some View {
        frame(minHeight: kTFAndPHeight).padding(.horizontal, 9).border(borderColor: Color(.systemGray4))
            .lineLimit(4...10).lineSpacing(4).fixedSize(horizontal: false, vertical: true)
    }
       func colonStyle() -> some View { bold().padding(.horizontal,2).offset(y: -1) }
       func toggleStyle(isTap: Bool) -> some View {
          size15().foregroundStyle(isTap ? .white : .aTC)
          .frame(height: kTFAndPHeight).padding(.horizontal, 10)
          .background(isTap ? Color.accent.gradient : Color.bg.gradient).radius()
          .border(borderColor: isTap ? .clear : .accent)
       }
    func appleStyle() -> some View {
        headline().white().frame(height: 55).frame(maxWidth: .infinity).background(.accent.gradient).radius(10)
    }
}

extension Image {
    func iconStyle() -> some View { resizable().frame(width: 16, height: 16) }
}
