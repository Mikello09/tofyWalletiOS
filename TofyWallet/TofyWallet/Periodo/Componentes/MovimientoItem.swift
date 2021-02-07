//
//  MovimientoItem.swift
//  TofyWallet
//
//  Created by Marilyn Mishelle Garcia Tenesaca on 6/2/21.
//

import SwiftUI

struct MovimientoItem: View {
    
    var movimiento: Movimiento
    
    var body: some View {
        VStack{
            HStack{
                Text(movimiento.descripcion ?? "")
                    .setStyle(font: .semibold, size: 21, color: .principal)
                    .padding()
                Spacer()
                Text(movimiento.fecha?.toDateStringFormat() ?? "")
                    .setStyle(font: .regular, size: 17, color: .negro)
                    .padding()
            }
            Spacer()
            HStack{
                Text("\(movimiento.valor ?? "") €")
                    .setStyle(font: .semibold, size: 18, color: movimiento.tipo == "Gasto" ? .rojo : .verde)
                    .padding(.leading)
                    .padding(.leading)
                Spacer()
                Image(systemName: movimiento.categoria?.imagen?.toSystemImage() ?? "")
                    .padding(.trailing)
                    .foregroundColor(.principal)
            }
            Divider()
                .background(Color.gris)
                .padding([.leading, .trailing])
        }
        .frame(maxWidth: .infinity)
        .frame(height: 70)
        .padding()
    }
}
