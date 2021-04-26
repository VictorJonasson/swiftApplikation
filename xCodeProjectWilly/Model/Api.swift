//
//  Api.swift
//  xCodeProjectWilly
//
//  Created by Victor on 2021-04-11.
//

import Foundation

class Api {
    static func getVaccinated(callback: (@escaping (Int) -> Void )){
        URLSession.shared.dataTask(with: URL(string: "https://covid-api.mmediagroup.fr/v1/vaccines?country=Sweden")!, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else { return }
                var result: Response?
                do {
                    result = try JSONDecoder().decode(Response.self, from: data)
                } catch {
                    print(error)
                }
                guard let json = result else { return }
                callback(json.All.administered)
            }
        }).resume()
    }
}
