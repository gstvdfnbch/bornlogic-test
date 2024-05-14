import UIKit

class DetailViewController: UIViewController {
    var viewModel = DetailViewModel()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let publishedAtLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
         let activityIndicator = UIActivityIndicatorView(style: .gray)
         activityIndicator.translatesAutoresizingMaskIntoConstraints = false
         activityIndicator.hidesWhenStopped = true
         return activityIndicator
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Details"
        view.backgroundColor = UIColor.white

        navigationItem.largeTitleDisplayMode = .never

        setupUI()
        
        updateUI()
    }
    
    func setupUI() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(imageView)
        scrollView.addSubview(publishedAtLabel)
        scrollView.addSubview(contentLabel)
        scrollView.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalToConstant: viewModel.article?.urlToImage != nil ? 200 : 0) // To hide the image
        ])
        
        NSLayoutConstraint.activate([
            publishedAtLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            publishedAtLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            publishedAtLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
        
        // Constraints for content label
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: publishedAtLabel.bottomAnchor, constant: 8),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            contentLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
    
    func updateUI() {
        guard let article = viewModel.article else {
            return
        }
        
        if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
            activityIndicator.startAnimating()
            imageView.load(url: url) { [weak self] success in
                self?.activityIndicator.stopAnimating()
            }
        }
        
        publishedAtLabel.text = article.publishedAt.formatDateString()
        
        contentLabel.text = article.description
    }
}
