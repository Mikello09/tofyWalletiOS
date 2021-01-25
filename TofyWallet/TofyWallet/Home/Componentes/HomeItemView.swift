//
//  HomeItemView.swift
//  TofyWallet
//
//  Created by usuario on 23/1/21.
//

import SwiftUI

enum HomeItem {
    case grupo
    case perfil
    case info
    
    func getTitulo() -> String{
        switch self {
        case .grupo: return "grupo".localized
        case .perfil: return "perfil".localized
        case .info: return "info".localized
        }
    }
    
    func getImage() -> String{
        switch self {
        case .grupo: return "group_image"
        case .perfil: return "perfil_imagen"
        case .info: return "icons8-info-250"
        }
    }
    
    func tieneAviso() -> Bool{
        switch self {
        case .grupo: return true
        case .perfil: return true
        case .info: return false
        }
    }
}

struct HomeItemView: View {
    
    var item: HomeItem
    var accion: (_ item: HomeItem) -> ()
    
    
    var body: some View {
        ZStack{
            HStack{
                HStack{
                    Text(item.getTitulo())
                        .item(color: .blanco)
                        .padding()
                    Spacer()
                    Image(item.getImage())
                        .resizable()
                        .frame(width: 32, height: 32)
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 60)
            }
            .background(Color.principal)
            .cornerRadius(5.0)
            .shadow(color: .gris, radius: 5.0, x: 3.0, y: 3.0)
            .padding([.top, .bottom],8)
            .padding([.leading, .trailing])
            .onTapGesture {
                accion(self.item)
            }
            if item.tieneAviso(){
                HStack{
                    ZStack{
                        Circle()
                            .fill(Color.rojo)
                            .frame(width: 24, height: 24)
                        Text("!")
                            .font(.system(size: 16, weight: .semibold, design: .default))
                            .foregroundColor(Color.blanco)
                    }
                    .padding(.bottom, 48)
                    .padding(.leading, 8)
                    Spacer()
                }
            }
        }
        
    }
}
