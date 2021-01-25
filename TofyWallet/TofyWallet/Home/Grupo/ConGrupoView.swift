//
//  ConGrupoView.swift
//  TofyWallet
//
//  Created by usuario on 25/1/21.
//

import SwiftUI

struct ConGrupoView: View {
    
    @Binding var grupo: Grupo
    var anadirCategoria: (_ categoria: Categoria) -> ()
    
    //AÑADIR CATEGORIA
    @State var anadiendoCategoria: Bool = false
    @State var tituloCategoria: String = ""
    @State var imagenCategoria: CategoriaImage = .interrogante
    @State var eligiendoImagen: Bool = false
    @State var tipoCategoria: TipoCategoria = .gasto
    
    var body: some View {
        ZStack{
            ScrollView(.vertical, showsIndicators: false){
                HStack{
                    Text(grupo.nombre ?? "")
                        .titulo(color: .principal)
                    Spacer()
                }
                .padding([.top, .leading, .trailing])
                Divider()
                    .background(Color.gris)
                    .padding([.leading, .trailing, .bottom])
                HStack{
                    Image(systemName: "tag.fill")
                        .resizable()
                        .foregroundColor(.principal)
                        .frame(width: 24, height: 24)
                    Text(grupo.token ?? "")
                        .infoImportante()
                    Spacer()
                }
                .padding([.leading, .trailing])
                .padding(.leading)
                HStack{
                    Text("miembros".localized)
                        .subtitulo(color: .negro)
                    Spacer()
                }
                .padding([.top, .leading, .trailing])
                Divider()
                    .background(Color.gris)
                    .padding([.leading, .trailing, .bottom])
                ForEach(grupo.mienbros ?? [], id: \.self){ miembro in
                    HStack{
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.principal)
                        Text(miembro.nombre ?? miembro.email ?? "")
                            .info()
                        Spacer()
                    }
                    .padding([.leading, .trailing])
                    .padding(.leading)
                }
                HStack{
                    Text("categorias".localized)
                        .subtitulo(color: .negro)
                    Spacer()
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundColor(.principal)
                        .frame(width: 24, height: 24)
                        .onTapGesture {
                            self.anadiendoCategoria = true
                        }
                }
                .padding([.top, .leading, .trailing])
                Divider()
                    .background(Color.gris)
                    .padding([.leading, .trailing, .bottom])
                if anadiendoCategoria {
                    VStack{
                        VStack{
                            HStack{
                                Text("anadirCategoria".localized)
                                    .info()
                                Spacer()
                                Image(systemName: "xmark.square.fill")
                                    .resizable()
                                    .foregroundColor(.rojo)
                                    .frame(width: 20, height: 20)
                                    .padding(.trailing)
                                    .onTapGesture {
                                        anadiendoCategoria = false
                                    }
                            }
                            .padding([.leading, .top, .bottom])
                            HStack{
                                TextField("categoria".localized, text: $tituloCategoria)
                                    .modifier(CustomEditText(imagen: ""))
                                Spacer()
                                VStack{
                                    VStack{
                                        Image(systemName: imagenCategoria.getImage())
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
                                    eligiendoImagen = true
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
                                        if tipoCategoria == .gasto{
                                            Circle()
                                                .fill(Color.principal)
                                                .frame(width: 16, height: 16)
                                                .padding([.top, .bottom, .leading])
                                        }
                                    }
                                    .onTapGesture {
                                        self.tipoCategoria = .gasto
                                    }
                                    Text("Gasto")
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
                                        if tipoCategoria == .ingreso{
                                            Circle()
                                                .fill(Color.principal)
                                                .frame(width: 16, height: 16)
                                                .padding([.top, .bottom, .leading])
                                        }
                                    }
                                    .onTapGesture {
                                        self.tipoCategoria = .ingreso
                                    }
                                    Text("Ingreso")
                                        .info()
                                        .padding(.trailing)
                                    Spacer()
                                }
                            }
                            Button(action: {
                                if tituloCategoria != ""{
                                    
                                }
                            }){EmptyView()}.buttonStyle(BotonPrincipal(text: "anadir".localized, enabled: tituloCategoria != ""))
                            .padding()
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .background(Color.blanco)
                    .cornerRadius(5.0)
                    .shadow(color: .gris, radius: 5.0, x: 3.0, y: 3.0)
                    .padding()
                }
                
            }
            if eligiendoImagen{
                CategoriasImagenPopup(imagenPopupShowed: $eligiendoImagen, imagenSeleccionada: { imagen in
                    imagenCategoria = imagen
                })
            }
        }
        
    }
}
