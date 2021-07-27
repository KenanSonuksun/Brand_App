//
//  ViewController.swift
//  markalarApp
//
//  Created by Pars arge on 12.07.2021.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{
    
    
    
    @IBOutlet weak var table: UITableView!
    
    var markalar : [String] = ["Apple","Samsung","Xiaomi"]
    var selectedIndex : Int = 0;
    var sayac : Int = 0;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        table.dataSource = self
        table.delegate = self
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(buttonClicked))
        addButton.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = addButton
        
        let editBtn = editButtonItem
        self.navigationItem.rightBarButtonItems?.append(editBtn)
        editBtn.tintColor = UIColor.black
        
        loadData()
        
    }
    
    //Marka Ekleme Alerti
    @objc func buttonClicked(){
            
        if table.isEditing {
            return
        }
        
        let alert  = UIAlertController(title: "Marka Ekle", message: "Eklemek istediğiniz markayı ekleyiniz", preferredStyle: UIAlertController.Style.alert)
        alert.addTextField { (markaAdi) in
            markaAdi.placeholder = "Marka Adı"
        }
        
        let actionAdd = UIAlertAction(title: "Ekle", style: UIAlertAction.Style.default) { (action) in
            let firstTextField = alert.textFields![0] as UITextField
            self.markaEkle(markaAdi: firstTextField.text!)
        }
        
        let actionCancel = UIAlertAction(title: "İptal", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(actionAdd)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: nil)
    }
    
   
    
    //Table Settings
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return markalar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell : UITableViewCell = UITableViewCell()
        let cell : UITableViewCell = table.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = markalar[indexPath.row]
        return cell
    }
    
    //Marka Ekle
    func markaEkle(markaAdi : String) {
        
        if table.isEditing {
            return
        }
        
        markalar.insert(markaAdi, at: 0)
        let indexPath : IndexPath = IndexPath(row: 0, section: 0)
        table.insertRows(at: [indexPath], with: UITableView.RowAnimation.left)
        saveData()
        table.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        performSegue(withIdentifier: "goAciklama", sender: self)
    }
    
    //Removing progress
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        table.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            markalar.remove(at: indexPath.row)
            table.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
            saveData()
        }
    }
    
    //Save Data
    func saveData(){
        UserDefaults.standard.setValue(markalar, forKey: "markalar")
        
    }
    //Load Data
    func loadData(){
        if let loadedData : [String] = UserDefaults.standard.value(forKey: "markalar") as? [String] {
            markalar = loadedData
            table.reloadData()
        }
    }
    
    //Select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goAciklama", sender: self)
    }
    
    //Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let aciklamaView : AciklamalarViewController = segue.destination as! AciklamalarViewController
        selectedIndex = table.indexPathForSelectedRow!.row
        aciklamaView.setAciklama(a: markalar[selectedIndex])
    }
}

