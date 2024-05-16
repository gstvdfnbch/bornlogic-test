import Foundation
import UIKit

class DetailViewModel {
    var article: Article?
    
    @objc func visitWebsiteButtonTapped() {
        guard let article = article, let url = URL(string: article.url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
