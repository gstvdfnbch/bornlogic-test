import UIKit

class DetailViewController: UIViewController {
    var viewModel = DetailViewModel()
    
    // ScrollView for containing all UI elements
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // Image view for displaying the image
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Label for displaying the published date
    let publishedAtLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    // Label for displaying the content
    let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0 // Allows multiple lines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
         let activityIndicator = UIActivityIndicatorView(style: .gray)
         activityIndicator.translatesAutoresizingMaskIntoConstraints = false
         activityIndicator.hidesWhenStopped = true // Hide when not animating
         return activityIndicator
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Details"
        view.backgroundColor = UIColor.white

        navigationItem.largeTitleDisplayMode = .never

        // Set up UI elements
        setupUI()
        
        // Update UI with article data
        updateUI()
    }
    
    func setupUI() {
        // Add scrollView to the view
        view.addSubview(scrollView)
        
        // Add subviews to the scrollView
        scrollView.addSubview(imageView)
        scrollView.addSubview(publishedAtLabel)
        scrollView.addSubview(contentLabel)
        scrollView.addSubview(activityIndicator) // Add activity indicator

        // Constraints for scrollView
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Constraints for image view
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalToConstant: viewModel.article?.urlToImage != nil ? 200 : 0) // Set your desired height here
        ])
        
        // Constraints for published date label
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
        
        // Update image view with URL
//        if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
//            imageView.load(url: url)
//        }
        
        if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
            activityIndicator.startAnimating() // Start animating activity indicator
            imageView.load(url: url) { [weak self] success in
                self?.activityIndicator.stopAnimating() // Stop animating activity indicator when image loading is complete
            }
        }
        
        // Update published date label
        publishedAtLabel.text = article.publishedAt.formatDateString()
        
        // Update content label
        contentLabel.text = article.description
    }
}
