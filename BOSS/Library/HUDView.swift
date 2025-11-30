import SwiftUI
import Combine
// 悬浮提示框
extension View {
   func hud<Content: View> (isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) -> some View {
      ZStack {
         self
         if isPresented.wrappedValue {
            HUDView(content: content).zIndex(1)
         }
      }.animation(.default, value: isPresented.wrappedValue)
   }
}
struct HUDView<Content: View>: View {
   @ViewBuilder let content: Content
   var body: some View {
      content.font(.subheadline).foregroundStyle(Color.aTCR)
         .padding(.horizontal, 4).padding(12)
         .background(RoundedRectangle(cornerRadius: 8).fill(Color.aBGR))
   }
}


@Observable final class HUD {
   var isPresented = false
   private(set) var title: String = ""
   private var dismissTimer: AnyCancellable? // 用于管理计时器-追加代码-因原版本多次按下后消失不了
   func show(_ title: String) {
      self.title = title
      isPresented = true
      dismissTimer?.cancel()// 取消之前的计时器，确保每次调用时重置-追加代码
      // 3秒后自动隐藏-追加代码
      dismissTimer = Timer.publish(every: 3, on: .main, in: .common)
         .autoconnect()
         .sink { [weak self] _ in
            self?.isPresented = false
            self?.dismissTimer?.cancel() // 确保计时器在执行后被取消
         }
   }
}
