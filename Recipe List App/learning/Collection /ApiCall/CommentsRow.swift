//
//  CommentsRow.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 10/05/22.
//

import SwiftUI

struct CommentsRow: View {
    var CommentModel : CommentsModel
    var body: some View {
        VStack {
            Text(CommentModel.name ?? "NA")
                .font(.title3)
            Text(CommentModel.email ?? "NA")
                .font(.title)
        }
    }
}

struct CommentsRow_Previews: PreviewProvider {
    static var previews: some View {
        CommentsRow(CommentModel: CommentsModel(postID: 1, id: 1, name: "mohan", email: "mohan@gmail.com", body: "lets ios and andorid"))
    }
}
