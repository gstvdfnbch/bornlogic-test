import Foundation

class NewsAPIService {
    static let shared = NewsAPIService()
    
    private let apiKey = "2158da211e0a4346a947b115622d7e6c"
    private let baseURL = "https://newsapi.org/v2/"
    
    private init() {}
    
    func fetchAllArticles(completion: @escaping ([Article]?, Error?) -> Void) {
        guard let url = URL(string: "\(baseURL)everything?q=apple&apiKey=\(apiKey)") else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "No data received", code: 0, userInfo: nil))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let newsResponse = try decoder.decode(NewsResponse.self, from: data)
                completion(newsResponse.articles, nil)
            } catch {
                completion(nil, error)
            }
            
        }.resume()
    }
}
