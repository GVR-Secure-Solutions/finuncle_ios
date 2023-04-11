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
    
    private let httpClient = HttpClient.shared
    
  
    
    
    func hitAddExpense() {
        
        let params: [String: Any] = [
            "time": date,
            "amount": amount,
            "tags": [1, 2, 3, 4]
        ]
        
        httpClient.post(url: K.API.expenses, parameters: params, includeBearerToken: true) { [weak self] (result: Result<ExpenseElement, Error>) in
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
        
        httpClient.get(url: K.API.tag, includeBearerToken: false) { [weak self] (result: Result<Tags, Error>) in
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
    
}
