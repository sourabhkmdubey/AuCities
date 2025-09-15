//
//  AUCities.swift
//  AUCities
//
//  Created by Sourabh on 15/09/25.
//

import SwiftUI
struct AUStates: View {
    @StateObject var viewModel: AUCitiesViewModel
    var body: some View {
        ZStack {
            loadContentView()
        }
    }
    
    @ViewBuilder
    private func loadContentView() -> some View {
        // fill entire screen
        Color(AppConstants.appBackground)
            .ignoresSafeArea()
        NavigationView {
            showListView()
            .listStyle(.insetGrouped)
            .navigationTitle(AppConstants.appTitle)
            .toolbar {
                showToolBar()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

private extension AUStates {
    func showListView() -> some View {
        List {
            ForEach(viewModel.getCountryData(), id: \.state) { section in
                Section(header: HStack {
                    Text(section.state)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                    Button(action: {viewModel.toggleSection(section.state)}) {
                        Image(systemName: section.expanded ? AppConstants.upButtonImage : AppConstants.downButtonImage)
                            .foregroundColor(.primary)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                      ) {
                    if section.expanded {
                        ForEach(viewModel.getCities(section: section)) { city in
                            AUCities(city: city)
                        }
                    }
                }
            }
        }
    }
    
    @ToolbarContentBuilder
    func showToolBar() -> some ToolbarContent  {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: { viewModel.refresh() }) {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Image(systemName: AppConstants.leftToolBar)
                }
            }
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: { viewModel.toggleReverse() }) {
                Image(systemName: AppConstants.rightToolbar)
            }
            .accessibilityIdentifier(AppConstants.accesibilityIdentifier)
        }
    }
}
