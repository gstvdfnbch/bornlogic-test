import UIKit

class DetailViewController: UIViewController {
    var viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let article = viewModel.article {
            navigationItem.title = article.title
        }
    }
}
