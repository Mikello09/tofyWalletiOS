//
//  AnadirMovimientoView.swift
//  TofyWallet
//
//  Created by usuario on 29/1/21.
//

import SwiftUI

struct AnadirMovimientoView: View {
    
    @Binding var anadiendoMovimiento: Bool
    @State var descripcion: String = ""
    @State var valor: String = ""
    @Binding var categoria: Categoria?
    
    var elegirCategoria: () -> ()
    var anadirMovimiento: (String, String, Categoria?) -> ()
    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        HStack{
                            Text("anadirMovimiento".localized)
                                .setStyle(font: .semibold, size: 17, color: .negro)
                                .padding()
                            Spacer()
                            Image(systemName: "xmark.square.fill")
                                .resizable()
                                .foregroundColor(.rojo)
                                .frame(width: 24, height: 24)
                                .padding()
                                .onTapGesture {
                                    anadiendoMovimiento = false
                                }
                        }
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
                                .padding([.leading, .trailing], 8)
                                .onTapGesture {
                                    self.elegirCategoria()
                                }
                        } else {
                            HStack{
                                Text("elegirCategoria".localized)
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
                            .padding(.leading)
                            .padding(.top, 8)
                        }
                        Button(action: {
                            if puedeAnadir(){
                                self.anadirMovimiento(descripcion,valor,categoria)
                            }
                        }){EmptyView()}.buttonStyle(BotonPrincipal(text: "anadir".localized, enabled: puedeAnadir()))
                        .padding([.leading, .trailing])
                        .padding([.top, .bottom],8)
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.blanco)
        }
    }
    
    func puedeAnadir() -> Bool{
        return descripcion != "" && valor != "" && categoria != nil
    }
}
