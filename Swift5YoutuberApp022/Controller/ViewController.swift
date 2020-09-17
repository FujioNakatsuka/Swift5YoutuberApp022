//
//  ViewController.swift
//  Swift5YoutuberApp022
//
//  Created by 中塚富士雄 on 2020/09/17.
//  Copyright © 2020 中塚富士雄. All rights reserved.
//

import UIKit
import SegementSlide


class ViewController: SegementSlideDefaultViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadData()
        //どのタグから始めるかを指定する。
        defaultSelectedIndex = 0
        
    }
    override func segementSlideHeaderView() -> UIView? {
        let headerView = UIImageView()
        headerView.isUserInteractionEnabled = true
        headerView.contentMode = .scaleAspectFill
        headerView.image = UIImage(named: "header")
        headerView.translatesAutoresizingMaskIntoConstraints = false
        let headerHeight: CGFloat
        if #available(iOS 11.0, *){
            
            headerHeight = view.bounds.height/4+view.safeAreaInsets.top
            
        }else{
            
            headerHeight = view.bounds.height/4+topLayoutGuide.length
            
        }
        //✨isActiveがfalseだったらどうなる❓：試してみよう❗️
        headerView.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
        return headerView
    }

    override var titlesInSwitcher: [String]{
        
        return ["介護保険","障害者福祉","児童福祉","多職種連携","市民後見人","新型コロナウイルス対策"]
//        return ["乃木坂46","欅坂46","日向坂46","twice","iz*One","rocket girls 101"]
    }
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        
        switch index {
        case 0:
            return Page1ViewController()
        case 1:
            return Page2ViewController()
        case 2:
            return Page3ViewController()
        case 3:
            return Page4ViewController()
        case 4:
            return Page5ViewController()
        case 5:
            return Page6ViewController()
            
   
        default:
            return Page1ViewController()
        }
        
        
    }
    
}

