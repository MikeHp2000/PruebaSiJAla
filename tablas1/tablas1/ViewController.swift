//
//  ViewController.swift
//  tablas1
//
//  Created by Miguel Angel Herrera Perez on 16/02/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let names = [
        "John Smith",
        "Dan Smith",
        "Jason Smith",
        "Mary Smith"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }


}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me!")
    }
    
}

extension ViewController: UITableViewDataSource {
    
    //Repeticiones de elementos
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    //Agregar filas= Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    //Agregar contenido a las filas
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = names[indexPath.row]
        
        return cell
    }
}
