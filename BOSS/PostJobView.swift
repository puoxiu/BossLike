//
//  SwiftUIView.swift
//  BOSS
//
//  Created by xing on 2025/11/30.
//

import SwiftUI

struct PostJobView: View {
   @State var naviPath = NavigationPath()
   var body: some View {
      NavigationStack(path: $naviPath) {
         PostPLJobView(naviPath: $naviPath)
      }
   }
}

#Preview {
   PostJobView()
}
