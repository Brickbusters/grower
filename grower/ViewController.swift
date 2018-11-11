//
//  ViewController.swift
//  grower
//
//  Created by Diheng Qu on 11/9/18.
//  Copyright © 2018 Diheng Qu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBOutlet weak var shelvesView: ShelvesView! {
        didSet {
            let kaleImage = filterBlueBackground(UIImage(named: "Kale.jpg")!)
            let bbImage = filterBlueBackground(UIImage(named: "Blueberry.jpg")!)
            
            shelvesView.kaleImage = kaleImage
            shelvesView.blueberryImage = bbImage
        }
    }
    
    @IBOutlet weak var boxView: BoxView! {
        didSet {
            let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(openCloseBox))
            upSwipe.direction = .up
            let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(openCloseBox))
            downSwipe.direction = .down
            boxView.addGestureRecognizer(upSwipe)
            boxView.addGestureRecognizer(downSwipe)
        }
    }
    
    @IBOutlet weak var monitorView: MonitorView!
    @IBOutlet weak var playView: PlayView!
    
    @objc func openCloseBox(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .up:
            boxView.lidOpen = true
        case .down:
            boxView.lidOpen = false
        default:
            break
        }
    }
}

