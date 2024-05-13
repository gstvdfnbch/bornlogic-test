import Foundation

class ArticleViewModel {
    private let newsAPIService: APIService = APIService.shared
    
    //Array data
    var articles: [Article] = []
    
    //Flag to make sure that the fetch is done
    var fetchCompleted: Bool = false
    
    //Make the fetch when the class has created
    init() {
    }
    
    //Function to make the fetch and indicates when is done
    func fetchArticles(completion: @escaping (Error?) -> Void) {
        newsAPIService.fetchAllArticles { [weak self] articles, error in
            guard let self = self else { return }
            if let error = error {
                completion(error)
            } else if let articles = articles {
                self.articles = articles
                self.fetchCompleted = true //Fetch is done
                completion(nil)
            }
        }
    }
}
