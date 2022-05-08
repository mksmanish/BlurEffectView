//
//  ViewController.swift
//  SEffect
//
//  Created by Tradesocio on 08/05/22.
//

import UIKit
import Kingfisher

class FeedsController: UIViewController {
    
    @IBOutlet weak var tblfeedsData: UITableView!
    var dataValues = [Meme]()
    var dataVal = [Meme]()
    let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tblfeedsData.register(UINib(nibName: "FeedsTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedsTableViewCell")
        self.tblfeedsData.delegate = self
        self.tblfeedsData.dataSource = self
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        tblfeedsData.addSubview(refreshControl)
        fetchdata()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tblfeedsData.setContentOffset(CGPoint(x: 0, y: -tblfeedsData.contentInset.top), animated: false)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        // Code to refresh table view
        refreshControl.beginRefreshing()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if self.dataValues.isEmpty {
                self.dataValues = self.dataVal
                self.tblfeedsData.reloadData()
            }
            self.refreshControl.endRefreshing()
        }
    }
    
    func fetchdata() {
        
        let url = URL(string: "https://api.imgflip.com/get_memes")
        guard let mainUrl = url else {return}
        ActivityLoader.shared.showloader(view: view)
        URLSession.shared.dataTask(with: mainUrl) { data, responseStatus, error in
            if error == nil && data != nil {
                do{
                    let decoder =  try JSONDecoder().decode(Memedata.self, from: data!)
                    self.dataValues = (decoder.data?.memes!)!
                    self.dataVal = self.dataValues
                    ActivityLoader.shared.hideloader()
                    DispatchQueue.main.async {
                        self.tblfeedsData.reloadData()
                    }
                }catch(let error){
                    print(error.localizedDescription)
                }
            }else{
                print("error")
            }
            
        }.resume()
        
    }
    
}
extension FeedsController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblfeedsData.dequeueReusableCell(withIdentifier: "FeedsTableViewCell", for: indexPath) as! FeedsTableViewCell
        let model = dataValues[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
}

