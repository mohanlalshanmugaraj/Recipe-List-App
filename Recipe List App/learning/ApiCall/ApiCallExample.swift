//
//  ApiCallExample.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 10/05/22.
//

//   https://jsonplaceholder.typicode.com/comments

import SwiftUI

struct ApiCallExample: View {
    @State private var searchText : String = ""
    @ObservedObject private var viewModel = CommentViewModel()
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.searchResultComments){ comment in
                        NavigationLink {
                            Text("Detail View  \(comment.name ?? "")")
                        } label: {
                        CommentsRow(CommentModel: comment)
                    }
                    }
                }.searchable(text: $searchText,placement :
                    .navigationBarDrawer(displayMode : .always))
                    .onChange(of: searchText ) { newValue in
                        print(newValue)
                        viewModel.didGetSearchText(text: newValue)
                    }
            }.onAppear {
                viewModel.fetchComments()
            }
        }
        
    }
}

struct ApiCallExample_Previews: PreviewProvider {
    static var previews: some View {
        ApiCallExample()
    }
}
