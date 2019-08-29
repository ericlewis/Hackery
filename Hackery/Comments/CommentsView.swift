//
//  CommentsView.swift
//  Hackery
//
//  Created by Tim Shim on 6/17/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import SwiftUI

struct MultilineTextView: UIViewRepresentable {
    let text: String

    func makeUIView(context: Context) -> UITextView {
        let tv = UITextView()
        tv.dataDetectorTypes = .link
        tv.isEditable = false
        tv.textColor = UIColor(named: "titleColor")
        tv.font = UIFont(name: "Lato-Regular", size: 16)
        tv.isScrollEnabled = false
        tv.textContainer.lineBreakMode = .byWordWrapping
        return tv
    }
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = self.text
    }
}

struct CommentView: View {
    var comment: Comment

    var body: some View {
//        Text lines do not wrap as intended
//        MultilineTextView(text: "\(comment.text)\n\n\(comment.by) \(comment.timeAgo.lowercased())")
//            .padding(10)
        Text(verbatim: "\(comment.text)\n\n\(comment.by) \(comment.timeAgo.lowercased())")
            .font(.custom("Lato-Regular", size: 16))
            .foregroundColor(Color("titleColor"))
            .padding(15)
    }
}

struct CommentsView : View {
    @ObservedObject var fc: FeedController
    var story: Story

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 5) {
                Text(story.title)
                    .font(.custom("Lato-Bold", size: 18))
                    .bold()
                    .foregroundColor(Color("titleColor"))
                    .padding(.bottom, 3)
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text("\(story.timeAgo)")
                            .font(.custom("Lato-Regular", size: 15))
                            .foregroundColor(Color("subtitleColor"))
                            .lineLimit(1)
                        Text("\(story.score) points")
                            .font(.custom("Lato-Regular", size: 15))
                            .foregroundColor(Color("subtitleColor"))
                            .lineLimit(1)
                        Text("By \(story.by)")
                            .font(.custom("Lato-Regular", size: 15))
                            .foregroundColor(Color("subtitleColor"))
                            .lineLimit(1)
                    }
                }
            }
            .padding(EdgeInsets(top: 30, leading: 30, bottom: 0, trailing: 30))
            List(fc.comments) { comment in
                CommentView(comment: comment)
            }
            .onAppear {
                self.fc.loadComments(story: self.story)
            }
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
    }
}
