//
//  PersonalAnalyticView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 20.04.2023.
//

import SwiftUI
import Charts

struct PersonalAnalyticView: View {
    let categories: [AnalizeCategory]
    let payments: [Payment]
    let food: [Payment]
    let auto: [Payment]
    let network: [Payment]
    
    @State var currentInterval: AnalitycInterval = .month
    
    var body: some View {
        content()
            .navigationTitle(Text("Аналитика"))
    }
}

private extension PersonalAnalyticView {
    func content() -> some View {
        VStack {
            ScrollView {
                IntervalHorizontalView(currentInterval: currentInterval,
                                       accentColor: ColorsPalette.shared.beige)
                .padding(.horizontal)
                bar
                    .shadowBorder()
                    .padding(.horizontal)
                    .padding(.top, 24)
                    .padding(.bottom, 24)
                lineChart
                    .shadowBorder()
                    .padding(.horizontal)
                foodview
                    .shadowBorder()
                    .padding(.horizontal)
                autoview
                    .shadowBorder()
                    .padding(.horizontal)
                networkview
            }
        }
        .padding(.top, 24)
    }
    
    var bar: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Траты по категориям:")
            Chart(categories, id: \.id) { item in
                BarMark(
                    x: .value("Категория", item.name),
                    y: .value("Сумма", item.sum)
                )
                .foregroundStyle(item.color)
            }
            .frame(height: 200)
            .frame(maxWidth: .infinity)
            additinalInfo
        }
    }
    
    var additinalInfo: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("Больше всего трат: ")
                    .font(.caption)
                    .bold()
                Text("Жилье")
                    .font(.caption)
                Spacer()
            }
            
            HStack {
                Text("Меньше всего трат: ")
                    .font(.caption)
                    .bold()
                Text(categories.first(where: { c in
                    c.name == "Связь и интернет"
                })!.name)
                    .font(.caption)
                Spacer()
            }
        }
    }
    
    var lineChart: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Траты на Жилье:")
            Chart {
                ForEach(payments, id: \.id) { item in
                        LineMark(
                            x: .value("Date", item.date),
                            y: .value("Profit B", item.sum),
                            series: .value("Company", "B")
                        )
                        .foregroundStyle(item.categoryColor)
                    }
            }
        }
    }
    
    var foodview: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Траты на Еда:")
            Chart {
                ForEach(food, id: \.id) { item in
                        LineMark(
                            x: .value("Date", item.date),
                            y: .value("Profit B", item.sum),
                            series: .value("Company", "B")
                        )
                        .foregroundStyle(item.categoryColor)
                    }
            }
        }
    }
    
    var autoview: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Траты на Автомобиль:")
            Chart {
                ForEach(auto, id: \.id) { item in
                        LineMark(
                            x: .value("Date", item.date),
                            y: .value("Profit B", item.sum),
                            series: .value("Company", "B")
                        )
                        .foregroundStyle(item.categoryColor)
                    }
            }
        }
    }
    
    var networkview: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Траты на Связь и интернет:")
            Chart {
                ForEach(network, id: \.id) { item in
                        LineMark(
                            x: .value("Date", item.date),
                            y: .value("Profit B", item.sum),
                            series: .value("Company", "B")
                        )
                        .foregroundStyle(item.categoryColor)
                    }
            }
        }
        
    }
}

#if DEBUG
struct PersonalAnalyticView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalAnalyticView(categories: [.mock(), .mock2(), .mock3(), .mock4()], payments: [.emptyWithSum(2000, .init(timeIntervalSince1970: 1680395737)),.emptyWithSum(1000, .init(timeIntervalSince1970: 1680568537)),.emptyWithSum(3000, .init(timeIntervalSince1970: 1680827737)),.emptyWithSum(3400, .init(timeIntervalSince1970: 1681173337)),.emptyWithSum(2130, .init(timeIntervalSince1970: 1681432537)),.emptyWithSum(10000, .init(timeIntervalSince1970: 1681778137))], food: [.emptyWithSum(300, .init(timeIntervalSince1970: 1680395737)),.emptyWithSum(200, .init(timeIntervalSince1970: 1680568537)),.emptyWithSum(400, .init(timeIntervalSince1970: 1680827737)),.emptyWithSum(700, .init(timeIntervalSince1970: 1681173337)),.emptyWithSum(250, .init(timeIntervalSince1970: 1681432537)),.emptyWithSum(870, .init(timeIntervalSince1970: 1681778137))], auto: [.emptyWithSum(500, .init(timeIntervalSince1970: 1680395737)),.emptyWithSum(1000, .init(timeIntervalSince1970: 1680568537)),.emptyWithSum(300, .init(timeIntervalSince1970: 1680827737)),.emptyWithSum(500, .init(timeIntervalSince1970: 1681173337)),.emptyWithSum(500, .init(timeIntervalSince1970: 1681432537)),.emptyWithSum(500, .init(timeIntervalSince1970: 1681778137))], network: [.emptyWithSum(2000, .init(timeIntervalSince1970: 1680395737)),.emptyWithSum(1000, .init(timeIntervalSince1970: 1680568537))])
    }
}
#endif
