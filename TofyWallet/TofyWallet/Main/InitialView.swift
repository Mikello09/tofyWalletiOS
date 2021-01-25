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
    
    @State var initialShowLoader: Bool = false
    
    var body: some View {
        NavigationView{
            BaseView(showLoader: $initialShowLoader, content:
                Group{
                    NavigationLink(destination: MainView(), isActive: $goToMain){EmptyView()}
                    NavigationLink(destination: LoginView(), isActive: $goToLogin){EmptyView()}
                }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarTitle("")
        .onAppear{
            viewModel.initApp()
        }
        .onReceive(viewModel.$inicio){ value in
            if let inicio = value{
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
