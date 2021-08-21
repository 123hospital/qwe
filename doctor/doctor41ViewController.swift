// 光田  神經內科 楊鈞百
import UIKit
import Alamofire
import Kanna

struct  data_struct41{
    var d_name:String = ""
    var d_experience:String = ""
    var d_skill:String = ""
    var d_license:String = ""
}
class doctor41ViewController: UIViewController {

    @IBOutlet weak var tableview_doctor: UITableView!
    var doctor41_array:[data_struct41] = Array()
    var check:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        load_data41()
        
      
        // Do any additional setup after loading the view, typically from a nib.
    }


}

extension doctor41ViewController{
    func load_data41() {

        Alamofire.request("http://www.ktgh.com.tw/web/Neurology/").responseString { response in
            if let html = response.result.value{
                self.parsehtml41(html)
            }
        }
    }
    func parsehtml41(_ html1:String)  {
        var gg:NSString = " "
        var  doc = try? Kanna.HTML(html: html1, encoding: String.Encoding.utf8)
        var s = data_struct41()
        for i in 1...1{
            for rate1 in doc!.xpath("//*[@id=\"Table10\"]/tbody/tr/td/table[\(i)]/tbody/tr/td/p[1]/strong"){
                //*[@id="Table10"]/tbody/tr/td/table[1]/tbody/tr/td/p[1]/strong
                gg = rate1.text! as NSString
                s.d_name = gg as String
                
                
            for rate in doc!.xpath("//*[@id=\"Table10\"]/tbody/tr/td/table[\(i)]/tbody/tr/td/ol"){
                    //*[@id="Table10"]/tbody/tr/td/table[1]/tbody/tr/td/ol

                gg = rate.text! as NSString
                s.d_experience = gg.replacingOccurrences(of: " ", with: "")
            }
                

            for k in 3...3{
                for rate2 in doc!.xpath("//*[@id=\"Table10\"]/tbody/tr/td/table[\(i)]/tbody/tr/td/p[\(k)]/text()[1]"){
                    //*[@id="Table10"]/tbody/tr/td/table[1]/tbody/tr/td/p[3]/text()[1]

                    gg = rate.text! as NSString
                    s.d_skill = gg.replacingOccurrences(of: " ", with: "")
                    
                    
                }
            }
           
        }
        doctor41_array.append(s)
            
        tableview_doctor.reloadData()

    }
    
}

extension doctor41ViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  doctor41_array.count > 0 {
            return doctor41_array.count
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


