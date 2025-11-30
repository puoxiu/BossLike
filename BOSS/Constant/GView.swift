//
//  GView.swift
//  BOSS
//
//  Created by xing on 2025/11/29.
//

import SwiftUI

func exDivider() -> some View { Rectangle().fill(Color.labelBG).frame(height: 1) }//系统的分隔线有时候不显示 ==  Divider()

func listBottomEView() -> some View { Color.clear.frame(height: 120).listRowStyle() }
func postBottomEView() -> some View { Color.clear.frame(height: 120) }
