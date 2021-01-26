//
//  InitialView.swift
//  TofyWallet
//
//  Created by usuario on 23/1/21.
//

import SwiftUI

struct InitialView: View {
    
    @ObservedObject var viewModel: InitialViewModel = InitialViewModel()
    
    @State var goToMain: Bool = false
    @State var goToLogin: Bool = false
    
    //BASEVIEW
    @State var showLoader: Bool = false
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    
    var body: some View {
        NavigationView{
            BaseView(showLoader: $showLoader, showError: $showError, errorMessage: $errorMessage, content:
                        VStack(alignment: .center){
                            Text("cargando".localized)
                                .info()
                            Group{
                                NavigationLink(destination: MainView(), isActive: $goToMain){EmptyView()}
                                NavigationLink(destination: LoginView(), isActive: $goToLogin){EmptyView()}
                            }
                }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarTitle("")
        .onAppear{
            showLoader = true
            viewModel.initApp()
        }
        .onReceive(viewModel.$inicio){ value in
            if let inicio = value{
                showLoader = false
                switch inicio {
                    case .login: goToLogin = true
                    case .main: goToMain = true
                }
            }
        }
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
