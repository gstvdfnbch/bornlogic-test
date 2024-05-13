import Foundation

class APIService {
    //Desing Pattern: Singleton
    static let shared = APIService()
    
    private let apiKey = "2158da211e0a4346a947b115622d7e6c"
    private let baseURL = "https://newsapi.org/v2/"
    
    private init() {}
    
    func fetchAllArticles(completion: @escaping ([Article]?, Error?) -> Void) {
        //Choose all articles about apple
        guard let url = URL(string: "\(baseURL)everything?q=apple&apiKey=\(apiKey)") else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            //Verification if some error happends
            if let error = error {
                completion(nil, error)
                return
            }
            
            //Verification if received some data
            guard let data = data else {
                completion(nil, NSError(domain: "No data received", code: 0, userInfo: nil))
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Received JSON: \(jsonString)")
            } else {
                print("Failed to convert data to string")
            }
            
            //Decode the data as ModelsData
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
