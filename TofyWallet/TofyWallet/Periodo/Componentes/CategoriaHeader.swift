//
//  CategoriaHeader.swift
//  TofyWallet
//
//  Created by Marilyn Mishelle Garcia Tenesaca on 7/2/21.
//

import SwiftUI

struct CategoriaHeader: View {
    
    var categoria: CategoriasFiltrado
    @Binding var movimientos: [Movimiento]
    
    var body: some View {
        HStack{
            Image(systemName: categoria.categoria.imagen?.toSystemImage() ?? "")
                .resizable()
                .foregroundColor(.principal)
                .frame(width: 32, height: 32)
            Text(categoria.categoria.titulo ?? "")
                .setStyle(font: .semibold, size: 18, color: .principal)
            Spacer()
            if !categoria.hidden{
                HStack{
                    Text("\("total".localized):")
                        .setStyle(font: .regular, size: 12, color: .negro)
                    Text("\(calcularTotalCategoria()) €")
                        .setStyle(font: .semibold, size: 14, color: .principal)
                }
            } else {
                EmptyView()
            }
            Image(systemName: categoria.hidden ? "chevron.down" : "chevron.up")
                .foregroundColor(.gris)
        }
        .padding([.leading, .trailing])
    }
    
    func calcularTotalCategoria() -> String{
        var total:Double = 0
        for movimiento in movimientos{
            if movimiento.categoria?.token == categoria.categoria.token{
                total += Double(movimiento.valor ?? "") ?? 0
            }
        }
        return "\(total)"
    }
}
