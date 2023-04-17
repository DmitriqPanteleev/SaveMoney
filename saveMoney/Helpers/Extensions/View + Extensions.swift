//
//  View + Extensions.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 04.04.2023.
//

import SwiftUI

extension View {
  func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
    background(
      GeometryReader { geometryProxy in
        Color.clear
          .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
      }
    )
    .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
  }
}

private struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

extension View {
    func bottomButton<Content: View>(buttonContent: @escaping () -> Content) -> some View {
        ZStack {
            self
            VStack {
                Spacer()
                buttonContent()
            }
            .padding(.top, 16)
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 16 : 10)
        }
    }
    
    func shadowBorder(backgroundColor: Color = .white,
                      cornerRadius: CGFloat = 20) -> some View {
        self
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .shadow(color: .black.opacity(0.08), radius: 4, y: 2)
    }
}

struct Popup<T: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    let popupContent: T
    
    init(isPresented: Binding<Bool>,
         @ViewBuilder popupContent: () -> T) {
        self._isPresented = isPresented
        self.popupContent = popupContent()
    }
    
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
            
            if isPresented {
                popupContent
                    .padding(.vertical, 8)
                    .shadowBorder(cornerRadius: 12)
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity).animation(.easeInOut(duration: 0.2)))
            }
        }
        .onChange(of: isPresented, perform: { newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        isPresented = false
                    }
                }
            }
        })
    }
}

extension View {
    
    func popUp<Content: View>(isPresented: Binding<Bool>,
                              content: @escaping () -> Content) -> some View {
        self
            .modifier(Popup(isPresented: isPresented,
                            popupContent: content))
    }
}
