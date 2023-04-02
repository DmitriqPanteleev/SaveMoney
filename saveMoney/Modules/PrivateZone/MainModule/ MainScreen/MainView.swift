//
//  MainView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 27.03.2023.
//

import SwiftUI
import Combine

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        content()
    }
}

private extension MainView {
    @ViewBuilder func content() -> some View {
        VStack(spacing: 24) {
            headerView
            pieChartView
            categoryListView
        }
        .padding(.top, 16)
    }
    
    var headerView: some View {
        ZStack(alignment: .center) {
            tabSectionView
            trailingItems
        }
    }
    
    var trailingItems: some View {
        VStack {
            settingsButtonView
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.horizontal)
    }
    
    var settingsButtonView: some View {
        Button(actionPublisher: viewModel.input.onSettingsTap) {
            Image(systemName: "gearshape")
                .resizable()
                .scaledToFit()
                .frame(width: 20,
                       height: 20)
        }
        .tint(mostValuableColor)
    }
    
    var tabSectionView: some View {
        TabSectionView(currentSection: viewModel.output.tabSection)
    }
    
    var pieChartView: some View {
        ZStack(alignment: .top) {
            PieChartView(values: categoriesToSums(),
                         names: categoriesToNames(),
                         formatter: formatterForChart,
                         colors: categoriesToColors(),
                         backgroundColor: .white)
            .padding(.horizontal, 32)
            
            HStack {
                Spacer()
                analyticsButton
            }
        }
        .padding(.horizontal, 16)
    }
    
    var categoryListView: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 4){
                Text("РАСХОДЫ")
                    .foregroundColor(.gray)
                Spacer()
                addPaymentButtonView
            }
            .padding(.horizontal)
            
            PaymentListView(models: viewModel.output.payments,
                            onTapPublisher: viewModel.input.onPaymentTap)
            .padding(.horizontal, 8)
        }
    }
    
    var addPaymentButtonView: some View {
        Button(actionPublisher: viewModel.input.onAddPaymentTap) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 20,
                       height: 20)
        }
        .tint(mostValuableColor)
    }
    
    var analyticsButton: some View {
        Button(actionPublisher: viewModel.input.onAnalyticsTap) {
            Image(systemName: "waveform.and.magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .padding(.leading, 10)
                .padding([.vertical, .trailing], 8)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .gray.opacity(0.5),
                        radius: 4,
                        y: 2)
        }
        .tint(.gray)
    }
}

private extension MainView {
    
}

private extension MainView {
    var mostValuableColor: Color {
        let biggestValue = viewModel.output.categories.sorted { lhs, rhs in
            lhs.sum > rhs.sum
        }.first
        return biggestValue?.color ?? .gray
    }
    
    func categoriesToSums() -> [Double] {
        viewModel.output.categories.map { Double($0.sum) }
    }
    
    func categoriesToNames() -> [String] {
        viewModel.output.categories.map { $0.name }
    }
    
    func categoriesToColors() -> [Color] {
        viewModel.output.categories.map { $0.color }
    }
    
    func formatterForChart(_ value: Double) -> String {
        String(format: "%.2f ₽", value)
    }
    
    func randomColorsForChart() -> [Color] {
        ColorsGenerator.randomColors(for: viewModel.output.categories.count)
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}
#endif
