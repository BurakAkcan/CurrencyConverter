//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Burak AKCAN on 15.06.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    
    @IBOutlet weak var usdLabel: UILabel!
    
    @IBOutlet weak var tlLabel: UILabel!
    
    @IBOutlet weak var customButton: UIButton!
    
    
    override func viewDidLoad() {
      //   let width = view.frame.size.width
        // let height = view.frame.size.height
        
        
//        let myButton = UIButton(type: UIButton.ButtonType.system)
//        myButton.setTitle("Ok", for: UIControl.State.normal)
//        myButton.backgroundColor = UIColor.yellow
//        myButton.frame = CGRect(x: width/2, y: height/2, width: width*0.3, height: height*0.1)
//        myButton.addTarget(self, action: #selector(click), for: UIControl.Event.touchUpInside)
//
//        myButton.layer.cornerRadius = 30
//        view.addSubview(myButton)
//
        super.viewDidLoad()
        customButton.layer.cornerRadius = 30
            
    }

    @IBAction func getButton(_ sender: UIButton) {
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=4a990ae1cc0ef5a920e4c7e9eeb1123c")
        
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                //error.localizedDescription errorun tanımını gösteririz
                let ac = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                ac.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
                self.present(ac, animated: true)
            }else{
                if data != nil {
                    // data vrsa
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? Dictionary<String,Any>{
                                self.myRates(mny: "cad", rates: rates, label: self.cadLabel)
                                self.myRates(mny: "chf", rates: rates, label: self.chfLabel)
                                self.myRates(mny: "gbp", rates: rates, label: self.gbpLabel)
                                self.myRates(mny: "jpy", rates: rates, label: self.jpyLabel)
                                self.myRates(mny: "usd", rates: rates, label: self.usdLabel)
                                self.myRates(mny: "try", rates: rates, label: self.tlLabel)
                                
                            }
                        }
                    }catch{
                        print(error)
                    }
                    
                }
            }
        }
        //task başlat
        task.resume()
        
        
    }
    

    func myRates(mny:String,rates:Dictionary<String,Any>,label:UILabel){
        if let come = rates["\(mny.uppercased())"] as? Double {
            label.text = "\(mny.uppercased()): \(come)"
        }
    }
}

