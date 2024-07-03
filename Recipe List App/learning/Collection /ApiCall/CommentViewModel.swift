//
//  CommentViewModel.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 10/05/22.
//

import Foundation
import SwiftUI

class CommentViewModel : ObservableObject {
    private let commonViewService : CommentsViewService
    @Published var comments = [CommentsModel]()
    @Published var searchResultComments = [CommentsModel]()
    
    
    init(commonViewService : CommentsViewService = CommentsViewService()) {
        self.commonViewService = commonViewService
    }
    
    
    
    func fetchComments(){
        commonViewService.getComments { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let comments):
                    self.comments = comments
                    self.searchResultComments = comments
                case .failure(let error):
                    print(error)
                }
            }
           
        }
    }
    
    func didGetSearchText(text : String){
        if text.isEmpty {
            searchResultComments = comments
        }else {
            searchResultComments = comments.filter{ $0.name?.lowercased().contains(text.lowercased()) ?? false}
        }
    }
    
}
