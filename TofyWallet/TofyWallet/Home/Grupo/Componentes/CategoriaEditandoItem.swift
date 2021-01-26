//
//  CategoriaEditandoItem.swift
//  TofyWallet
//
//  Created by usuario on 25/1/21.
//

import SwiftUI

struct CategoriaEditandoItem: View {
    
    var categoria: Categoria
    var categoriaEditada: (_ categoria: Categoria) -> ()
    @State var titulo: String = ""
    @State var imagen: String = ""
    @State var tipo: TipoCategoria = .gasto
    
    @State var editandoImagen: Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                VStack{
                    HStack{
                        Text("editarCategoria".localized)
                            .info()
                        Spacer()
                    }
                    .padding([.leading, .top, .bottom])
                    HStack{
                        TextField("categoria".localized, text: $titulo)
                            .modifier(CustomEditText(imagen: ""))
                        Spacer()
                        VStack{
                            VStack{
                                Image(systemName: imagen.toSystemImage())
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.principal)
                            }
                            .frame(width: 48, height: 48)
                        }
                        .background(Color.blanco)
                        .cornerRadius(5.0)
                        .shadow(color: .gris, radius: 5.0, x: 3.0, y: 3.0)
                        .onTapGesture{
                            editandoImagen = true
                        }
                    }
                    .padding([.leading, .trailing])
                    HStack{
                        HStack{
                            ZStack{
                                Circle()
                                    .fill(Color.gris)
                                    .frame(width: 24, height: 24)
                                    .padding([.top, .bottom, .leading])
                                if tipo == .gasto{
                                    Circle()
                                        .fill(Color.principal)
                                        .frame(width: 16, height: 16)
                                        .padding([.top, .bottom, .leading])
                                }
                            }
                            .onTapGesture {
                                self.tipo = .gasto
                            }
                            Text("gasto".localized)
                                .info()
                            Spacer()
                        }
                        Spacer()
                        HStack{
                            ZStack{
                                Circle()
                                    .fill(Color.gris)
                                    .frame(width: 24, height: 24)
                                    .padding([.top, .bottom, .leading])
                                if tipo == .ingreso{
                                    Circle()
                                        .fill(Color.principal)
                                        .frame(width: 16, height: 16)
                                        .padding([.top, .bottom, .leading])
                                }
                            }
                            .onTapGesture {
                                self.tipo = .ingreso
                            }
                            Text("ingreso".localized)
                                .info()
                                .padding(.trailing)
                            Spacer()
                        }
                    }
                    Button(action: {
                        if titulo != ""{
                            categoriaEditada(Categoria(token: categoria.token,
                                                       titulo: titulo,
                                                       imagen: imagen,
                                                       tipo: tipo.rawValue))
                        }
                    }){EmptyView()}.buttonStyle(BotonPrincipal(text: "editar".localized, enabled: titulo != ""))
                    .padding()
                }
                .frame(maxWidth: .infinity)
            }
            .background(Color.blanco)
            .cornerRadius(5.0)
            .shadow(color: .gris, radius: 5.0, x: 3.0, y: 3.0)
            .padding()
            if editandoImagen{
                CategoriasImagenPopup(imagenPopupShowed: $editandoImagen, imagenSeleccionada: imagenEditada)
            }
        }
        
        .onAppear{
            titulo = categoria.titulo ?? ""
            imagen = categoria.imagen ?? ""
            tipo = (categoria.tipo ?? "").toCategoriaTipo()
        }
            
    }
    
    func imagenEditada(imagen: CategoriaImage){
        self.imagen = imagen.rawValue
    }
}
