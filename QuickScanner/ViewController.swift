//
//  ViewController.swift
//  QuickScanner
//
//  Created by Sai Balaji on 05/08/20.
//  Copyright © 2020 Sai Balaji. All rights reserved.
//

import UIKit
import WeScan
import PDFKit
import CoreData

var appdelObj = UIApplication.shared.delegate as! AppDelegate
class NewDocumentVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,ImageScannerControllerDelegate


{
   
    
   
    @IBOutlet weak var sbtn: UIBarButtonItem!
    let scannerVC = ImageScannerController()
    var dthumbnails = [UIImage]()
    var dtname = [String]()

    @IBOutlet weak var documentcollectionview: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        documentcollectionview.delegate = self
        documentcollectionview.dataSource = self
        scannerVC.imageScannerDelegate = self
        
        
        
         
        
    }

    @IBAction func scanbtn(_ sender: Any) {
        
        
        present(scannerVC, animated: true, completion: nil)
     
       
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    @IBAction func savebtn(_ sender: Any) {
        
        
        let alertc = UIAlertController(title: "Enter the file name", message: nil, preferredStyle: .alert)
        
        alertc.addTextField(configurationHandler: .none)
        
        alertc.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        let fnameaction = UIAlertAction(title: "Save", style: .default) { (UIAlertAction) in
            
            self.savePDF(fileName: alertc.textFields!.first!.text!)
            
        }
        
        alertc.addAction(fnameaction)
        
        
      present(alertc, animated: true, completion: nil)
        
       
        
        
        
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let ac = UIAlertController(title: "Info", message: nil, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: { (action) in
            
            
            self.dthumbnails.remove(at: indexPath.row)
            self.dtname.remove(at: indexPath.row)
            
            self.documentcollectionview.reloadData()
            
            
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        present(ac, animated: true, completion: nil)
        
    }
    
    
    func savePDF(fileName: String)
    {
       
             
         
         
         
        let pdfDocs = PDFDocument()
         
         
         var j = 0
         
             for i in self.dthumbnails
         {
             
             let page = PDFPage(image: i)
             
             pdfDocs.insert(page!,at:j)
             
             j += 1
             
         }
         
         j = 0
         
         let pdfdata = pdfDocs.dataRepresentation()
         
         let docdir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
         
            let filename = "\(fileName).pdf"
         
         let filepath = docdir.appendingPathComponent(filename)
         
         
         try! pdfdata!.write(to: filepath)
            
            
        print(filepath.absoluteString)
            
            
            let managedContext = appdelObj.persistentContainer.viewContext
            
            let F = DocName(context: managedContext)
            
            F.fileName = fileName
            F.filePath = filepath.absoluteString
            
            
            do
            {
                try managedContext.save()
            }
            
            catch
            {
                print(error.localizedDescription)
            }
            
            
             
         
         
         
    }
    
    
   
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dthumbnails.count
        
       }
    
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DocumentCell
        {
            cell.updateCell(timage: dthumbnails[indexPath.row],tname: dtname[indexPath.row])
            
            return cell
        }
        
        
        return UICollectionViewCell()
         
        
        
       }
    
    
    
    
    
    
    
    
    
    
    
    func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithResults results: ImageScannerResults) {
            
        
        if let i = results.enhancedScan?.image
        {
            dthumbnails.append(i)
            dtname.append(UUID().uuidString)
            
        }
        
       
        self.documentcollectionview.reloadData()
        
        dismiss(animated: true, completion: nil)
        
       }
       
       func imageScannerControllerDidCancel(_ scanner: ImageScannerController) {
           dismiss(animated: true, completion: nil)
       }
       
       func imageScannerController(_ scanner: ImageScannerController, didFailWithError error: Error) {
           print(error)
       }
    
}

