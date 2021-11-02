//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by apple on 29/10/21.
//

import UIKit

class ViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    
    //MARK:- Define Variable
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var models = [User]()
    var selectEditMod = Int()
    
    
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "CoreValueTableViewCell", bundle: nil), forCellReuseIdentifier: "CoreValueTableViewCell")
        addButton.layer.cornerRadius = 20
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getAllIteam()
    }
    
    @IBAction func addButton(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle:nil)
        let customAlert = sb.instantiateViewController(withIdentifier: "ValueViewController") as! ValueViewController
        customAlert.getvalueDelegate = self
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(customAlert, animated: true, completion: nil)
    }
    
    
}


//MARK:- UITableView Delegate & DataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mod = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CoreValueTableViewCell") as? CoreValueTableViewCell else {
            return UITableViewCell()
        }
        cell.userNameLbl.text = mod.name
        cell.dateNameLbl.text = mod.email
        cell.passwordLbl.text = mod.password
        
        cell.editButton.tag = indexPath.row
        cell.editButton.addTarget(self, action: #selector(editButtonTappedAction(sender:)), for: .touchUpInside)
        
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonTappedAction(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func editButtonTappedAction(sender: UIButton){let sb = UIStoryboard(name: "Main", bundle:nil)
        let customAlert = sb.instantiateViewController(withIdentifier: "ValueViewController") as! ValueViewController
        customAlert.getvalueDelegate = self
        customAlert.ifComingScreen = "Edit Screen"
        customAlert.name = models[sender.tag].name ?? ""
        customAlert.email = models[sender.tag].email ?? ""
        customAlert.password = models[sender.tag].password ?? ""
        selectEditMod = sender.tag
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(customAlert, animated: true, completion: nil)
    
    }
    
    @objc func deleteButtonTappedAction(sender: UIButton){
        let mod = models[sender.tag]
        deleteIteam(iteam: mod)
    }
    
    
}

extension ViewController: getValue {
    func getValue(name: String, email: String, password: String, ifComingScreen: String) {
        if ifComingScreen == "Edit Screen"{
            updateIteam(iteam: models[selectEditMod], name: name, email: email, password: password)
        }
        else{
            createIteam(name: name, email: email, password: password)
        }
    }
 
}



//MARK:- Save Value in CoreData Value
extension ViewController {
    
    func getAllIteam(){
        do {
            models = try context.fetch(User.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch  {
            // error
        }
        
    }
    
    func createIteam(name: String, email: String, password: String){
        let newIteam = User(context: context)
        newIteam.name = name
        newIteam.email = email
        newIteam.password = password
        
        do {
            try context.save()
            getAllIteam()
        }
        catch {
            // error
        }
        
    }
    
    func deleteIteam(iteam: User){
        context.delete(iteam)
        do {
            try context.save()
            getAllIteam()
        }
        catch {
            // error
        }
    }
    
    func updateIteam(iteam: User, name: String, email: String, password: String){
        iteam.name = name
        iteam.email = email
        iteam.password = password
        
        do {
            try context.save()
            getAllIteam()
        }
        catch {
            // error
        }
    }
    
}
