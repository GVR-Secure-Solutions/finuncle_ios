//
//  ExpenseListViewModel.swift
//  Finuncle
//
//  Created by Rahul on 02/04/23.
//

import Foundation


class ExpenseListViewModel: ObservableObject {
    
    private let httpClient = HttpClient.shared
    
    @Published var expenses = Expenses()
    @Published var errorMessage = ""
    @Published var isShowAlert = false
    var selectedExpense: ExpenseElement?
    
    init() {
        loadTags()
        //loadExpenses()
    }
    

    
    private func loadTags() {
        httpClient.get(url: K.API.tag, includeBearerToken: true) { [weak self] (result: Result<Tags, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    K.tags = response
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorMessage = error.localizedDescription
                    self?.isShowAlert = true
                }
            }
        }
    }
    
    func loadExpenses() {
        httpClient.get(url: K.API.expenses, includeBearerToken: true) { [weak self] (result: Result<Expenses, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.expenses = response
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorMessage = error.localizedDescription
                    self?.isShowAlert = true
                }
            }
        }
    }
    
}
