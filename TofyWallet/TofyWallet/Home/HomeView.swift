//
//  HomeView.swift
//  TofyWallet
//
//  Created by usuario on 22/1/21.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    
    @State var items: [HomeItem] = []
    
    @Binding var showLoader: Bool
    
    @State var goToGrupo: Bool = false
    
    var body: some View {
        VStack{
            VStack{
                VStack{
                    VStack{
                        
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)
                }
                .background(Color.blanco)
                .cornerRadius(5.0)
                .shadow(color: .gris, radius: 5.0, x: 3.0, y: 3.0)
                .padding()
                
            }
            Group{
                ForEach(items, id: \.self){ item in
                    HomeItemView(item: item, accion: itemSeleccionado(_:))
                }
            }
            Spacer()
            Group{
                NavigationLink(destination: GrupoView(), isActive: $goToGrupo){EmptyView()}
            }
        }
        .onAppear{
            viewModel.getItems()
        }
        .onReceive(viewModel.$items){ value in
            if let itemsToShow = value{
                items = itemsToShow
            }
        }
    }
    
    func itemSeleccionado(_ item: HomeItem){
        switch item {
        case .grupo: goToGrupo = true
        case .perfil: ()
        case .info: ()
        }
    }
}
