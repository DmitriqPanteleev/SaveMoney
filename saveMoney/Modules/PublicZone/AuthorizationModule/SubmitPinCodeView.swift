//
//  SubmitPinCode.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 18.04.2023.
//

import SwiftUI
import Combine

struct SubmitPinCodeView: View {
    
    @StateObject var viewModel: SubmitPinCodeViewModel
    
    var body: some View {
        LoadableView(state: viewModel.output.screenState,
                     content: content,
                     onAppearDidLoad: viewModel.input.onAppear)
        .alert(isPresented: $viewModel.output.isShowAlert, content: alertContent)
    }
}

private extension SubmitPinCodeView {
    func content() -> some View {
        VStack(spacing: 36) {
            title
            PinCodeInputStatusView(inputCount: viewModel.output.pin.count)
            PinCodePadView(isFaceId: viewModel.output.isBiometryAvaliable, onCellTapPublisher: viewModel.input.onChangePin,
                           onEraseTapPublisher: viewModel.input.onErasePin,
                           onFaceIdTapPublisher: viewModel.input.onFaceIdTap)
        }
    }
    
    var title: some View {
        Text(.enterPin)
            .font(.title)
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }
    
    func alertContent() -> Alert {
        Alert(title: Text(viewModel.output.alertMessage))
    }
}

#if DEBUG
struct SubmitPinCodeView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitPinCodeView(viewModel: SubmitPinCodeViewModel(keychainManager: KeychainManger(serviceName: ""), biometricService: BiometricAuthenticationService(), router: nil))
    }
}
#endif

