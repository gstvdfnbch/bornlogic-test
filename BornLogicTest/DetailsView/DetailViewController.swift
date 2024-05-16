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
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let publishedAtLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
         let activityIndicator = UIActivityIndicatorView()
         activityIndicator.translatesAutoresizingMaskIntoConstraints = false
         activityIndicator.hidesWhenStopped = true
         return activityIndicator
     }()
    
    let visitWebsiteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Visit Website", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 16
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Details"
        view.backgroundColor = UIColor.white

        navigationItem.largeTitleDisplayMode = .never

        setupUI()
        
        updateUI()
        
        visitWebsiteButton.addTarget(viewModel, action: #selector(viewModel.visitWebsiteButtonTapped), for: .touchUpInside)
    }
    
    func setupUI() {
        view.addSubview(scrollView)
        
        let imageContainer = UIView()
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageContainer)
        imageContainer.addSubview(imageView) // Adiciona a imageView ao imageContainer
        
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(publishedAtLabel)
        scrollView.addSubview(contentLabel)
        scrollView.addSubview(visitWebsiteButton)
        scrollView.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageContainer.heightAnchor.constraint(equalToConstant: 200) // Ajusta conforme necessário
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: -16.0)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            publishedAtLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            publishedAtLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            publishedAtLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: publishedAtLabel.bottomAnchor, constant: 8),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            visitWebsiteButton.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 24),
            visitWebsiteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            visitWebsiteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            visitWebsiteButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8),
            visitWebsiteButton.heightAnchor.constraint(equalToConstant: 50) // Ajusta conforme necessário
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
        
        titleLabel.text = article.title // Set titleLabel text
        
        publishedAtLabel.text = article.publishedAt.formatDateString()
        
        contentLabel.text = article.content?.removingPattern()
    }
}
