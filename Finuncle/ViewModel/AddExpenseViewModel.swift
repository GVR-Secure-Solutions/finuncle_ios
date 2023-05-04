//
//  AddExpenseViewModel.swift
//  Finuncle
//
//  Created by Rahul on 01/04/23.
//

import Foundation
import UIKit

class AddExpenseViewModel: ObservableObject {
    
    @Published var rows: [Tags] = []
    @Published var date = Date()
    @Published var searchText = ""
    @Published var amount = ""
    @Published var errorMessage = ""
    @Published var showAlert = false
    @Published var expenseAdded = false
    @Published var tagsList: Tags = []
    @Published var tags: Tags = []
    var expense: ExpenseElement?
    
    private let httpClient = HttpClient.shared
    
    
    func updateExpense() {
        
        let selectedTags = tagsList.filter({ $0.isSelected == true })
        
        let params: [String: Any] = [
            "user": 1,
            "time": date.toString(format: "yyyy-MM-dd HH:mm:ss") ?? "",
            "amount": amount,
            "tags": selectedTags.compactMap({ $0.id })
        ]
        
        httpClient.put(url:  K.API.expenses+"257", parameters: params, includeBearerToken: true) { [weak self] (result: Result<ExpenseAddResponse, Error>) in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.expenseAdded.toggle()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorMessage = error.localizedDescription
                    self?.showAlert = true
                }
            }
        }
        
    }
    
    func hitAddExpense() {
        
        let selectedTags = tagsList.filter({ $0.isSelected == true })
        
        let params: [String: Any] = [
            "time": date.toString(format: "yyyy-MM-dd HH:mm:ss") ?? "",
            "amount": amount,
            "tags": selectedTags.compactMap({ $0.id })
        ]
        
        print(params.toJson()!)
        
        httpClient.post(url: K.API.expenses, parameters: params, includeBearerToken: true) { [weak self] (result: Result<ExpenseAddResponse, Error>) in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.expenseAdded.toggle()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorMessage = error.localizedDescription
                    self?.showAlert = true
                }
            }
        }
        
    }
    
    func getTagList() {
        
        let selectedTags = tagsList.filter({ $0.isSelected == true })
        
        httpClient.get(url: K.API.tag, includeBearerToken: true) { [weak self] (result: Result<Tags, Error>) in
            switch result {
            case .success(let tags):
                DispatchQueue.main.async {
                    if selectedTags.isEmpty {
                        
                        self?.tagsList = tags
                        
                    } else {
                        tags.forEach { tag in
                            selectedTags.forEach { selectedTag in
                                if tag.id == selectedTag.id {
                                    self?.tagsList.append(selectedTag)
                                } else {
                                    self?.tagsList.append(tag)
                                }
                            }
                        }
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorMessage = error.localizedDescription
                    self?.showAlert = true
                }
            }
        }
        
    }
    
    
    
    
    func addTag(tag: TagElement){
        if !tags.contains(where: { $0.id == tag.id }) {
            tags.append(tag)
        }
        getTags()
    }
    
    func removeTag(by id: Int){
        tags = tags.filter{ $0.id != id }
        if let tag = tagsList.filter({ $0.id == id }).first {
            if let index = tagsList.firstIndex(of: tag) {
                tagsList[index].isSelected = false
            }
        }
        getTags()
    }
    
    func getTags(){
        var rows: [Tags] = []
        var currentRow: Tags = []
        
        var totalWidth: CGFloat = 0
        
        let screenWidth = UIScreen.screenWidth - 10
        let tagSpaceing: CGFloat = 14 /*Leading Padding*/ + 30 /*Trailing Padding*/ + 6 + 6 /*Leading & Trailing 6, 6 Spacing*/
        
        if !tags.isEmpty{
            
            for index in 0..<tags.count{
                self.tags[index].size = tags[index].name.getSize()
            }
            
            tags.forEach{ tag in
                
                totalWidth += (tag.size! + tagSpaceing)
                
                if totalWidth > screenWidth{
                    totalWidth = (tag.size! + tagSpaceing)
                    rows.append(currentRow)
                    currentRow.removeAll()
                    currentRow.append(tag)
                }else{
                    currentRow.append(tag)
                }
            }
            
            if !currentRow.isEmpty{
                rows.append(currentRow)
                currentRow.removeAll()
            }
            
            self.rows = rows
        }else{
            self.rows = []
        }
        
    }
    
    
    func getPreselectedTagsForUpdation() {
        
        httpClient.get(url: K.API.tag, includeBearerToken: true) { [weak self] (result: Result<Tags, Error>) in
            switch result {
            case .success(let tags):
                DispatchQueue.main.async {
                    
                    let oldTags = tags.filter { tag in
                        guard let expense = self?.expense else {
                            return false
                        }
                        return expense.tags.contains(tag.id ?? 0)
                    }
                    
                    oldTags.forEach { tagData in
                        var selectedTag = tagData
                        selectedTag.isSelected = true
                        self?.tagsList.append(selectedTag)
                    }
                    
                    self?.getTags()
                    
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorMessage = error.localizedDescription
                    self?.showAlert = true
                }
            }
        }
        
    }
    
}
