import UIKit

class DetailViewController: UIViewController {
    var viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Details"
        view.backgroundColor = UIColor.white

        navigationItem.largeTitleDisplayMode = .never

        if let article = viewModel.article {
//            navigationItem.title = article.title
        }

    }
}
