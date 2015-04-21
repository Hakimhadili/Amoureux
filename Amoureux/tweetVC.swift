//
//  tweetVC.swift
//  twitterApp
//
//  Created by Valsamis Elmaliotis on 3/10/15.
//  Copyright (c) 2015 Valsamis Elmaliotis. All rights reserved.
//

import UIKit

class tweetVC: UIViewController, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var messageTxt: UITextView!
    @IBOutlet weak var charsLbl: UILabel!
    @IBOutlet weak var tweetBtn: UIButton!
    @IBOutlet weak var addPhotoBtn: UIButton!
    @IBOutlet weak var tweetImg: UIImageView!
    
    var hasImage = false
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        cancelBtn.center = CGPointMake(36, 50)
        messageTxt.frame = CGRectMake(5, 65, theWidth-10, 78)
        charsLbl.frame = CGRectMake(10, 150, 100, 30)
        tweetBtn.center = CGPointMake(theWidth-40, 170)
        addPhotoBtn.center = CGPointMake(46, 210)
        tweetImg.frame = CGRectMake(5, 226, theWidth-10, theWidth-10)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelBtn_click(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func textViewDidChange(textView: UITextView) {
        
        var len = messageTxt.text.utf16Count
        var diff = 90 - len
        
        if diff < 0 {
            
            charsLbl.textColor = UIColor.redColor()
        } else {
            
            charsLbl.textColor = UIColor.blackColor()
        }
        
        charsLbl.text = "\(diff) chars left"
        
    }
    
    
    @IBAction func tweetBtn_click(sender: AnyObject) {
        
        var theTweet = messageTxt.text
        var len = messageTxt.text.utf16Count
        
        if len > 90 {
            
            theTweet = theTweet.substringToIndex(advance(theTweet.startIndex, 90))
            
        }
        
        var tweetObj = PFObject(className: "tweets")
        
        tweetObj["userName"] = PFUser.currentUser().username
        tweetObj["profileName"] = PFUser.currentUser().valueForKey("profileName") as String
        tweetObj["photo"] = PFUser.currentUser().valueForKey("photo") as PFFile
        tweetObj["tweet"] = theTweet
        
        if hasImage == true {
            
            tweetObj["hasImage"] = "yes"
            
            let imageData = UIImagePNGRepresentation(self.tweetImg.image)
            let imageFile = PFFile(name: "tweetPhoto.png", data: imageData)
            tweetObj["tweetImage"] = imageFile
            
        } else {
            
            tweetObj["hasImage"] = "no"
            
        }
        
        
        tweetObj.save()
        
        println("tweet!")
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        let theInfo:NSDictionary = info as NSDictionary
        
        let image:UIImage = theInfo.objectForKey(UIImagePickerControllerEditedImage) as UIImage
        tweetImg.image = image
        
        hasImage = true
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    @IBAction func addPhotoBtn_click(sender: AnyObject) {
        
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = true
        
        self.presentViewController(image, animated: true, completion: nil)
        
    }
    

}