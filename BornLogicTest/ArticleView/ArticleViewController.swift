import UIKit

class ArticleViewController: UIViewController {
    
    let articleViewModel = ArticleViewModel() // Instantiate ArticleViewModel
    
    // Add a table view property
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Apple articles"
        
        navigationController?.navigationBar.prefersLargeTitles = true

        //Make the register for the cell component for the table View
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleCell")

        //Add the tablaBiew to view
        view.addSubview(tableView)
        
        //Constraints for the table view
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Set table view delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)

        // Fetch articles
        articleViewModel.fetchArticles { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching articles: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData() // Reload table view when articles are fetched
                }
            }
        }
    }
}

