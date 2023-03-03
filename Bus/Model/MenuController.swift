//
//  MenuController.swift
//  Bus
//
//  Created by Machir on 2022/9/9.
//

import Foundation

class MenuController {
    static let shared = MenuController()
    
    let tokenUrlStr = "https://tdx.transportdata.tw/auth/realms/TDXConnect/protocol/openid-connect/token"
    
    let expirationInterval: TimeInterval = 72000 //設定20小時的秒數
    
    var access_token = String()
    
    func getToken(urlStr: String) {
        
        if let expirationDate = UserDefaults.standard.object(forKey: "expirationDate") as? Date,
           expirationDate > Date() {
            access_token = UserDefaults.standard.string(forKey: "token")!
            print("token有效\(expirationDate)")
            print(Date())
            return
        }
        
        let parameters = "grant_type=client_credentials&client_id=machirchen-506cbd7f-855c-4d9e&client_secret=1fe3ec62-c935-4a44-a43f-602becb0104d"
        let postData =  parameters.data(using: .utf8)
        let url = URL(string: urlStr)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-Type")
        request.httpBody = postData
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let content = String(data: data, encoding: .utf8){
                print(content)
                do {
                    let decoder = JSONDecoder()
                    let tokenResponse = try decoder.decode(TokenResponse.self, from: data)
                    self.access_token = tokenResponse.access_token
                    UserDefaults.standard.set(self.access_token, forKey: "token")
                    UserDefaults.standard.set(Date(timeIntervalSinceNow: self.expirationInterval), forKey: "expirationDate")
                    print("token已過期，已重新獲取，下次到期日是\(UserDefaults.standard.object(forKey: "expirationDate") as! Date)")
                } catch {
                    print(error)
                }
            } else if let error = error {
                print(error)
            }
        }.resume()
    }
    
    func fetchBusStopData(urlStr: String, completion: @escaping (Result<[BusStopResponse], Error>) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(access_token)", forHTTPHeaderField: "authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let content = String(data: data, encoding: .utf8) {
                let decoder = JSONDecoder()
                do {
                    let busStopResponse = try decoder.decode([BusStopResponse].self, from: data)
                    completion(.success(busStopResponse))
                } catch {
                    completion(.failure(error))
                }
                print(content)
                print(self.access_token)
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchTHSRDailyTimetableData(urlStr: String, completion: @escaping (Result<[THSRDailyTimetableResponse], Error>) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(access_token)", forHTTPHeaderField: "authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let content = String(data: data, encoding: .utf8) {
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode([THSRDailyTimetableResponse].self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
                print(content)
                print(self.access_token)
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchTHSRDailyTimetableTrainDates(urlStr: String, completion: @escaping (Result<THSRDailyTimetableTrainDates, Error>) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(access_token)", forHTTPHeaderField: "authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let content = String(data: data, encoding: .utf8) {
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(THSRDailyTimetableTrainDates.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
                print(content)
                print(self.access_token)
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchTHSRDailyTimetableStationToStationData(urlStr: String, completion: @escaping (Result<[THSRDailyTimetableOToDResponse], Error>) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(access_token)", forHTTPHeaderField: "authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let content = String(data: data, encoding: .utf8) {
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode([THSRDailyTimetableOToDResponse].self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
                print(content)
                print(self.access_token)
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
 
    func fetchTHSRODFareData(urlStr: String, completion: @escaping (Result<[THSROToDFareResponse], Error>) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(access_token)", forHTTPHeaderField: "authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let content = String(data: data, encoding: .utf8) {
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode([THSROToDFareResponse].self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
                print(content)
                print(self.access_token)
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
