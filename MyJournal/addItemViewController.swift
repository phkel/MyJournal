//
//  addItemViewController.swift
//  MyJournal
//
//  Created by Kertu Kipper on 15/03/2019.
//  Copyright © 2019 Kertu Kipper. All rights reserved.
//

//  Trying out Farhan Syed Real World Example: Creating a Journal Entry App with Core Data in Swift Part 1.
//  Link: https://medium.com/ios-os-x-development/real-world-example-creating-a-journal-entry-app-with-core-data-in-swift-part-1-f77156a64497
//  ❤️

import UIKit

class addItemViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var itemEntryTextView: UITextView?
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveContact(_ sender: Any) {
        
        guard let enteredText = itemEntryTextView?.text else {
            return
        }
        
        if enteredText.isEmpty || itemEntryTextView?.text == "Type anything..."{
            print("No Data")
            
            let alert = UIAlertController(title: "Please Type Something", message: "Your entry was left blank.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default) { action in
                
            })
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            guard let entryText = itemEntryTextView?.text else {
                return
            }
            
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let newEntry = Item(context: context)
            newEntry.name = entryText
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemEntryTextView?.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.black
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
