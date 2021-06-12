//
//  BreakTimerViewController.swift
//  FlashCards_Remade
//
//  Created by Gavin Woffinden on 6/11/21.
//

import UIKit

class BreakTimerViewController: UIViewController {
    static let shared = BreakTimerViewController()
    @IBOutlet weak var breakTimer: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        PostFeedViewController.breakDate = Date()
        PostFeedViewController.breakDate =  PostFeedViewController.breakDate.addingTimeInterval(breakTimer.countDownDuration)
        
        print("button works")
        print( PostFeedViewController.currentDate)
        print( PostFeedViewController.breakDate)
        
    }
}
