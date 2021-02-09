//
//  SelectableBoxItem.swift
//  TofyWallet
//
//  Created by Mikel on 9/2/21.
//

import SwiftUI

struct SelectableBoxItem: View {
    
    @Binding var selectedIndex: Int
    var index: Int
    var seleccionado: (Int) -> ()
    var titulo: String
    var imagen: String
    
    var body: some View {
        VStack{
            VStack(spacing: 4){
                if imagen != ""{
                    Image(systemName: imagen)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(selectedIndex == index ? .blanco : .principal)
                }
                Text(titulo)
                    .setStyle(font: .semibold, size: 16, color: selectedIndex == index ? .blanco : .principal)
            }
            .frame(width: 120, height: 60)
            .onTapGesture {
                self.seleccionado(index)
            }
        }
        .background(selectedIndex == index ? Color.principal : Color.blanco)
        .cornerRadius(5.0)
        .shadow(color: .gris, radius: 5.0, x: 3.0, y: 3.0)
        .padding()
    }
}
