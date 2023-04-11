//
//  TagsListView.swift
//  Finuncle
//
//  Created by Rahul on 01/04/23.
//

import SwiftUI

struct TagsListView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var tags: Tags
    @Binding var searchText: String
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(tags.enumerated()), id: \.1) { (index, tag) in
                    HStack {
                        Text(tag.name)
                        Spacer()
                        
                        Image(systemName: "checkmark")
                            .font(.footnote)
                            .foregroundColor(.white)
                            .padding(3)
                            .background(RoundedRectangle(cornerRadius: 1).foregroundColor((tag.isSelected ?? false) ? .blue : .white))
                    }
                    .onTapGesture {
                        if tags[index].isSelected ?? false {
                            tags[index].isSelected = false
                        } else {
                            tags[index].isSelected = true
                        }
                    }
                    
                    
                }
            }
            .searchable(text: $searchText, prompt: "Search")
            .navigationTitle("Select Tag")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    dismiss()
                }
                .padding(.horizontal)
            }
        }
    }
}

struct TagsListView_Previews: PreviewProvider {
    static var previews: some View {
        TagsListView(tags: .constant([]), searchText: .constant(""))
    }
}
