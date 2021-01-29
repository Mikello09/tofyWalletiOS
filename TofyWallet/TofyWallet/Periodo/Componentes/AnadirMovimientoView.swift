//
//  AnadirMovimientoView.swift
//  TofyWallet
//
//  Created by usuario on 29/1/21.
//

import SwiftUI

struct AnadirMovimientoView: View {
    
    @State var descripcion: String = ""
    @State var valor: String = ""
    @Binding var categoria: Categoria?
    
    var elegirCategoria: () -> ()
    
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Text("anadirMovimiento".localized)
                        .setStyle(font: .semibold, size: 17, color: .negro)
                    Spacer()
                }
                .padding([.leading,.top],8)
                TextField("descripcion".localized, text: $descripcion)
                    .keyboardType(.asciiCapable)
                    .foregroundColor(.negro)
                    .modifier(CustomEditText(imagen: "a"))
                    .padding([.leading, .trailing])
                TextField("valor".localized, text: $valor)
                    .keyboardType(.decimalPad)
                    .foregroundColor(.negro)
                    .modifier(CustomEditText(imagen: "eurosign.square.fill"))
                    .padding([.leading, .trailing])
                if categoria != nil{
                    CategoriaItem(categoria: categoria!)
                        .onTapGesture {
                            self.elegirCategoria()
                        }
                } else {
                    HStack{
                        Text("anadirCategoria".localized)
                            .setStyle(font: .semibold, size: 21, color: .principal)
                            .onTapGesture {
                                self.elegirCategoria()
                            }
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .foregroundColor(.principal)
                            .frame(width: 20, height: 20)
                            .onTapGesture {
                                self.elegirCategoria()
                            }
                        Spacer()
                    }
                    .padding([.leading, .top])
                }
                Button(action: {
                    if puedeAnadir(){
                        
                    }
                }){EmptyView()}.buttonStyle(BotonPrincipal(text: "anadir".localized, enabled: puedeAnadir()))
                .padding()
                
            }
            .frame(maxWidth: .infinity)
        }
        .background(Color.blanco)
        .cornerRadius(5.0)
        .shadow(color: .gris, radius: 5.0, x: 3.0, y: 3.0)
        .padding()
    }
    
    func puedeAnadir() -> Bool{
        return descripcion != "" && valor != "" && categoria != nil
    }
}
