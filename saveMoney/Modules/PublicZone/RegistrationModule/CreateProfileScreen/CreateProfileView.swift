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
        .navigationTitle(Text(.signUp))
        .alert(isPresented: $viewModel.output.isShowingErrorAlert,
               content: alertContent)
    }
}

private extension CreateProfileView {
    func content() -> some View {
        VStack(spacing: 24) {
            accountData
            personalData
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 20)
        .bottomButton(buttonContent: saveButtonView)
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
    
    func saveButtonView() -> some View {
        RegularButton(title: .signUp,
                      onTapAction: viewModel.input.onSaveTap)
        .disabled(!(viewModel.output.emailState == .success && viewModel.output.passwordState == .success && viewModel.output.surnameState == .success && viewModel.output.nameState == .success))
        .opacity((viewModel.output.emailState == .success && viewModel.output.passwordState == .success && viewModel.output.surnameState == .success && viewModel.output.nameState == .success) ? 1.0 : 0.5)
        .animation(.easeInOut(duration: 0.25))
    }
    
    func alertContent() -> Alert {
        Alert(title: Text(viewModel.output.errorMessage))
    }
}

#if DEBUG
struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView(viewModel: CreateProfileViewModel(apiService: AuthenticationService(client: HTTPClientImpl()), router: nil))
    }
}
#endif
