//
//  MainView.swift
//  TofyWallet
//
//  Created by usuario on 22/1/21.
//

import SwiftUI

enum TabItem: Int{
    case home = 0
    case periodo = 1
    case historico = 2
    
    func getIconoOn() -> String{
        switch self {
        case .home: return "house.fill"
        case .periodo: return "calendar.circle.fill"
        case .historico: return "doc.text.below.ecg.fill"
        }
    }
    
    func getIconoOff() -> String{
        switch self {
        case .home: return "house"
        case .periodo: return "calendar.circle"
        case .historico: return "doc.text.below.ecg"
        }
    }
    
    func getTitulo() -> String{
        switch self {
        case .home: return "\("greeting".localized) \(getUsuario().nombre ?? "")"
        case .periodo: return "Periodo"
        case .historico: return "Historico"
        }
    }
}

struct MainView: View {
    
    @State private var seleccion: TabItem = .home
    
    
    //BASEVIEW
    @State var showLoader: Bool = false
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    
    var body: some View {
        BaseView(showLoader: $showLoader, showError: $showError, errorMessage: $errorMessage, content:
            TabView(selection:$seleccion){
                PeriodoView(showLoader: $showLoader)
                    .onTapGesture {
                        self.hideKeyboard()
                    }
                    .tabItem {
                        TabBottonView(selection: self.$seleccion,tabBarItem: TabItem.periodo)
                    }.tag(TabItem.periodo)
                HomeView(showLoader: $showLoader)
                    .onTapGesture {
                        self.hideKeyboard()
                    }
                    .tabItem {
                        TabBottonView(selection: self.$seleccion,tabBarItem: TabItem.home)
                    }.tag(TabItem.home)
                HistoricoView(showLoader: $showLoader)
                    .onTapGesture {
                        self.hideKeyboard()
                    }
                    .tabItem {
                        TabBottonView(selection: self.$seleccion,tabBarItem: TabItem.historico)
                    }.tag(TabItem.historico)
            }
            .accentColor(.principal),
                 titulo: seleccion.getTitulo(),
                 atras: false
         )
    }
}

struct TabBottonView: View {
    
    @Binding var selection: TabItem
    let tabBarItem: TabItem
    
    var body: some View {
        Button(action: {
            self.selection = self.tabBarItem
        }) {
            VStack(alignment: .center) {
                Spacer()
                Image(systemName: ((selection == tabBarItem) ? tabBarItem.getIconoOn() : tabBarItem.getIconoOff()))
                Spacer()
            }.padding([.leading,.trailing])
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
