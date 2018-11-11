//
//  ViewController.swift
//  grower
//
//  Created by Diheng Qu on 11/9/18.
//  Copyright © 2018 Diheng Qu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIDropInteractionDelegate {

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
            boxView.addInteraction(UIDropInteraction(delegate: self))
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
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self) && boxView.lidOpen
    }
    
    func dropInteraction(_ interaction: UIDropInteraction,
                         sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        print("Drop has happend")
        
        
        session.loadObjects(ofClass: NSString.self) { [unowned self] plants in
            if let plant = plants.first as? String{
                print("Dropped\(plant)")
                self.boxView.plantInBox = Plant(rawValue: plant)
            }
            
        }
    }
}
