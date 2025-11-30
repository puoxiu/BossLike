//
//  Foundation+.swift
//  BOSS
//
//  Created by xing on 2025/11/29.
//

import Foundation


extension String {
    var isBlank: Bool { self.isEmpty || self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty}
    
    var trimmed: String { self.trimmingCharacters(in: .whitespacesAndNewlines) }
}


extension Date {
   var daysFromNow: Int {//空合运算符
      Calendar.current.dateComponents([.day], from: self, to: .now).day ?? 0
   }
   
   //   let date = Date()
   //   print(date.string(withFormat: "yyyy/MM/dd HH:mm")) // 2023/08/24 16:21
   //   print(date.string(withFormat: "yyyy/MM/dd hh:mm")) // 2023/08/24 04:21
   var toStr: String {
      let year = Calendar.current.component(.year, from: self)
      let currentYear = Calendar.current.component(.year, from: Date()) //2024
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = (year == currentYear) ? "M-d" : "yyyy-M-d"
      return dateFormatter.string(from: self)
   }

}

