//
//  FinancialEducationView.swift
//  WealthWise
//
//  Created by marhuenda joris on 03/09/2023.
//

import SwiftUI
import Alamofire

struct Article: Identifiable, Codable {
    let id = UUID()
    let title: String
    let description: String
    let url: String
}

struct FinancialEducationView: View {
    @State private var articles: [Article] = []
    let apiKey = "e7d8feb132d94c2793de471ec17caa36"

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(articles) { article in
                    NavigationLink(destination: ArticleWebView(url: article.url)) {
                        ArticleCardView(article: article)
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.top, 20)
            .onAppear {
                fetchArticles()
            }
            .navigationBarTitle("Éducation Financière", displayMode: .inline)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
    }

    func fetchArticles() {
        AF.request("https://newsapi.org/v2/everything?q=finance&apiKey=\(apiKey)")
            .responseDecodable(of: ArticlesResponse.self) { response in
                if let articles = response.value?.articles {
                    self.articles = articles
                }
            }
    }
}

struct ArticleCardView: View {
    let article: Article

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(article.title)
                .font(.headline)
                .foregroundColor(.blue)
                .multilineTextAlignment(.leading)
            
            Text(article.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
    }
}

struct ArticlesResponse: Codable {
    let articles: [Article]
}

struct ArticleWebView: View {
    let url: String

    var body: some View {
        WebView(urlString: url)
            .navigationBarTitle("Article", displayMode: .inline)
    }
}

struct FinancialEducationView_Previews: PreviewProvider {
    static var previews: some View {
        FinancialEducationView()
    }
}
