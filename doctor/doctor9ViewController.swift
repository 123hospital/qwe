// 何秋燕皮膚科診所 何秋燕
import UIKit
import Alamofire
import Kanna

struct  data_struct9{
    var d_name:String = ""
    var d_experience:String = ""
    var d_skill:String = ""
    var d_license:String = ""
}
class doctor9ViewController: UIViewController {

    @IBOutlet weak var tableview_doctor: UITableView!
    var doctor9_array:[data_struct9] = Array()
    var check:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        load_data9()
        
      
        // Do any additional setup after loading the view, typically from a nib.
    }


}

extension doctor9ViewController{
    func load_data9() {

        Alamofire.request("https://www.hoskin.com.tw/p2_team_detail.php?PKey=771c3Ui5ina8xJXPH5NAQAlaD0vuyWZ3Sd0PynZLJQ").responseString { response in
            if let html = response.result.value{
                self.parsehtml9(html)
            }
        }
    }
    func parsehtml9(_ html1:String)  {
        var gg:NSString = " "
        let  doc = try? Kanna.HTML(html: html1, encoding: String.Encoding.utf8)
        var s = data_struct9()
        
        for i in 2...2{
            for rate1 in doc!.xpath("/html/body/div[\(i)]/div/div[1]/div[3]/div[1]"){
                // /html/body/div[2]/div/div[1]/div[3]/div[1]
                gg = rate1.text! as NSString
                s.d_name = gg as String
            }
            for j in 2...2{
                for rate in doc!.xpath("/html/body/div[\(i)]/div/div[1]/div[3]/div[\(j)]"){
                    // /html/body/div[2]/div/div[1]/div[3]/div[2]
                    // /html/body/div[2]/div/div[1]/div[3]/div[4]

                    gg = rate.text! as NSString
                    s.d_experience = gg.replacingOccurrences(of: " ", with: "")
                }
            }
            
            doctor9_array.append(s)
                
                    
            for k in 4...4{
                for rate2 in doc!.xpath("/html/body/div[\(i)]/div/div[1]/div[3]/div[\(k)]"){
                
                    gg = rate2.text! as NSString
                    s.d_skill = gg as String
                    
                }
            }
            doctor9_array.append(s)
        }
            
            
        tableview_doctor.reloadData()

    }

}
    


extension doctor9ViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  doctor9_array.count > 0 {
            return doctor9_array.count
        }else{
               return 0
        }
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "doctorcell1", for: indexPath) as! doctorTableViewCell

        cell.lab_name.adjustsFontSizeToFitWidth = true
        
        cell.name.text = "\(doctor1_array[indexPath.row].d_name)"
        cell.exper.text = "\(doctor1_array[indexPath.row].d_experience)"
        cell.skill.text = "\(doctor1_array[indexPath.row].d_skill)"
        cell.licen.text = "\(doctor1_array[indexPath.row].d_license)"
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let cell = tableView.dequeueReusableCell(withIdentifier: "doctorcell1") as! doctorTableViewCell
        cell.lab_name.text = "名字"
        cell.lab_experience.text = "經歷"
        cell.lab_skill.text = "專長"
        cell.lab_license.text = "證照"
        
        cell.backgroundColor = UIColor.white
                
        cell.lab_name.textColor = UIColor.blue
        cell.lab_experience.textColor = UIColor.gray
        cell.lab_skill.textColor = UIColor.gray
        cell.lab_license.textColor = UIColor.gray
        
                
        cell.lab_name.font = cell.lab_name.font.withSize(20)
        cell.lab_experience.font = cell.lab_experience.font.withSize(20)
        cell.lab_skill.font = cell.lab_skill.font.withSize(20)
        cell.lab_license.font = cell.lab_license.font.withSize(20)
        
        
        headerView.addSubview(cell)
        return headerView
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
}

