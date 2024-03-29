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
    var editarCategoria: (_ categoria: Categoria) -> ()
    var abandonarGrupo: () -> ()
    
    //AÑADIR CATEGORIA
    @State var anadiendoCategoria: Bool = false
    @State var tituloCategoria: String = ""
    @State var imagenCategoria: CategoriaImage = .interrogante
    @State var eligiendoImagen: Bool = false
    @State var tipoCategoria: TipoCategoria = .gasto
    @State var editandoImagen: Bool = false
    
    //EDITAR CATEGORIA
    @State var editandoCategorias: Bool = false
    @State var grupoAEditar: Grupo = Grupo()
    @State var tokenCategoriaEditando: String = ""
    
    var body: some View {
        ZStack{
            ScrollView(.vertical, showsIndicators: false){
                Group{
                    HStack{
                        Text(grupo.nombre ?? "")
                            .titulo(color: .principal)
                        Spacer()
                    }
                    .padding([.top, .leading, .trailing])
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
                }
                Group{
                    HStack{
                        Text("ahorro".localized)
                            .subtitulo(color: .negro)
                        Spacer()
                    }
                    .padding([.top, .leading, .trailing])
                    Divider()
                        .background(Color.gris)
                        .padding([.leading, .trailing, .bottom])
                    HStack{
                        Image(systemName: "eurosign.square.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.verde)
                        Text(grupo.ahorro ?? "")
                            .infoImportante()
                        Spacer()
                    }
                    .padding([.leading, .trailing])
                    .padding(.leading)
                }
                Group{
                    HStack{
                        Text("miembros".localized)
                            .subtitulo(color: .negro)
                        Spacer()
                    }
                    .padding([.top, .leading, .trailing])
                    Divider()
                        .background(Color.gris)
                        .padding([.leading, .trailing, .bottom])
                    ForEach(grupo.miembros ?? [], id: \.self){ miembro in
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
                }
                Group{
                    HStack{
                        Text("categorias".localized)
                            .subtitulo(color: .negro)
                        if (grupo.categorias ?? []).count > 0{
                            ZStack{
                                HStack{
                                    Image(systemName: editandoCategorias ? "checkmark.circle" : "pencil.circle")
                                        .resizable()
                                        .foregroundColor(.blanco)
                                        .frame(width: 16, height: 16)
                                        .padding(.leading, 4)
                                    Spacer()
                                }
                                HStack{
                                    Spacer()
                                    Text(editandoCategorias ? "aceptar".localized : "editar".localized)
                                        .setStyle(font: .semibold, size: 16, color: .blanco)
                                    Spacer()
                                }
                            }
                            .frame(width: 110, height: 24)
                            .background(Color.principal)
                            .cornerRadius(4)
                            .onTapGesture {
                                self.editandoCategorias.toggle()
                            }
                        }
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
                                            imagenCategoria = .interrogante
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
                                        Text("gasto".localized)
                                            .info(color: .rojo)
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
                                        Text("ingreso".localized)
                                            .info(color: .verde)
                                            .padding(.trailing)
                                        Spacer()
                                    }
                                }
                                Button(action: {
                                    if tituloCategoria != ""{
                                        anadiendoCategoria = false
                                        self.anadirCategoria(Categoria(token: nil,
                                                                       titulo: tituloCategoria,
                                                                       imagen: imagenCategoria.rawValue,
                                                                       tipo: tipoCategoria.rawValue))
                                        //refrescar valores
                                        tituloCategoria = ""
                                        imagenCategoria = .interrogante
                                        tipoCategoria = .gasto
                                        
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
                    if !editandoCategorias{
                        ForEach(grupo.categorias ?? [], id: \.self){ categoria in
                            CategoriaItem(categoria: categoria)
                        }
                    } else {
                        ForEach(grupoAEditar.categorias ?? [], id: \.self){ categoria in
                            CategoriaEditandoItem(categoria: categoria, categoriaEditada: categoriaEditada, editandoImagen: editandoImagen)
                        }
                    }
                    Button(action: {
                        abandonarGrupo()
                    }){EmptyView()}.buttonStyle(BotonEliminar(text: "abandonar".localized))
                    .padding()
                                                    
                }
            }
            if eligiendoImagen{
                CategoriasImagenPopup(imagenPopupShowed: $eligiendoImagen, imagenSeleccionada: { imagen in
                    imagenCategoria = imagen
                })
            }
            if editandoImagen{
                CategoriasImagenPopup(imagenPopupShowed: $editandoImagen, imagenSeleccionada: { imagen in
                    grupoAEditar.categorias = grupoAEditar.categorias?.map({ categoria in
                        var c = categoria
                        if c.token == tokenCategoriaEditando{
                            c.imagen = imagen.rawValue
                        }
                        return c
                    })
                })
            }
        }
        .onAppear(){
            self.grupoAEditar = grupo
        }
        
    }
    
    func editandoImagen(categoria: Categoria){
        self.tokenCategoriaEditando = categoria.token ?? ""
        editandoImagen.toggle()
    }
    
    func categoriaEditada(categoria: Categoria){
        editandoCategorias = false
        self.editarCategoria(categoria)
    }
}
