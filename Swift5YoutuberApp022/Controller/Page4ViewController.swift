//
//  Page4ViewController.swift
//  Swift5YoutuberApp022
//
//  Created by 中塚富士雄 on 2020/09/17.
//  Copyright © 2020 中塚富士雄. All rights reserved.
//

import UIKit
import SegementSlide
import Alamofire
import SwiftyJSON
import SDWebImage

//✨TableViewControllerを使うのに、SubclassをUIViewControllerにした理由は何か❓
class Page4ViewController: UITableViewController,SegementSlideContentScrollViewDelegate {
    
    //TableViewのdelegateMethod,YoutubeDataクラスを初期化する
    var youtubeData = YoutubeData()
    
    var videoIdArray = [String]()
//    var publishedAtArray = [String]()
    var titleArray = [String]()
    var imageURLStringArray = [String]()
    var youtubeURLArray = [String]()
    var channelTitleArray = [String]()

//    let refresh = UIRefreshControl()
    @objc let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //✨引っ張って❓更新した時に呼ばれるメソッドとリフレッシュする動作,Page2以降では不要なのか？
        tableView.refreshControl = refresh
//        refresh.addTarget(self, action: #selector(update), for: .valueChanged)
        refresh.addTarget(self, action: #selector(getter: refresh), for: .valueChanged)
        getData()
        tableView.reloadData()
   
         }
   
                
    @objc var scrollView: UIScrollView{
        
        return tableView
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.selectionStyle = .none
        let profileImageURL = URL(string: self.imageURLStringArray[indexPath.row] as String)!
//        cell.imageView?.sd_setImage(with: profileImageURL, completed: nil)
        
        cell.imageView?.sd_setImage(with: profileImageURL, completed: { (image, error, _, _) in
            
            if error == nil{
                
                //✨UIViewに「再描画が必要」というフラグを設定する。
                cell.setNeedsLayout()
                
            }
            
            
        })
        
        cell.textLabel!.text = self.titleArray[indexPath.row]
        //cell.detailTextLabel!.text = self.publishedArray[indexPath.row]
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.numberOfLines = 5
        cell.detailTextLabel?.numberOfLines = 5
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/5
    }
    
    func getData(){
        
        let text = "https://www.googleapis.com/youtube/v3/search?key=AIzaSyC7-ZBjqNeIsDGAtSCcT6Mjv978G5eD7Z4&q=多職種連携&part=snippet&maxResults=19&order=date"
       
//        let text = "https://www.googleapis.com/youtube/v3/search?key=AIzaSyCRt90CS6GfUttMqx8FdqW6YAG1tH2BLIE&q=twice&part=snippet&maxResults=19&order=date"
//
//
        //Alamofireに検索ワードを入れる時に日本語を変換
        let url = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        //✨リクエストを送信,responseとresponceが並存なぜか❓
        AF.request( url, method:.get , parameters: nil, encoding: JSONEncoding.default).responseJSON{(responce)in
            
            //JSON解析
            //20個の値が返るのでfor文で全て配列に入れる
              print(responce)
           
            switch responce.result{
                
            case .success:
                
            for i in 0...19{
                
                let json:JSON = JSON(responce.data as Any)
                
                var kind = json["items"][i]["id"]["kind"].string

                kind = String(kind!.dropFirst(8))

                var videoId = String()

                if kind == "video"{

                              videoId = json["items"][i]["id"]["videoId"].string!

                                     }else{   }

                                     let title = json["items"][i]["snippet"]["title"].string

                                     let imageURLString = json["items"][i]["snippet"]["thumbnails"]["default"]["url"].string

                                     let youtubeURL = "https://www.youtube.com/watch?v=\(videoId)"

                                     let channelTitle = json["items"][i]["snippet"]["channelTitle"].string

                                     

                                     self.videoIdArray.append(videoId)

                                     self.titleArray.append(title!)

                                     self.imageURLStringArray.append(imageURLString!)

                                     self.channelTitleArray.append(channelTitle!)

                                     self.youtubeURLArray.append(youtubeURL)

                                     }

                                 //✨このbreakはなぜ必要か❓

                                 break

                                 case .failure(let error):print(error)

                                 break

                                 }

                 self.tableView.reloadData()

             }
            
             
         }
         

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexNumber = indexPath.row
        let webViewController = WebViewController()
        let url = youtubeURLArray[indexNumber]
        UserDefaults.standard.set(url, forKey: "url")
        present(webViewController, animated: true, completion: nil)
        
    
    }
    
    
    
    
    
}

