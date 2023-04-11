//
//  ExpenseListView.swift
//  Finuncle
//
//  Created by Rahul on 01/04/23.
//

import SwiftUI

struct ExpenseListView: View {
    
    
    @StateObject private var viewModel = ExpenseListViewModel()
    @State var isShowEditScreen = false
    
    func deleteItems(at offsets: IndexSet) {
        //order.items.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.expenses, id: \.id) { expense in
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(expense.dateString)
                                .font(.body)
                            Text(expense.tagsData)
                                .font(.caption)
                        }
                        
                        Spacer()
                        
                        Text("\(expense.amount) ₹")
                            .font(.body)
                            .fontWeight(.bold)
                        
                    }
                    
                }
                .swipeActions {
                    
                    Button(role: .destructive) {
                        print("Deleting conversation")
                    } label: {
                        Label("Delete", systemImage: "trash.fill")
                    }
                    
                    Button {
                        isShowEditScreen.toggle()
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                    .tint(.indigo)
                    
                }
                
            }
            .navigationTitle("Finuncle")
            .toolbar {
                NavigationLink(destination: AddExpenseView()) {
                    Text("Add Expense")
                }
            }
            .sheet(isPresented: $isShowEditScreen) {
                EditExpenseView()
            }
            
            
        }
    }
}

struct ExpenseListView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseListView()
    }
}
