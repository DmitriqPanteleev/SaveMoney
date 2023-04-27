//
//  CreateProfileView.swift
//  saveMoney
//
//  Created by Дмитрий Пантелеев on 16.04.2023.
//

import SwiftUI

struct CreateProfileView: View {
    
    @StateObject var viewModel: CreateProfileViewModel
    
    var body: some View {
        LoadableView(state: viewModel.output.screenState,
                     content: content)
        .navigationTitle(Text(viewModel.output.signState.buttonMessage))
        .alert(isPresented: $viewModel.output.isShowingErrorAlert,
               content: alertContent)
    }
}

private extension CreateProfileView {
    func content() -> some View {
        TabView(selection: $viewModel.output.signState) {
            signInTab
                .tag(SigningState.signIn)
            signUpTab
                .tag(SigningState.signUp)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .bottomButton(buttonContent: signUpButtonView)
        .animation(.easeInOut(duration: 0.25),
                   value: viewModel.output.signState)
        .padding(.top, 20)
    }
    
    var signUpTab: some View {
        VStack(spacing: 24) {
            accountData
            personalData
            Spacer()
        }
        .padding(.horizontal)
    }
    
    var signInTab: some View {
        accountData
            .padding(.horizontal)
            .padding(.bottom, 50)
    }
    
    var accountData: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Данные для входа:")
                .font(.title3)
                .padding(.bottom, 8)
            
            emailFieldView
            passwordFieldView
        }
    }
    
    var personalData: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Личные данные:")
                .font(.title3)
                .padding(.bottom, 8)
            
            surnameFieldView
            nameFieldView
            phoneFieldView
        }
    }
    
    var surnameFieldView: some View {
        NameTextField(text: $viewModel.output.surname,
                      state: viewModel.output.surnameState,
                      placeholder: .surnamePlaceholder,
                      onChangeText: viewModel.input.onChangeSurname)
    }
    
    var nameFieldView: some View {
        NameTextField(text: $viewModel.output.name,
                      state: viewModel.output.nameState,
                      placeholder: .namePlaceholder,
                      onChangeText: viewModel.input.onChangeName)
    }
    
    var emailFieldView: some View {
        EmailTextField(text: $viewModel.output.email,
                       state: viewModel.output.emailState,
                       placeholder: .emailPlaceholder,
                       onChangeText: viewModel.input.onChangeEmail)
    }
    
    var passwordFieldView: some View {
        PasswordTextField(text: $viewModel.output.password,
                          isSecure: true,
                          state: viewModel.output.passwordState,
                          placeholder: .passwordPlaceholder,
                          onChangeText: viewModel.input.onChangePassword)
    }
    
    var phoneFieldView: some View {
        PhoneTextField(number: $viewModel.output.phone,
                       state: viewModel.output.phoneState,
                       placeholder: .phonePlaceholder,
                       onChangePhone: viewModel.input.onChangePhone)
    }
    
    func signUpButtonView() -> some View {
        VStack(spacing: 16){
            registrButton
            SigningButton(title: viewModel.output.signState == .signIn ? .signIn : .signUp,
                          sendableModel: viewModel.output.signState == .signIn ? .signIn : .signUp,
                          onTapAction: viewModel.input.onSaveTap)
            .disabled(!isButtonEnabled)
            .opacity(isButtonEnabled ? 1.0 : 0.5)
            .animation(.easeInOut(duration: 0.25))
        }
    }
    
    @ViewBuilder var registrButton: some View {
        if viewModel.output.signState == .signIn{
            Button(actionPublisher: viewModel.input.onChangeTab,
                   sendableModel: .signUp) {
                Text(.haveNoAccount)
                    .font(.caption)
                    .underline()
            }
            .tint(ColorsPalette.shared.lightOrange)
        }
    }
    
    func alertContent() -> Alert {
        Alert(title: Text(viewModel.output.errorMessage))
    }
}

private extension CreateProfileView {
    var isButtonEnabled: Bool {
        viewModel.output.signState == .signUp ? viewModel.output.emailState == .success && viewModel.output.passwordState == .success && viewModel.output.surnameState == .success && viewModel.output.nameState == .success && viewModel.output.phoneState == .success : viewModel.output.emailState == .success && viewModel.output.passwordState == .success
    }
}

#if DEBUG
struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView(viewModel: CreateProfileViewModel(apiService: AuthenticationApiService(client: HTTPClientImpl()), router: nil))
    }
}
#endif
