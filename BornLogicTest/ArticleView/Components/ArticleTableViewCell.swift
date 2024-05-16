import UIKit

class ArticleTableViewCell: UITableViewCell {
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10 // Corner radius
        view.layer.masksToBounds = true // Clip to bounds
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3 // Permite várias linhas para exibir o texto completo
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let overlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0.0).cgColor, UIColor.black.withAlphaComponent(0.80).cgColor, UIColor.black.withAlphaComponent(0.90).cgColor]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 1000, height: 200)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add containerView to cell
        addSubview(containerView)
        
        containerView.addSubview(articleImageView)
        articleImageView.addSubview(overlayView) // Adiciona a camada branca como uma subview da articleImageView
        containerView.addSubview(titleLabel)
        containerView.addSubview(authorLabel) // Adiciona authorLabel ao containerView
        containerView.addSubview(descriptionLabel)
        
        // Set background color to clear to make the image visible
        backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            // Constraints for the containerView
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            // Constraints for the articleImageView
            articleImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            articleImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            articleImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            articleImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            // Constraints for the authorLabel
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            // Constraints for the titleLabel
            authorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8), // Align below authorLabel
            
            // Constraints for the descriptionLabel
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16), // Alinhar a parte inferior com a parte inferior do containerView
        ])
        
        // Send titleLabel and descriptionLabel to the front
        containerView.bringSubviewToFront(titleLabel)
        containerView.bringSubviewToFront(descriptionLabel)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with article: Article) {
        titleLabel.text = article.title
        authorLabel.text = article.author // Set author text
        descriptionLabel.text = article.description
        
        // Load image asynchronously
        if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self, let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.articleImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
