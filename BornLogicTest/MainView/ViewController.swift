import UIKit

class ViewController: UIViewController {
    
    let articleViewModel = ArticleViewModel() // Instantiate ArticleViewModel
    
    // Add a table view property
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Make the register from a tableviewcell
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleCell")

        //Add the table view to view
        view.addSubview(tableView)
        
        //Configure constraints for the table view
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Set table view delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
        
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

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleViewModel.articles.count // Number of articles
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
        let article = articleViewModel.articles[indexPath.row]
        cell.configure(with: article) // Configure cell with article data
        return cell
    }
}
