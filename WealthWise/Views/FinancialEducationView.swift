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
            List(articles) { article in
                NavigationLink(destination: ArticleWebView(url: article.url)) {
                    Text(article.title)
                }
            }
            .onAppear {
                fetchArticles()
            }
            .navigationBarTitle("Éducation Financière")
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

struct ArticlesResponse: Codable {
    let articles: [Article]
}

struct ArticleWebView: View {
    let url: String

    var body: some View {
        WebView(urlString: url)
    }
}

struct FinancialEducationView_Previews: PreviewProvider {
    static var previews: some View {
        FinancialEducationView()
    }
}
