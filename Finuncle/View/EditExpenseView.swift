//
//  EditExpenseView.swift
//  Finuncle
//
//  Created by Rahul on 01/04/23.
//

import SwiftUI

struct EditExpenseView: View {
    
    @State var isPresentTagsScreen = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                
                GroupBox("Expense Details") {
                    VStack(spacing: 5) {
                        TextField("Amount", text: .constant(""))
                        Divider()
                    }
                    .padding(.top)
                    
                    VStack(spacing: 5) {
                        DatePicker("Choose the date", selection: .constant(Date()), displayedComponents: .date)
                        Divider()
                    }
                    .padding(.vertical)
                }
                .groupBoxStyle(.automatic)
                
                GroupBox("Tags") {
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
//            .sheet(isPresented: $isPresentTagsScreen) {
//                TagsListView(viewModel: viewMode)
//            }
        }
    }
}

struct EditExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        EditExpenseView()
    }
}
