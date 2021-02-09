//
//  HistoricoView.swift
//  TofyWallet
//
//  Created by usuario on 22/1/21.
//

import SwiftUI

struct HistoricoView: View {
    
    @ObservedObject var viewModel: HistoricoViewModel = HistoricoViewModel()
    
    //YEARS
    @State var years: [Int] = []
    @State var yearSelected: Int = 0
    
    @Binding var showLoader: Bool
    
    var body: some View {
        VStack{
            ScrollView(.horizontal, showsIndicators: false){
                ForEach(Array(years.enumerated()), id: \.offset){ offset, year in
                    SelectableBoxItem(selectedIndex: $yearSelected,
                                      index: offset,
                                      seleccionado: yearSelected,
                                      titulo: "\(year)",
                                      imagen: "")
                }
            }
        }
        .onAppear{
            viewModel.getYears()
        }
        .onReceive(viewModel.$years){ value in
            if let anos = value{
                self.years = anos
            }
        }
    }
    
    func yearSelected(index: Int){
        
    }
}
