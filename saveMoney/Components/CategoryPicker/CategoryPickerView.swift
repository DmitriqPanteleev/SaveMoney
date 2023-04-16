//
//  CategoryPickerView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 04.04.2023.
//

import SwiftUI
import Combine

struct CategoryPickerView: View {
    
    @State private var isExpanded = false
    @State private var currentCategoryId = -1
    @State private var availableWidth: CGFloat = 0
    @State private var elementsSize: [Category: CGSize] = [:]
    
    let models: [Category]
    let onCategoryChange: PassthroughSubject<Int, Never>
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.clear
                .frame(height: 1)
                .readSize { size in
                    availableWidth = size.width
                }
            
            flexibleView
        }
    }
}

private extension CategoryPickerView {
    var flexibleView: some View {
        Group {
            if isExpanded {
                expandedView
            } else {
                foldedView
            }
        }
    }
    
    var expandedView: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(computeRows(), id: \.self) { rows in
                HStack(spacing: 8) {
                    ForEach(rows) { element in
                        categoryCell(element)
                            .fixedSize()
                            .readSize { size in
                                elementsSize[element] = size
                            }
                    }
                }
            }
        }
    }
    
    var foldedView: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                ForEach(models.prefix(3)) { element in
                    categoryCell(element)
                        .fixedSize()
                        .readSize { size in
                            elementsSize[element] = size
                        }
                }
            }
            
            HStack(spacing: 8) {
                ForEach(models.dropFirst(3).prefix(2)) { element in
                    categoryCell(element)
                        .fixedSize()
                        .readSize { size in
                            elementsSize[element] = size
                        }
                }
                Button(action: expandView) {
                    HStack {
                        Text("Еще")
                    }
                    .padding(10)
                    .frame(width: 110, height: 40)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.1),
                            radius: 15,
                            y: 4)
                }
                .tint(Color.appGray)
            }
        }
    }
    
    func categoryCell(_ model: Category) -> some View {
        ZStack {
            HStack {
                coloredRingView(model)
                Spacer()
            }
            Text(model.name)
                .font(.system(size: 12))
                .padding(.leading, 14)
        }
        .padding(10)
        .frame(width: 110, height: 40)
        .background(currentCategoryId == model.id ? Color.gray.opacity(0.2) : Color.white)
        .cornerRadius(8)
        .shadow(color: currentCategoryId == model.id ? .clear : .black.opacity(0.1),
                radius: 15,
                y: 4)
        .onTapGesture {
            currentCategoryId = model.id
            onCategoryChangeSend(model.id)
        }
        .animation(.spring(),
                   value: currentCategoryId)
    }
    
    func coloredRingView(_ model: Category) -> some View {
        ZStack {
            Circle()
                .frame(width: 12)
                .foregroundColor(model.color)
            
            Circle()
                .frame(width: 8)
                .foregroundColor(.white)
        }
    }
}

private extension CategoryPickerView {
    func onCategoryChangeSend(_ value: Int) {
        onCategoryChange.send(value)
    }
    
    func expandView() {
        isExpanded = true
    }
    
    func computeRows() -> [[Category]] {
        var rows: [[Category]] = [[]]
        var currentRow = 0
        var remainingWidth = availableWidth
        
        for element in models {
            let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]
            
            if remainingWidth - (elementSize.width + 8) >= 0 {
                rows[currentRow].append(element)
            } else {
                currentRow = currentRow + 1
                rows.append([element])
                remainingWidth = availableWidth
            }
            
            remainingWidth = remainingWidth - (elementSize.width + 8)
        }
        
        return rows
    }
}

#if DEBUG
struct CategoryPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryPickerView(models: [.mock(), .mock2(), .mock3(), .mock4(), .mock2(), .mock(), .mock()],
                           onCategoryChange: PassthroughSubject<Int, Never>())
        
    }
}
#endif
