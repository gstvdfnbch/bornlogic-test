import UIKit

extension UIImageView {
    func load(url: URL, completion: ((Bool) -> Void)? = nil) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion?(false)
                }
                return
            }
            
            guard let data = data else {
                print("No data received for image")
                DispatchQueue.main.async {
                    completion?(false)
                }
                return
            }
            
            guard let image = UIImage(data: data) else {
                print("Unable to create image from data")
                DispatchQueue.main.async {
                    completion?(false)
                }
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
                completion?(true)
            }
        }.resume()
    }
}
