////
////  AuthorizationView.swift
////  saveMoney
////
////  Created by Дмитрий Пантелеев on 20.04.2023.
////
//
//import SwiftUI
//
//struct AuthorizationView: View {
//    var body: some View {
//        ZStack {
//            Text("Авторизация")
//                .font(.largeTitle)
//            VStack {
//                VStack(spacing: 40) {
//                    phoneTextFieldView
//                    passwordTextFieldView
//                }
//                .padding(.bottom, 4)
//                forgetPassword
//                    .padding(.bottom, 88)
//                enterButtonView
//            }
//            Spacer()
//            routeToRegistrButton
//        }
//        .padding(.vertical, 100)
//    }
//}
//
//private extension AuthorizationView {
//    var phoneTextFieldView: some View {
//        VStack {
//
//        }
//    }
//
//    var passwordTextFieldView: some View {
//        VStack {
//
//        }
//    }
//
//    var forgetPassword: some View {
//        HStack {
//
//        }
//    }
//
//    var enterButtonView: some View {
//        VStack {
//
//        }
//    }
//
//    var routeToRegistrButton: some View {
//        HStack {
//
//        }
//    }
//}
//struct Product: Identifiable {
//    let id: Int
//    let name: String
//    let imgUrl: String
//    let article: String
//    let category: String
//    let count: Int
//}
//
//struct ProductListView: View {
//    @Binding var products: [Product]
//
//    var body: some View {
//        VStack {
//            ScrollView {
//                ForEach(products) { product in
//                    VStack(alignment: .leading, spacing: 6) {
//                        ZStack(alignment: .topLeading) {
//                            countLabelView(count: product.count)
//                            imageView(url: product.imgUrl)
//                        }
//                        Text(product.name)
//                            .padding(.bottom, 36)
//                        HStack {
//                            VStack {
//                                Text("Артикул: \(product.article)")
//                                Text("Категория: \(product.category)")
//                            }
//                            Spacer()
//                            shopBasketButtonView
//                        }
//
//                    }
//                }
//            }
//        }
//    }
//}
//
//extension ProductListView {
//    func countLabelView(count: Int) -> some View {
//        VStack {
//
//        }
//    }
//
//    func imageView(url: String) -> some View {
//
//    }
//
//    var shopBasketButtonView: some View {
//
//    }
//}
//
//struct BasketView: View {
//    let product: Product
//
//    var body: some View {
//        VStack {
//            VStack(alignment: .leading, spacing: 6) {
//                ZStack(alignment: .topLeading) {
//                    countLabelView(count: product.count)
//                    imageView(url: product.imgUrl)
//                }
//                Text(product.name)
//                    .padding(.bottom, 36)
//                HStack {
//                    VStack {
//                        Text("Артикул: \(product.article)")
//                        Text("Категория: \(product.category)")
//                    }
//                    Spacer()
//                    inBasketCounterView
//                }
//            }
//            Spacer()
//            sendRequestButtonView
//        }
//    }
//}
//struct Profile {
//    let name: String
//    let imgUrl: String
//    let phone: String
//    let email: String
//}
//struct ProfileView: View {
//    let profile: Profile
//
//    var body: some View {
//        VStack {
//            Text("Профиль")
//                .font(.largeTitle)
//                .padding(.bottom, 42)
//            profileAvatarView(url: profile.imgUrl)
//                .padding(.bottom, 24)
//            nameBlock(name: profile.name)
//                .padding(.bottom, 32)
//            phoneTextFieldView(phone: profile.phone)
//            emailTextFieldView(email: profile.email)
//        }
//    }
//}
//
//extension ProfileView {
//    func profileAvatarView(url: String) -> some View {
//
//    }
//
//    func nameBlock(name: String) -> some View {
//
//    }
//
//    func phoneTextFieldView(phone: String) -> some View {
//
//    }
//
//    func emailTextFieldView(email: String) -> some View {
//
//    }
//}
//
//extension BasketView {
//    func countLabelView(count: Int) -> some View {
//        VStack {
//
//        }
//    }
//
//    func imageView(url: String) -> some View {
//
//    }
//
//    var shopBasketButtonView: some View {
//
//    }
//    var inBasketCounterView: some View {
//
//    }
//    var sendRequestButtonView: some View {
//
//    }
//}
//
//struct AuthorizationView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthorizationView()
//    }
//}
