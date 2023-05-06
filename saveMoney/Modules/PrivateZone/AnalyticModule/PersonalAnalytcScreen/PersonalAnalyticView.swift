//
//  PersonalAnalyticView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 20.04.2023.
//

import SwiftUI
import Charts

struct PersonalAnalyticView: View {
    
    @StateObject var viewModel: PersonalAnalyticViewModel
    
    var body: some View {
        VStack {
            IntervalHorizontalView(currentInterval: viewModel.output.interval,
                                   accentColor: ColorsPalette.shared.beige,
                                   onChangeInterval: viewModel.input.onIntervalTap)
            .padding(.horizontal)
            .padding(.top)
            
            Spacer()
            LoadableView(state: viewModel.output.screenState,
                         content: content,
                         onAppearDidLoad: viewModel.input.onAppear,
                         repeatButtonTap: viewModel.input.onAppear)
            Spacer()
        }
        .navigationTitle(Text("Аналитика"))
    }
}

private extension PersonalAnalyticView {
    @ViewBuilder func content() -> some View {
        if viewModel.output.payments.isEmpty {
            Text("Пока нет трат")
        } else {
            successContent
        }
    }
    
    var successContent: some View {
        VStack {
            ScrollView {
                bar
                    .shadowBorder()
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                charts
            }
        }
        .padding(.top, 24)
    }
    
    var bar: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Траты по категориям:")
            Chart(viewModel.output.categories) { item in
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
                Text(maxCategory)
                    .font(.caption)
                Spacer()
            }
            
            HStack {
                Text("Меньше всего трат: ")
                    .font(.caption)
                    .bold()
                Text(minCategory)
                    .font(.caption)
                Spacer()
            }
        }
    }
    
    var charts: some View {
        ForEach(paymentCategories, id: \.self) { category in
            lineChart(viewModel.output.payments.filter {
                $0.categoryName == category
            })
                .shadowBorder()
                .padding(.horizontal)
        }
    }
    
    func lineChart(_ payments: [Payment]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(payments.first!.categoryName):")
            if payments.count < 2 {
                HStack {
                    Text("Мало данных")
                        .font(.caption)
                        .bold()
                    Spacer()
                }
            } else {
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
                .padding(.top, 8)
            }
        }
    }
}

private extension PersonalAnalyticView {
    var maxCategory: String {
        viewModel.output.categories.sorted { fst, snd in
            fst.sum > snd.sum
        }.first?.name ?? ""
    }
    
    var minCategory: String {
        viewModel.output.categories.sorted { fst, snd in
            fst.sum < snd.sum
        }.first?.name ?? ""
    }
    
    var paymentCategories: [String] {
        viewModel.output.payments.map{ $0.categoryName }.unique()
    }
}

//#if DEBUG
//struct PersonalAnalyticView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonalAnalyticView(viewModel: PersonalAnalyticViewModel(apiService: AnalyticApiService(client: HTTPClientAuthImpl(authManager: AuthManager(keychainManager: KeychainManger(serviceName: ), refreshService: Refresher, authorizationState: <#T##CurrentValueSubject<AuthorizationState, Never>#>)))))
//    }
//}
//#endif
