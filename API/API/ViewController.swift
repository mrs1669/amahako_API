//
//  ViewController.swift
//  API
//
//  Created by Takumi Muraishi on 2019/07/01.
//  Copyright © 2019 Takumi Muraishi. All rights reserved.
//

import UIKit

struct Article: Codable {
    var owner: Owner
    
    struct Owner: Codable{
        var login: String
        var avatar_url: String
    }
}




struct Git {
    
    static func fetchArticle(completion: @escaping ([Article]) -> Swift.Void) {
        
        let url = "https://api.github.com/repositories?since=192290297"
        
        guard let urlComponents = URLComponents(string: url) else {
            return
        }
        
    
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
            
            guard let jsonData = data else {
                return
            }
            do {
                let articles = try JSONDecoder().decode([Article].self, from: jsonData)
                completion(articles)
            } catch {
                print("ohohohohojohjo")
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}


class ViewController: UIViewController{
    
    private var tableView = UITableView()
    fileprivate var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView: do {
            tableView.frame = view.frame
            tableView.dataSource = self
            view.addSubview(tableView)
        }
        
        Git.fetchArticle(completion: { (articles) in
            self.articles = articles
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let article = articles[indexPath.row]
        cell.textLabel?.text = article.owner.avatar_url
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
}
