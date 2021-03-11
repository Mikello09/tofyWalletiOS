//
//  HistoricoView.swift
//  TofyWallet
//
//  Created by usuario on 22/1/21.
//

import SwiftUI

enum TipoGrafico: String{
    case general = "General"
    case categorias = "Categorias"
    case periodos = "Periodos"
}

struct HistoricoView: View {
    
    @ObservedObject var viewModel: HistoricoViewModel = HistoricoViewModel()
    
    @State var tipoGrafico: TipoGrafico = .general
    
    //YEARS
    @State var years: [Int] = []
    @State var yearSelected: Int = 0
    
    //CATEGORIAS
    @State var categorias: [Categoria] = []
    @State var categoriaSelected: Int = 0
    
    //GENERAL
    @State var general: [Categoria] = []
    @State var generalSelected: Int = 0
    
    //PERIODOS
    @State var periodoSelected: Int = 0
    
    //BARRAS
    @State var barrasGeneral: [BarraItem] = []
    @State var barrasCagegorias: [BarraItem] = []
    @State var barrasPeriodos: [BarraItem] = []
    @State var barraSeleccionada: BarraItem?
    
    @State var periodos: [Periodo] = []
    
    
    @Binding var showLoader: Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 0){
                Group{
                    HStack{
                        Text("ano".localized)
                            .setStyle(font: .semibold, size: 16, color: .negro)
                            .padding([.leading, .top])
                        Spacer()
                    }
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 0){
                            ForEach(Array(years.enumerated()), id: \.offset){ offset, year in
                                SelectableBoxItem(selectedIndex: $yearSelected,
                                                  index: offset,
                                                  seleccionado: yearSelected,
                                                  titulo: "\(year)",
                                                  imagen: "")
                            }
                        }
                    }
                }
                Group{
                    HStack{
                        Text("elegirGrafico".localized)
                            .setStyle(font: .semibold, size: 16, color: .negro)
                            .padding([.leading])
                        Spacer()
                    }
                    Picker(selection: $tipoGrafico, label: Text("")) {
                        Text(TipoGrafico.general.rawValue).tag(TipoGrafico.general)
                        Text(TipoGrafico.categorias.rawValue).tag(TipoGrafico.categorias)
                        Text(TipoGrafico.periodos.rawValue).tag(TipoGrafico.periodos)
                    }.onChange(of: tipoGrafico) {value in
                        barraSeleccionada = nil
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding([.leading, .trailing])
                    .frame(height: BUTTON_HEIGHT)
                    if tipoGrafico == .general {
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 0){
                                ForEach(Array(general.enumerated()), id: \.offset){ offset, general in
                                    SelectableBoxItem(selectedIndex: $generalSelected,
                                                      index: offset,
                                                      seleccionado: generalSelected,
                                                      titulo: general.titulo ?? "",
                                                      imagen: general.imagen ?? "")
                                }
                            }
                        }
                    } else if tipoGrafico == .categorias {
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 0){
                                ForEach(Array(categorias.enumerated()), id: \.offset){ offset, categoria in
                                    SelectableBoxItem(selectedIndex: $categoriaSelected,
                                                      index: offset,
                                                      seleccionado: categoriaSelected,
                                                      titulo: categoria.titulo ?? "",
                                                      imagen: categoria.imagen ?? "")
                                }
                            }
                        }
                    } else {
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 0){
                                ForEach(Array(periodos.enumerated()), id: \.offset){ offset, periodo in
                                    SelectableBoxItem(selectedIndex: $periodoSelected,
                                                      index: offset,
                                                      seleccionado: periodoSelected,
                                                      titulo: periodo.titulo ?? "",
                                                      imagen: "")
                                }
                            }
                        }
                    }
                    
                }
                if tipoGrafico == .general{
                    if general.count > 0 {
                        Group{
                            VStack{
                                Text(general[generalSelected].titulo ?? "")
                                    .setStyle(font: .semibold, size: 18, color: .principal)
                                if barraSeleccionada != nil{
                                    ZStack{
                                        Rectangle()
                                            .fill(barraSeleccionada?.color ?? Color.negro)
                                            .frame(width: 120, height: 40)
                                            .cornerRadius(5.0)
                                            .shadow(color: .gris, radius: 5.0, x: 3.0, y: 3.0)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 5)
                                                    .stroke(Color.negro, lineWidth: 2)
                                            )
                                        Text("\(barraSeleccionada?.titulo ?? "")\n\(String(format: "%.2f", barraSeleccionada?.valor ?? 0)) \("euro".localized)")
                                            .setStyle(font: .semibold, size: 14, color: .negro)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                                BarrasHistoricoChart(values: $barrasGeneral, onBarraSeleccionada: barraSeleccionada)
                                    .frame(height: 250)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.gris)
                            }
                        }
                    } else {
                        Text("No hay generales disponibles")
                            .setStyle(font: .semibold, size: 18, color: .principal)
                    }
                } else if tipoGrafico == .categorias{
                    if categorias.count > 0{
                        Group{
                            VStack{
                                Text(categorias[categoriaSelected].titulo ?? "")
                                    .setStyle(font: .semibold, size: 18, color: .principal)
                                if barraSeleccionada != nil{
                                    ZStack{
                                        Rectangle()
                                            .fill(barraSeleccionada?.color ?? Color.negro)
                                            .frame(width: 120, height: 40)
                                            .cornerRadius(5.0)
                                            .shadow(color: .gris, radius: 5.0, x: 3.0, y: 3.0)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 5)
                                                    .stroke(Color.negro, lineWidth: 2)
                                            )
                                        Text("\(barraSeleccionada?.titulo ?? "")\n\(String(format: "%.2f", barraSeleccionada?.valor ?? 0)) \("euro".localized)")
                                            .setStyle(font: .semibold, size: 14, color: .negro)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                                BarrasHistoricoChart(values: $barrasCagegorias, onBarraSeleccionada: barraSeleccionada)
                                    .frame(height: 250)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.gris)
                            }
                            
                        }
                    } else {
                        Text("No hay categorías disponibles")
                            .setStyle(font: .semibold, size: 18, color: .principal)
                    }
                } else {
                    if periodos.count > 0{
                        Group{
                            VStack{
                                Text(periodos[periodoSelected].titulo ?? "")
                                    .setStyle(font: .semibold, size: 18, color: .principal)
                                if barraSeleccionada != nil{
                                    ZStack{
                                        Rectangle()
                                            .fill(barraSeleccionada?.color ?? Color.negro)
                                            .frame(width: 120, height: 40)
                                            .cornerRadius(5.0)
                                            .shadow(color: .gris, radius: 5.0, x: 3.0, y: 3.0)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 5)
                                                    .stroke(Color.negro, lineWidth: 2)
                                            )
                                        Text("\(barraSeleccionada?.titulo ?? "")\n\(String(format: "%.2f", barraSeleccionada?.valor ?? 0)) \("euro".localized)")
                                            .setStyle(font: .semibold, size: 14, color: .negro)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                                BarrasHistoricoChart(values: $barrasPeriodos, onBarraSeleccionada: barraSeleccionada)
                                    .frame(height: 250)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.gris)
                            }
                        }
                    } else {
                        Text("No hay periodos disponibles")
                            .setStyle(font: .semibold, size: 18, color: .principal)
                    }
                }
                if tipoGrafico == .general{
                    ForEach(Array(periodos.enumerated()), id: \.offset){ offset, periodo in
                        HStack{
                            Rectangle()
                                .fill(viewModel.getGraficoColor(index: offset))
                                .frame(width: 32, height: 32)
                                .cornerRadius(5.0)
                                .shadow(color: .gris, radius: 5.0, x: 3.0, y: 3.0)
                            Text(periodo.titulo ?? "")
                                .setStyle(font: .semibold, size: 18, color: .negro)
                            Spacer()
                        }
                        .padding()
                    }
                } else if tipoGrafico == .categorias{
                    ForEach(Array(periodos.enumerated()), id: \.offset){ offset, periodo in
                        HStack{
                            Rectangle()
                                .fill(viewModel.getGraficoColor(index: offset))
                                .frame(width: 32, height: 32)
                                .cornerRadius(5.0)
                                .shadow(color: .gris, radius: 5.0, x: 3.0, y: 3.0)
                            Text(periodo.titulo ?? "")
                                .setStyle(font: .semibold, size: 18, color: .negro)
                            Spacer()
                        }
                        .padding()
                    }
                } else {
                    ForEach(Array(categorias.enumerated()), id: \.offset){ offset, categoria in
                        HStack{
                            Rectangle()
                                .fill(viewModel.getGraficoColor(index: offset))
                                .frame(width: 32, height: 32)
                                .cornerRadius(5.0)
                                .shadow(color: .gris, radius: 5.0, x: 3.0, y: 3.0)
                            Text(categoria.titulo ?? "")
                                .setStyle(font: .semibold, size: 18, color: .negro)
                            Spacer()
                        }
                        .padding()
                    }
                }
                Spacer()
            }
        }
        .onAppear{
            viewModel.getYears()
            viewModel.getGeneralCategorias()
        }
        .onReceive(viewModel.$years){ value in
            if let anos = value{
                self.years = anos
            }
        }
        .onReceive(viewModel.$generalCategorias){ value in
            if let categoriasGeneral = value{
                self.general = categoriasGeneral
                calcularBarrasGeneral()
            }
        }
        .onReceive(GrupoManager.shared.$categorias){ value in
            if let categoriasGrupo = value{
                self.categorias = categoriasGrupo
                calcularBarrasCategorias()
                calcularBarrasPeriodos()
            }
        }
        .onReceive(GrupoManager.shared.$periodos){ value in
            if let periodosEnGrupo = value{
                self.periodos = periodosEnGrupo
                calcularBarrasPeriodos()
            }
        }
    }
    
    func calcularBarrasGeneral(){
        var barrasGeneralAmostrar: [BarraItem] = []
        if general[generalSelected].token == "ahorro"{
            barrasGeneralAmostrar = periodos.enumerated().map({ (index,periodo) -> BarraItem in
                return BarraItem(titulo: periodo.titulo ?? "", valor: periodo.ahorroFinal?.toNumber() ?? 0, color: self.viewModel.getGraficoColor(index: index))
            })
        } else if general[generalSelected].token == "gasto"{
            for (index,periodo) in periodos.enumerated(){
                var gasto: CGFloat = 0
                for movimiento in periodo.movimientos ?? []{
                    if movimiento.tipo == "Gasto"{
                        gasto += movimiento.valor?.toNumber() ?? 0
                    }
                }
                barrasGeneralAmostrar.append(BarraItem(titulo: periodo.titulo ?? "", valor: gasto, color: self.viewModel.getGraficoColor(index: index)))
            }
        } else {
            for (index,periodo) in periodos.enumerated(){
                var ingreso: CGFloat = 0
                for movimiento in periodo.movimientos ?? []{
                    if movimiento.tipo == "Ingreso"{
                        ingreso += movimiento.valor?.toNumber() ?? 0
                    }
                }
                barrasGeneralAmostrar.append(BarraItem(titulo: periodo.titulo ?? "", valor: ingreso, color: self.viewModel.getGraficoColor(index: index)))
            }
        }
        
        self.barrasGeneral = barrasGeneralAmostrar
    }
    
    func calcularBarrasCategorias(){
        var barrasCategoriasAmostrar: [BarraItem] = []
        for (index,periodo) in periodos.enumerated(){
            var valor: CGFloat = 0
            for movimiento in periodo.movimientos ?? []{
                if movimiento.categoria?.token == categorias[categoriaSelected].token{
                    valor += movimiento.valor?.toNumber() ?? 0
                }
            }
            barrasCategoriasAmostrar.append(BarraItem(titulo: periodo.titulo ?? "", valor: valor, color: self.viewModel.getGraficoColor(index: index)))
        }
        self.barrasCagegorias = barrasCategoriasAmostrar
    }
    
    func calcularBarrasPeriodos(){
        var barrasPeriodosAmostrar: [BarraItem] = []
        if periodos.count > 0 {
            for (index,categoria) in categorias.enumerated(){
                var valorCategoria: CGFloat = 0
                for movimiento in periodos[periodoSelected].movimientos ?? []{
                    if movimiento.categoria?.token == categoria.token{
                        valorCategoria += movimiento.valor?.toNumber() ?? 0
                    }
                }
                barrasPeriodosAmostrar.append(BarraItem(titulo: categoria.titulo ?? "", valor: valorCategoria, color: self.viewModel.getGraficoColor(index: index)))
            }
        }
        barrasPeriodos = barrasPeriodosAmostrar
    }
    
    func yearSelected(index: Int){
        yearSelected = index
    }
    
    func generalSelected(index: Int){
        generalSelected = index
        barraSeleccionada = nil
        calcularBarrasGeneral()
    }
    
    func categoriaSelected(index: Int){
        categoriaSelected = index
        barraSeleccionada = nil
        calcularBarrasCategorias()
    }
    
    func periodoSelected(index: Int){
        periodoSelected = index
        barraSeleccionada = nil
        calcularBarrasPeriodos()
    }
    
    func barraSeleccionada(barra: BarraItem){
        self.barraSeleccionada = barra
    }
}
