import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var shapeTableView: UITableView!
    var shapeList = [Shape]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initList()
        
        // Do any additional setup after loading the view.
    }
    
    func initList(){
        let circle = Shape(id: "0", name: "Circle", imageName: "circle")
        shapeList.append(circle)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shapeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellID") as! TableViewCell
        
        let thisShape = shapeList[indexPath.row]
        
        tableViewCell.ShapeName.text = thisShape.id + " " + thisShape.name
        tableViewCell.ShapeImage.image = UIImage(named: thisShape.imageName)
        
        return tableViewCell
    }
}

