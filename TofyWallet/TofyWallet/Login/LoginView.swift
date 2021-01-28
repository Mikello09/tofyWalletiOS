//
//  LoginView.swift
//  TofyWallet
//
//  Created by usuario on 23/1/21.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    
    @State var email: String = ""
    @State var pass: String = ""
    
    @State var error: String = ""
    @State var goToMain: Bool = false
    
    //BASEVIEW
    @State var showLoader: Bool = false
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    
    var body: some View {
        BaseView(showLoader: $showLoader, showError: $showError, errorMessage: $errorMessage, content:
            VStack{
                TextField("email".localized, text: $email)
                    .foregroundColor(.negro)
                    .modifier(CustomEditText(imagen: "person.fill"))
                    .padding([.leading, .trailing])
                SecureField("pass".localized, text: $pass)
                    .foregroundColor(.negro)
                    .modifier(CustomEditText(imagen: "lock.fill"))
                    .padding([.leading, .trailing, .top])
                HStack{
                    Text(error).error()
                    Spacer()
                }.padding([.leading,.trailing])
                Image("AppIcon")
                    .resizable()
                    .frame(width: 100, height: 100)
                Text("Tofy Wallet").titulo(color: .principal)
                Button(action: {
                    if puedeHacerLogin(){
                        showLoader = true
                        viewModel.login(email: email, pass: pass)
                    }
                }){EmptyView()}.buttonStyle(BotonPrincipal(text: "entrar".localized, enabled: puedeHacerLogin()))
                .padding()
                Spacer()
                Group{
                    NavigationLink(destination: InitialView(), isActive: $goToMain){EmptyView()}
                }
            }
            .padding(.top, 64)
        )
        .onReceive(viewModel.$error){ err in
            if let error = err{
                showLoader = false
                self.error = error
            }
        }
        .onReceive(viewModel.$loginOk){ login in
            if let _ = login{
                goToMain = true
            }
        }
    }
    
    func puedeHacerLogin() -> Bool{
        return !email.isEmpty && !pass.isEmpty
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
