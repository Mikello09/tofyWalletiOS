//
//  BarrasHistoricoChart.swift
//  TofyWallet
//
//  Created by Mikel on 12/2/21.
//

import SwiftUI



struct BarrasHistoricoChart: View {
    
    @Binding var values: [BarraItem]
    var onBarraSeleccionada: (BarraItem) -> ()
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(spacing: 0){
                if existenValores(){
                    HStack{
                        Text("\(String(format: "%.2f", ponderacion())) \("euro".localized)")
                            .setStyle(font: .regular, size: 12, color: .principal)
                        Spacer()
                    }
                    .frame(height: 16)
                    HStack{
                        ForEach(Array(values.enumerated()), id: \.offset){ index, item in
                            ZStack{
                                VStack{
                                    Spacer()
                                    Rectangle()
                                        .fill(item.color)
                                        .frame(maxWidth: 50)
                                        .frame(height: self.calcularAltura(valor: item.valor, frameHeight: geometry.size.height - 40))//8 del padding
                                        .cornerRadius(5.0)
                                        .shadow(color: .negro, radius: 5.0, x: 3.0, y: 3.0)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(item.seleccionado ? Color.negro : Color.clear, lineWidth: 2)
                                        )
                                        .onTapGesture {
                                            self.graficoSeleccionado(index: index)
                                            self.onBarraSeleccionada(item)
                                        }
                                }
                            }
                        }
                    }
                    HStack{
                        Text("0 \("euro".localized)")
                            .setStyle(font: .regular, size: 12, color: .principal)
                        Spacer()
                    }
                    .frame(height: 16)
                } else {
                    Text("noHayValores".localized)
                        .setStyle(font: .semibold, size: 18, color: .principal)
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
        return maxValue == 0 ? 5 : maxValue
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
    
    func graficoSeleccionado(index: Int){
        values = values.enumerated().map({ (i, barra) -> BarraItem in
            var barraModificar = barra
            if i == index { barraModificar.seleccionado = true } else { barraModificar.seleccionado = false }
            return barraModificar
        })
    }
    
    func existenValores() -> Bool{
        var totalValue:CGFloat = 0
        for value in values{
            totalValue += value.valor
        }
        return totalValue != 0
    }
}

