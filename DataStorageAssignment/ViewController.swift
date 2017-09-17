//
//  ViewController.swift
//  DataStorageAssignment
//
//  Created by Sindhya on 9/11/17.
//  Copyright © 2017 SJSU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textBookName: UITextField!
    @IBOutlet weak var textAuthorName: UITextField!
    @IBOutlet weak var textDesc: UITextView!
    
    let filemgr = FileManager.default
    let tempDirURL = URL(fileURLWithPath: NSTemporaryDirectory())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let color = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
        textDesc.layer.borderColor = color
        textDesc.layer.borderWidth = 0.5
        textDesc.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveFileStorage(_ sender: Any) {
        
        let filePath = createNewFile(fileName: "File1_FileManager.txt")
        print(filePath.path)
        writeFile_FileManager(fileUrl: filePath,fileContent: getFileContent())
        
    
    }
    
    @IBAction func saveFileArchives(_ sender: Any) {
        
        let filePath = createNewFile(fileName: "File1_FileArchive.txt")
        print(filePath.path)
        writeFile_FileArchiver(fileUrl:filePath,fileContent:getFileContent())
        
    }
    
    func createNewFile(fileName: String)-> URL{
        let directory = tempDirURL.appendingPathComponent("data")
        
        do {
            try filemgr.createDirectory(atPath: directory.path,
                                        withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
        let filePath = tempDirURL.appendingPathComponent("data").appendingPathComponent(fileName)
        
        filemgr.createFile(atPath: filePath.path, contents: nil, attributes: nil)
        
        return filePath
    }
    
    func getFileContent() -> String {
        let arr = [textBookName.text!,textAuthorName.text!,textDesc.text!] as [String]
        return arr.joined(separator: ",")
    }
    
    func writeFile_FileArchiver(fileUrl:URL,fileContent:String)
    {
        NSKeyedArchiver.archiveRootObject(fileContent, toFile: fileUrl.path)
        self.showAlert(title: "File Storage", message: "Data Saved Successfully")
    }
    
    func writeFile_FileManager(fileUrl:URL,fileContent: String)
    {
        do{
        try fileContent.write(to:fileUrl, atomically: false, encoding: .utf8)
        }catch{
            print("Error writing to file:", fileUrl, error)
        }
        self.showAlert(title: "File Storage", message: "Data Saved Successfully")
    }
    
    func showAlert(title:NSString,message:NSString)
    {
        let alertController:UIAlertController=UIAlertController(title:title as String, message: message as String as String, preferredStyle: UIAlertControllerStyle.alert)
        let successAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
        }
        alertController.addAction(successAction)
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

