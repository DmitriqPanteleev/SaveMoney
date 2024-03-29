//
//  IntervalHorizontalView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 02.04.2023.
//

import SwiftUI
import Combine

struct IntervalHorizontalView: View {
    
    @State var currentInterval: AnalitycInterval
    
    let accentColor: Color
    let onChangeInterval: PassthroughSubject<AnalitycInterval, Never>
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(AnalitycInterval.allCases,
                    id: \.self,
                    content: intervalCell)
        }
        .onChange(of: currentInterval) { newValue in
            onChangeInterval.send(newValue)
        }
    }
}

private extension IntervalHorizontalView {
    func intervalCell(_ model: AnalitycInterval) -> some View {
        VStack {
            switch model {
            case .day:
                Text("День")
                    .font(.footnote)
                    .foregroundColor(currentInterval == model ? .white : .black)
                    .scaleEffect(currentInterval == model ? 1.3 : 1.0)
                    .onTapGesture {
                        currentInterval = .day
                    }
            case .week:
                Text("Неделя")
                    .font(.footnote)
                    .foregroundColor(currentInterval == model ? .white : .black)
                    .scaleEffect(currentInterval == model ? 1.3 : 1.0)
                    .onTapGesture {
                        currentInterval = .week
                    }
            case .month:
                Text("Месяц")
                    .font(.footnote)
                    .foregroundColor(currentInterval == model ? .white : .black)
                    .scaleEffect(currentInterval == model ? 1.3 : 1.0)
                    .onTapGesture {
                        currentInterval = .month
                    }
            case .year:
                Text("Год")
                    .font(.footnote)
                    .foregroundColor(currentInterval == model ? .white : .black)
                    .scaleEffect(currentInterval == model ? 1.3 : 1.0)
                    .onTapGesture {
                        currentInterval = .year
                    }
            }
        }
        .padding(.vertical, currentInterval == model ? 8 : 4)
        .padding(.horizontal, currentInterval == model ? 16 : 8)
        .frame(maxWidth: .infinity)
        .background(currentInterval == model ? accentColor : Color.white)
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.5),
                radius: 4,
                y: 2)
        .animation(.easeInOut(duration: 0.2), value: currentInterval)
    }
}

struct IntervalHorizontalView_Previews: PreviewProvider {
    static var previews: some View {
        IntervalHorizontalView(currentInterval: .day,
                               accentColor: .appGreen, onChangeInterval: PassthroughSubject<AnalitycInterval, Never>())
    }
}
