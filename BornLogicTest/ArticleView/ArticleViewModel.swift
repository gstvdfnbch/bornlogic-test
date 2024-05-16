import Foundation

class ArticleViewModel {
    private let articlesAPIService: APIService = APIService.shared
    
    var articles: [Article] = []
    var isDone: Bool = false
    
    func fetchArticles(completion: @escaping (Error?) -> Void) {
        articlesAPIService.fetchAllArticles { [weak self] articles, error in
            guard let self = self else { return }
            if let error = error {
                completion(error)
            } else if let articles = articles {
                self.articles = articles
                self.isDone = true
                completion(nil)
            }
        }
    }
}
