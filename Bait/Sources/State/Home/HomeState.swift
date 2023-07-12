//
//  HomeState.swift
//  Bait
//
//  Created by Mercen on 2023/07/12.
//

import Combine
import SwiftUI
import Alamofire

class HomeState: ObservableObject {
    
    @State var selectedImage = UIImage()
    @State var isImagePickerShown = false
    
    func presentCamara() {
        
    }
    func presentPhoto() {
        
    }
    
    func getToday() -> String {
        
        let date = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
    }
    
    func getWaterTemp(completion: @escaping (String) -> Void) {
        var tempStr = "99"
        
        AF.request("http://www.khoa.go.kr/api/oceangrid/tideObsTemp/search.do?ServiceKey=hGg53MAm5H6vCZsu5MkIEw==&ObsCode=DT_0001&Date=\(getToday())&ResultType=json",
                   method: .get,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type": "application/json"]
        ) { $0.timeoutInterval = 5 }
            .validate()
            .responseData { response in
                
                switch response.result {
                case .success:
                    guard let value = response.value else {
                        completion(tempStr) // Call completion with initial value
                        return
                    }
                    guard let result = try? JSONDecoder().decode(DataStruct.self, from: value),
                          let waterTemp = result.result.data.first?.water_temp else {
                              completion(tempStr) // Call completion with initial value
                              return
                    }
                    completion(waterTemp) // Call completion with updated value
                case .failure:
                    print("실패")
                    completion(tempStr) // Call completion with initial value
                }
            }
    }
    
    struct DataStruct: Codable {
        
        let result: Result
    }
    
    struct Result: Codable {
        
        let meta: Meta
        let data: [Data]
    }
    
    struct Meta: Codable {
        
        let obs_post_id, obs_post_name, obs_lat, obs_lon, obs_last_req_cnt: String
    }
    
    struct Data: Codable {
        
        let record_time, water_temp: String
    }
}
    
