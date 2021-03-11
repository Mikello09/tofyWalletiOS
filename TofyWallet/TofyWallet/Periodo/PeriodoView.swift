//
//  Periodo.swift
//  TofyWallet
//
//  Created by usuario on 22/1/21.
//

import SwiftUI

enum BuscarPor{
    case todas
    case categorias
}

struct CategoriasFiltrado: Hashable{
    var categoria: Categoria
    var hidden: Bool
}

struct PeriodoView: View {
    
    @ObservedObject var viewModel: PeriodoViewModel = PeriodoViewModel()
    @State var estado: EstadoUsuario = .sinGrupo
    
    //BASE
    @Binding var showLoader: Bool
    @Binding var showError: Bool
    @Binding var errorMensaje: String
    
    //PERIODO ACTIVO
    @State var barras: [BarraItem] = [BarraItem(titulo: "", valor: 0, color: .clear),
                                      BarraItem(titulo: "", valor: 0, color: .clear)]
    @State var periodo: Periodo = Periodo()
    @State var movimientos: [Movimiento] = []
    @State var periodoFinalizado: Periodo?
    
    //CATEGORIAS
    @State var categorias: [CategoriasFiltrado] = []
    @State var buscarPor: BuscarPor = .todas
    
    //AÑADIR MOVIMIENTO
    @State var anadiendoMovimiento: Bool = false
    @State var categoriaParaAnadir: Categoria?
    @State var showElegirCategoria: Bool = false
    
    //FINALIZAR PERIODO
    @State var preguntarFinalizarPeriodo: Bool = false
    @State var showFinalizarPeriodoPopup: Bool = false
    
    var body: some View {
        ZStack{
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    VStack{
                        VStack{
                            if estado == .sinGrupo{
                                SinGrupoView()
                            } else if estado == .sinPeriodoActivo{
                                SinPeriodoView(iniciaPeriodo: iniciaPeriodo)
                            } else {
                                ZStack{
                                    PeriodoActivoView(periodo: $periodo, barras: $barras, anadirMovimiento: $anadiendoMovimiento,finalizarPeriodo: finalizarPeriodo)
                                    if anadiendoMovimiento{
                                        AnadirMovimientoView(anadiendoMovimiento: $anadiendoMovimiento,
                                                             categoria: $categoriaParaAnadir,
                                                             elegirCategoria: elegirCategoria,
                                                             anadirMovimiento: anadirMovimiento)
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 250)
                    }
                    .background(Color.blanco)
                    .cornerRadius(5.0)
                    .shadow(color: .gris, radius: 5.0, x: 3.0, y: 3.0)
                    .padding()
                    if estado == .conPeriodoActivo{
                        Picker(selection: $buscarPor, label: Text("Buscar por")) {
                            Text("Todos").tag(BuscarPor.todas)
                            Text("Conceptos").tag(BuscarPor.categorias)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding([.leading, .trailing])
                        .frame(height: BUTTON_HEIGHT)
                        if buscarPor == .todas{
                            ForEach(movimientos, id: \.self){ movimiento in
                                MovimientoItem(movimiento: movimiento)
                            }
                        } else {
                            ForEach(categorias, id: \.self){ categoria in
                                CategoriaHeader(categoria: categoria, movimientos: self.$movimientos)
                                    .onTapGesture {
                                        self.categorias = self.categorias.map({ (categoriaFiltrado) -> CategoriasFiltrado in
                                            if categoriaFiltrado.categoria.token == categoria.categoria.token{
                                                let isHidden = categoriaFiltrado.hidden ? false : true
                                                return CategoriasFiltrado(categoria:categoriaFiltrado.categoria, hidden: isHidden)
                                            } else {
                                                return categoriaFiltrado
                                            }
                                        })
                                    }
                                if !categoria.hidden{
                                    ForEach(movimientos.filter({$0.categoria?.token == categoria.categoria.token}), id: \.self){ movimiento in
                                        MovimientoItem(movimiento: movimiento)
                                    }
                                } else {
                                    EmptyView()
                                }
                            }
                        }
                        
                    }
                    Spacer()
                }
                
            }
            if preguntarFinalizarPeriodo{
                SiNoPopup(titulo: "finalizarPeriodoInfo".localized, si: siFinalizarPeriodo){self.preguntarFinalizarPeriodo = false}
            }
            if showFinalizarPeriodoPopup{
                PeriodoFinalizadoPopup(periodo: periodoFinalizado, periodoFinalizadoPopupShowed: $showFinalizarPeriodoPopup)
            }
        }
        .sheet(isPresented: $showElegirCategoria){
                ElegirCategoriaView(categoriaElegida: $categoriaParaAnadir, isPresenting: $showElegirCategoria)
        }
        .onAppear{
            viewModel.getEstado()
        }
        .onReceive(viewModel.$estadoUsuario){ value in
            if let estadoUsuario = value{
                showLoader = false
                self.estado = estadoUsuario
            }
        }
        .onReceive(GrupoManager.shared.$periodoActivo){ value in
            if let pActivo = value{
                if let periodoActivo = GrupoManager.shared.periodos?.filter({$0.token == pActivo}).first{
                    self.periodo = periodoActivo
                    calcularBarras(periodos: GrupoManager.shared.periodos)
                }
            }
        }
        .onReceive(GrupoManager.shared.$periodos){ value in
            if let periodos = value{
                self.showLoader = false
                calcularBarras(periodos: periodos)
            }
        }
        .onReceive(GrupoManager.shared.$categorias){ value in
            if let cat = value{
                self.categorias = cat.map({ (categoria) -> CategoriasFiltrado in
                    return CategoriasFiltrado(categoria: categoria, hidden: true)
                })
            }
        }
        .onReceive(viewModel.$periodoFinalizado){ value in
            if let periodoFinalizado = value {
                self.periodoFinalizado = periodoFinalizado
                showFinalizarPeriodoPopup = true
            }
        }
        .onReceive(viewModel.$error){ value in
            if let error = value{
                errorMensaje = error
                showError = true
                showLoader = false
            }
        }
    }
    
    func calcularBarras(periodos: [Periodo]?){
        var ingresos: CGFloat = 0
        var gastos: CGFloat = 0
        
        if let periodos = periodos{
            self.movimientos = (periodos.filter({$0.token == periodo.token}).first?.movimientos ?? []).reversed()
        }
        print(movimientos.count)
        for movimiento in movimientos{
            if movimiento.tipo == "Gasto"{
                gastos += (movimiento.valor ?? "").toNumber()
            }
            if movimiento.tipo == "Ingreso"{
                print("INGRESO",(movimiento.valor ?? "").toNumber())
                ingresos += (movimiento.valor ?? "").toNumber()
            }
        }
        
        let barraIngresos = BarraItem(titulo: "ingresos".localized, valor: ingresos, color: .verde)
        let barraGastos = BarraItem(titulo: "gastos".localized, valor: gastos, color: .rojo)
        
        self.barras = [barraIngresos,barraGastos]
    }
    
    func iniciaPeriodo(titulo: String, ahorroEstimado: String){
        showLoader = true
        viewModel.iniciarPeriodo(titulo: titulo, ahorroEstimado: ahorroEstimado)
    }
    
    func finalizarPeriodo(){
        preguntarFinalizarPeriodo = true
    }
    
    func siFinalizarPeriodo(){
        self.preguntarFinalizarPeriodo = false
        showLoader = true
        viewModel.finalizarPeriodo(periodoToken: periodo.token ?? "", movimientos: movimientos)
    }
    
    func elegirCategoria(){
        showElegirCategoria = true
    }
    
    func anadirMovimiento(descripcion: String, valor: String, categoria: Categoria?){
        self.showLoader = true
        anadiendoMovimiento = false
        let movimientoAnadir: Movimiento = Movimiento(token: nil,
                                                      descripcion: descripcion,
                                                      valor: valor,
                                                      categoria: categoria,
                                                      fecha: Date().toString(),
                                                      tipo: categoria?.tipo,
                                                      periodo: self.periodo.token,
                                                      grupo: getUsuario().grupo)
        viewModel.anadirMovimiento(movimiento: movimientoAnadir)
    }
}
