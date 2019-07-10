//
//  ViewController.swift
//  API
//
//  Created by Takumi Muraishi on 2019/07/01.
//  Copyright © 2019 Takumi Muraishi. All rights reserved.
//

import UIKit

struct Article: Codable {
    
    var studentNumber: String
    var name: String
    //var owner: Owner
    
   // struct Owner: Codable{
   //     var login: String
   //     var avatar_url: String
   // }
}




struct Git {
    
    static func fetchArticle(completion: @escaping ([Article]) -> Swift.Void) {
        
        let url = "http://mrs1669.html.xdomain.jp/test.json"
        
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

/*
extension UIImageView {
    
    func downloadImage(from url: String) {
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            
            if error != nil {
                print(error as Any)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}
*/

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let article = articles[indexPath.row]
        cell.detailTextLabel?.text = article.studentNumber
        cell.textLabel?.text = article.name
        cell.accessoryType         = UITableViewCell.AccessoryType.detailDisclosureButton
        //cell.imageView?.image      = UIImage(named: "wai.jpeg")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    // アクセサリーボタンをタップした時の処理
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        // 選択された駅名
        //let article = articles[indexPath.row]
        
        // アラートを作成
        let alert = UIAlertController(title: "もしかして", message: "駅に興味があるんですか！？", preferredStyle: .alert)
        let buttonYes = UIAlertAction(title: "めっちゃあります！", style: .default, handler: nil)
        let buttonNo = UIAlertAction(title: "さっぱりないです", style: .destructive, handler: nil)
        alert.addAction(buttonYes)
        alert.addAction(buttonNo)
        
        // アラートを表示
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルを非選択状態にする
        //table.deselectRow(at: indexPath, animated: true)
        
        // 選択された駅名
        //let station = articles[indexPath.row]
        
        // アラートを作成
        let alert = UIAlertController(title: "駅", message: "千歳線の駅です。", preferredStyle: .alert)
        let buttonOk = UIAlertAction(title: "了解", style: .default, handler: nil)
        alert.addAction(buttonOk)
        
        // アラートを表示
        present(alert, animated: true, completion: nil)
    }
}
