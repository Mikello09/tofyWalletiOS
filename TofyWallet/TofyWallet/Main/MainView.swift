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
    
    func getIcono() -> String{
        switch self {
        case .home: return "tab_home"
        case .periodo: return "tab_periodo"
        case .historico: return "tab_historico"
        }
    }
    
    func getTitulo() -> String{
        switch self {
        case .home: return "Global"
        case .periodo: return "Periodo"
        case .historico: return "Historico"
        }
    }
}

struct MainView: View {
    
    @State private var seleccion: TabItem = .home
    
    init(){
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }
    
    var body: some View {
        TabView(selection:$seleccion){
            PeriodoView()
                .tabItem {
                    TabBottonView(selection: self.$seleccion,tabBarItem: TabItem.periodo)
                }.tag(TabItem.periodo)
            HomeView()
                .tabItem {
                    TabBottonView(selection: self.$seleccion,tabBarItem: TabItem.home)
                }.tag(TabItem.home)
            HistoricoView()
                .tabItem {
                    TabBottonView(selection: self.$seleccion,tabBarItem: TabItem.historico)
                }.tag(TabItem.historico)
        }
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
                Image(tabBarItem.getIcono() + ((selection == tabBarItem) ? "_on" : ""))
                    .renderingMode(.original)
                    .frame(width: 24.0, height: 24.0)
                Text(tabBarItem.getTitulo()).info()
            }.padding([.leading,.trailing])
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
