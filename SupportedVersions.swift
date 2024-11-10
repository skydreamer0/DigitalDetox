import SwiftUI

// 用於處理不同 iOS 版本的 onChange
extension View {
    func onChangeHandler<T: Equatable>(of value: T, perform action: @escaping (T) -> Void) -> some View {
        if #available(iOS 17.0, *) {
            return onChange(of: value) { oldValue, newValue in
                action(newValue)
            }
        } else {
            return onChange(of: value, perform: action)
        }
    }
} 