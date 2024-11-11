import SwiftUI

struct TimeRangePicker: View {
    @Binding var selection: Int
    let ranges: [String]
    
    var body: some View {
        Picker("Time Range", selection: $selection) {
            ForEach(Array(ranges.indices), id: \.self) { index in
                Text(ranges[index]).tag(index)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
        .background(Color.oceanTheme.lightBlue.opacity(0.3))
        .cornerRadius(8)
        .padding(.horizontal)
    }
} 