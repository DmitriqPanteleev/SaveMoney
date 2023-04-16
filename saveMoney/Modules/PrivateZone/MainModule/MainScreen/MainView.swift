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
        LoadableView(state: .content,
                     content: content)
    }
}

private extension MainView {
    @ViewBuilder func content() -> some View {
        VStack(spacing: 24) {
            headerView
                .padding(.bottom, 12)
            intervalsView
            pieChartView
            categoriesList
            paymentListView
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
        .tint(ColorsPalette.shared.beige)
    }
    
    var tabSectionView: some View {
        TabSectionView(currentSection: viewModel.output.tabSection)
    }
    
    var intervalsView: some View {
        IntervalHorizontalView(currentInterval: viewModel.output.interval,
                               accentColor: ColorsPalette.shared.beige)
        .padding(.horizontal)
    }
    
    var pieChartView: some View {
        ZStack(alignment: .bottomTrailing) {
            HStack(spacing: 16) {
                chevronLeft
                PieChartView(values: categoriesToSums(),
                             names: categoriesToNames(),
                             formatter: formatterForChart,
                             colors: categoriesToColors(),
                             backgroundColor: .white)
                .padding(.horizontal)
                chevronRight
            }
            analyticsButton
        }
        .padding(.horizontal, 16)
    }
    
    var categoriesList: some View {
        CategoryHorizontalListView(models: viewModel.output.categories,
                                   onDetailAnalizeTap: viewModel.input.onAnalyticsTap)
        .padding(.horizontal)
        .padding(.top, 24)
    }
    
    var paymentListView: some View {
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
                .frame(width: 24,
                       height: 24)
        }
        .tint(ColorsPalette.shared.beige)
    }
    
    var analyticsButton: some View {
        Button(actionPublisher: viewModel.input.onAnalyticsTap) {
            Image(systemName: "waveform.and.magnifyingglass")
                .resizable()
                .scaledToFit()
                .foregroundColor(ColorsPalette.shared.lightOrange)
                .frame(width: 24, height: 24)
                .padding(.leading, 10)
                .padding([.vertical, .trailing], 8)
                .background(Color.white)
                .cornerRadius(24)
                .shadow(color: .gray.opacity(0.5),
                        radius: 4,
                        y: 2)
        }
        .tint(.gray)
    }
    
    var chevronLeft: some View {
        Button(actionPublisher: viewModel.input.onChangeStep,
        sendableModel: false) {
            Image(systemName: "chevron.left")
                .resizable()
                .frame(width: 10, height: 40)
                .foregroundColor(.gray)
        }
    }
    
    var chevronRight: some View {
        Button(actionPublisher: viewModel.input.onChangeStep,
        sendableModel: true) {
            Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 10, height: 40)
                .foregroundColor(.gray)
        }
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
        String(format: "%.f₽", value)
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
