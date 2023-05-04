//
//  EditExpenseView.swift
//  Finuncle
//
//  Created by Rahul on 01/04/23.
//

import SwiftUI

struct EditExpenseView: View {
    
    @StateObject var viewModel = AddExpenseViewModel()
    @State var isPresentTagsScreen = false
    var expense: ExpenseElement
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                
                GroupBox("Expense Details") {
                    VStack(spacing: 5) {
                        TextField("Amount", text: $viewModel.amount)
                        Divider()
                    }
                    .padding(.top)
                    
                    VStack(spacing: 5) {
                        DatePicker("Choose the date", selection: $viewModel.date, displayedComponents: .date)
                        Divider()
                    }
                    .padding(.vertical)
                }
                .groupBoxStyle(.automatic)
                
                GroupBox("Tags") {
                    
                    VStack {
                        ChipView()
                            .padding(0)
                        
                        Button {
                            isPresentTagsScreen.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .padding(3)
                                .foregroundColor(.white)
                                .font(.system(size: 12, weight: .bold))
                                .background(Circle())
                            
                            Text("Add Tags")
                        }
                        .frame(maxWidth: .infinity)
                        
                    }
                    
                    
                    
                }
                .groupBoxStyle(.automatic)

                Spacer()
            }
            .padding()
            .navigationTitle("Edit Expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Text("Save")
                }
                .padding()
                
            }
            .onChange(of: viewModel.expenseAdded, perform: { newValue in
                if newValue == true {
                    dismiss()
                }
            })
            .onAppear(perform: {
                viewModel.expense = expense
                viewModel.amount = expense.amount
                if let dateString = expense.time.toDate() {
                    viewModel.date = dateString
                }
                
                viewModel.getPreselectedTagsForUpdation()
                
            })
            .sheet(isPresented: $isPresentTagsScreen) {
                TagsListView(tags: $viewModel.tagsList, searchText: $viewModel.searchText)
                    .onAppear {
                        viewModel.getTagList()
                    }
                    .onDisappear {
                        viewModel.tagsList.filter { $0.isSelected == true }.forEach { tag in
                            viewModel.addTag(tag: tag)
                        }
                    }
            }
        }
    }
    
    @ViewBuilder
    func ChipView() -> some View {
        VStack(alignment: .leading, spacing: 4){
            ForEach(viewModel.rows, id:\.self){ rows in
                HStack(spacing: 6){
                    ForEach(rows){ row in
                        Text(row.name)
                            .font(.system(size: 16))
                            .padding(.leading, 14)
                            .padding(.trailing, 30)
                            .padding(.vertical, 8)
                            .background(
                                ZStack(alignment: .trailing){
                                    Capsule()
                                        .fill(.gray.opacity(0.3))
                                    Button{
                                        viewModel.removeTag(by: row.id!)
                                    } label:{
                                        Image(systemName: "xmark")
                                            .frame(width: 15, height: 15)
                                            .padding(.trailing, 8)
                                            .foregroundColor(Color.black)
                                    }
                                }
                            )
                    }
                }
                .frame(height: 28)
                .padding(.bottom, 10)
            }
        }
        .onAppear {
            viewModel.getTags()
        }
    }
    
}

struct EditExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        EditExpenseView(expense: ExpenseElement(id: 1, time: "", amount: "", user: 2, tags: [1]))
    }
}
