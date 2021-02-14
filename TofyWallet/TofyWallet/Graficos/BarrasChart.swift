//
//  BarrasChart.swift
//  TofyWallet
//
//  Created by usuario on 29/1/21.
//

import SwiftUI

struct BarraItem: Hashable{
    var titulo: String
    var valor: CGFloat
    var color: Color
    var seleccionado: Bool = false
}

struct BarrasChart: View {
    
    @Binding var values: [BarraItem]
    
    var body: some View {
        GeometryReader{ geometry in
            HStack{
                ForEach(values, id: \.self){ item in
                    ZStack{
                        VStack{
                            Spacer()
                            Rectangle()
                                .fill(item.color)
                                .frame(maxWidth: .infinity)
                                .frame(height: self.calcularAltura(valor: item.valor, frameHeight: geometry.size.height - 8))//8 del padding
                                .cornerRadius(5.0)
                                .shadow(color: .gris, radius: 5.0, x: 3.0, y: 3.0)
                            
                        }
                        VStack{
                            Spacer()
                            VStack{
                                Text("\(String(format: "%.2f", item.valor))€")
                                    .setStyle(font: .semibold, size: 16, color: .negro)
                                Text("\(item.titulo)")
                                    .setStyle(font: .regular, size: 16, color: .negro)
                            }
                            .frame(height: self.calcularAlturaTexto(valor: item.valor, frameHeight: geometry.size.height - 8))
                        }
                    }
                    
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
    
    func ponderacion() -> CGFloat{
        var maxValue: CGFloat = 0.0
        for index in 0...(values.count - 1) {
            if values[index].valor > maxValue{
                maxValue = values[index].valor
            }
        }
        return maxValue
    }
    
    func calcularAltura(valor: CGFloat, frameHeight: CGFloat) -> CGFloat{
        let maxValue = ponderacion()
        let porcentajeSobrePonderacion = (valor/maxValue)
        return porcentajeSobrePonderacion*frameHeight
    }
    
    func calcularAlturaTexto(valor: CGFloat, frameHeight: CGFloat) -> CGFloat{
        let alturaBarra = calcularAltura(valor: valor, frameHeight: frameHeight)
        if alturaBarra < 40{
            return 50
        } else {
            return alturaBarra
        }
    }
}
