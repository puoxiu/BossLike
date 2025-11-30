//
//  View+Label.swift
//  BOSS
//
//  Created by xing on 2025/11/28.
//


import SwiftUI

extension View {
   func padding1() -> some View { padding(.vertical,2).padding(.horizontal,3) }
   func padding3() -> some View { padding(.vertical, 4).padding(.horizontal, 7) }
   
   func accentBorder() -> some View { size12().accent().semib().padding1().border(borderColor: Color.accent) }
   func redBorder() -> some View { size12().red().semib().padding1().border(borderColor: Color.red) }
   
   func labelBG() -> some View {
      size13().tc().semib().padding3().background(Color.labelBG).radius()
   }
   func labelBG2() -> some View {
      size13().tc().medium().padding3().background(Color.labelBG2).radius()
   }
//   func labelPP() -> some View {
//      size13().purple().medium().padding3().background(Color.purple.opacity(0.18)).radius()
//   }
   func labelWA() -> some View {
      size11().white().padding1().background(Color.accent).radius()
   }
   func labelWAL() -> some View {
      size14().white().medium().padding3().background(Color.accent).radius()
   }
}
