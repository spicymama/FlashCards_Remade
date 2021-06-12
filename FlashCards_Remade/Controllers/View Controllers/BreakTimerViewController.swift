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
        PostTableViewController.breakDate = Date()
        PostTableViewController.breakDate =  PostTableViewController.breakDate.addingTimeInterval(breakTimer.countDownDuration)
      
       print("button works")
        print( PostTableViewController.currentDate)
        print( PostTableViewController.breakDate)
       
    }
    
   
}
