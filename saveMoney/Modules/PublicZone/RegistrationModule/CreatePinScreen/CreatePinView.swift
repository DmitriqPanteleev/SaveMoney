//
//  CreatePinView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 18.04.2023.
//

import SwiftUI
import Combine

struct CreatePinView: View {
    
    @StateObject var viewModel: CreatePinViewModel
    
    var body: some View {
        content()
            .popUp(isPresented: $viewModel.output.isShowPopup,
                   content: popupContent)
    }
}

private extension CreatePinView {
    func content() -> some View {
        VStack(spacing: 36) {
            Spacer()
            title
            pinInputView
            pinPadView
            Spacer()
        }
    }
    
    var title: some View {
        Text(.createPin)
            .foregroundColor(.black)
            .font(.title)
    }
    
    @ViewBuilder var pinInputView: some View {
        if viewModel.output.pin.count == 4 {
            PinCodeStatusLoadingView()
        } else {
            PinCodeInputStatusView(inputCount: viewModel.output.pin.count)
        }
    }
    
    var pinPadView: some View {
        PinCodePadView(onCellTapPublisher: viewModel.input.onChangePin,
                       onEraseTapPublisher: viewModel.input.onErasePin)
        .disabled(viewModel.output.isPadDisabled)
        .animation(.easeIn, value: viewModel.output.isPadDisabled)
    }
    
    func popupContent() -> some View {
        HStack(spacing: 8) {
            Image(systemName: "checkmark.seal.fill")
                .defaultAppIcon(color: .mint)
            
            Text(.pinSavedSuccess)
        }
    }
}

#if DEBUG
struct CreatePinView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePinView(viewModel: CreatePinViewModel(keychainManager: KeychainManger(serviceName: ""), token: .empty(), router: nil))
    }
}
#endif

