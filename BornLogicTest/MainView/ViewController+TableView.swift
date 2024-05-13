import UIKit

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleViewModel.articles.count // Number of articles
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
        let article = articleViewModel.articles[indexPath.row]
        cell.configure(with: article) // Configure cell with article data
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = articleViewModel.articles[indexPath.row]
        
        let articleDetailViewController = DetailViewController()
        
        let articleDetailViewModel = DetailViewModel()
        articleDetailViewModel.article = selectedArticle
        
        articleDetailViewController.viewModel = articleDetailViewModel
        navigationController?.pushViewController(articleDetailViewController, animated: true)
    }
}
