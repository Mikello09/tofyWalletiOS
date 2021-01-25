//
//  CategoriaItem.swift
//  TofyWallet
//
//  Created by usuario on 25/1/21.
//

import SwiftUI

struct CategoriaItem: View {
    
    var categoria: Categoria
    
    var body: some View {
        VStack{
            HStack{
                VStack{
                    HStack{
                        Text(categoria.titulo ?? "")
                            .infoImportante()
                        Spacer()
                    }
                    .padding(.leading)
                    HStack{
                        Text(categoria.tipo ?? "")
                            .info(color: categoria.tipo == "Gasto" ? .rojo : .verde)
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.leading)
                    }
                Spacer()
                Image(systemName: (categoria.imagen ?? "").toSystemImage())
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundColor(.principal)
                    .padding()
            }.frame(maxWidth: .infinity)
            .frame(height: 48)
        }
        .background(Color.blanco)
        .cornerRadius(5.0)
        .shadow(color: .gris, radius: 5.0, x: 3.0, y: 3.0)
        .padding(8)
    }
}
