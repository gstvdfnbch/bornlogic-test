import UIKit

class ArticleTableViewCell: UITableViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0 //To allows mutiples lines
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            // Restrições para o titleLabel
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with article: Article) {
        titleLabel.text = article.title
    }
}
