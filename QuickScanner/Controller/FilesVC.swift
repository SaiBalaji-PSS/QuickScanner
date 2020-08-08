//
//  FilesVC.swift
//  QuickScanner
//
//  Created by Sai Balaji on 08/08/20.
//  Copyright © 2020 Sai Balaji. All rights reserved.
//

import UIKit
import CoreData

class FilesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
   

    @IBOutlet weak var filesTV: UITableView!
    
    var p: String!
    
    var fileNamearray = [DocName]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.prefersLargeTitles = true
      
        
        filesTV.delegate = self
        filesTV.dataSource = self

      
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        let mc = appdelObj.persistentContainer.viewContext
        
        let fetchreq = NSFetchRequest<DocName>(entityName: "DocName")
        
        
        do{
            fileNamearray = try mc.fetch(fetchreq)
            self.filesTV.reloadData()
        }
        
        catch
        {
            print(error.localizedDescription)
        }
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileNamearray.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        if let c = tableView.dequeueReusableCell(withIdentifier: "dcell")
        {
            c.textLabel?.text = fileNamearray[indexPath.row].fileName!
            
            return c
        }
        
        
        return UITableViewCell()
           
        
       }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        p = fileNamearray[indexPath.row].filePath!
        performSegue(withIdentifier: "segue", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationVC = segue.destination as? PreviewVC
        {
            destinationVC.filePath = self.p
        }
        
    }
       

}
