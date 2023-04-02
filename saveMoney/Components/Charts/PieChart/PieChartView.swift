//
//  PieChartView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 31.03.2023.
//

import SwiftUI

struct PieChartView: View {
    let values: [Double]
    let names: [String]
    let formatter: (Double) -> String
    
    var colors: [Color]
    var backgroundColor: Color
    
    var widthFraction: CGFloat
    var innerRadiusFraction: CGFloat
    
    @State private var activeIndex: Int = -1
    
    var slices: [PieSliceData] {
        let sum = values.reduce(0, +)
        var endDeg: Double = 0
        var tempSlices: [PieSliceData] = []
        
        for (i, value) in values.enumerated() {
            let degrees: Double = value * 360 / sum
            tempSlices.append(PieSliceData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees: endDeg + degrees), color: self.colors[i], text: String(format: "%.0f%%", value * 100 / sum)))
            endDeg += degrees
        }
        return tempSlices
    }
    
    init(values:[Double],
         names: [String],
         formatter: @escaping (Double) -> String,
         colors: [Color],
         backgroundColor: Color = Color(red: 21 / 255, green: 24 / 255, blue: 30 / 255, opacity: 1.0),
         widthFraction: CGFloat = 1,
         innerRadiusFraction: CGFloat = 0.60){
        self.values = values
        self.names = names
        self.formatter = formatter
        
        self.colors = colors
        self.backgroundColor = backgroundColor
        self.widthFraction = widthFraction
        self.innerRadiusFraction = innerRadiusFraction
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack{
                ZStack{
                    ForEach(0..<values.count){ i in
                        PieSliceView(pieSliceData: slices[i])
                            .scaleEffect(activeIndex == i ? 1.03 : 1)
                            .animation(.spring(), value: activeIndex)
                    }
                    .frame(width: widthFraction * geometry.size.width,
                           height: widthFraction * geometry.size.width)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let radius = 0.5 * widthFraction * geometry.size.width
                                let diff = CGPoint(x: value.location.x - radius, y: radius - value.location.y)
                                let dist = pow(pow(diff.x, 2.0) + pow(diff.y, 2.0), 0.5)
                                if (dist > radius || dist < radius * innerRadiusFraction) {
                                    activeIndex = -1
                                    return
                                }
                                var radians = Double(atan2(diff.x, diff.y))
                                if (radians < 0) {
                                    radians = 2 * Double.pi + radians
                                }
                                
                                for (i, slice) in slices.enumerated() {
                                    if (radians < slice.endAngle.radians) {
                                        activeIndex = i
                                        break
                                    }
                                }
                            }
                            .onEnded { value in
                                activeIndex = -1
                            }
                    )
                    Circle()
                        .fill(self.backgroundColor)
                        .frame(width: widthFraction * geometry.size.width * innerRadiusFraction, height: widthFraction * geometry.size.width * innerRadiusFraction)
                    
                    VStack(alignment: .center) {
                        Text(activeIndex == -1 ? "Итого" : names[activeIndex])
                            .font(.system(size: 17,
                                          weight: .regular))
                            .foregroundColor(.black.opacity(0.6))
                            .multilineTextAlignment(.center)
                        Text(formatter(activeIndex == -1 ? values.reduce(0, +) : values[activeIndex]))
                            .font(.system(size: 21,
                                          weight: .semibold))
                            .foregroundColor(.black)
                    }
                    .frame(width: widthFraction * geometry.size.width * innerRadiusFraction * 0.8,
                           height: widthFraction * geometry.size.width * innerRadiusFraction)
                    .animation(.easeInOut(duration: 0.25),
                               value: activeIndex)
                }
            }
            .background(backgroundColor)
            .foregroundColor(Color.white)
        }
    }
}

#if DEBUG
struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            PieChartView(values: [1300, 500, 300],
                         names: ["Еда", "Покушать", "Поесть"],
                         formatter: {value in String(format: "$%.2f", value)}, colors: [Color.blue, Color.green, Color.orange],
                         backgroundColor: .white)
            .padding(.horizontal)
        }
    }
}
#endif
