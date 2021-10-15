//
//  NewsModel.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 12/10/2021.
//

import Foundation

struct NewsModel: Codable {
    let articles: [Articles]
}

struct Articles: Codable, Hashable {
    let author: String?
    let title: String?
    let url: String
    let urlToImage: String?
}

extension NewsModel {
    static let new = Articles(
        author: "Jon Fingas",
        title: "AMC theaters will accept cryptocurrencies beyond Bitcoin",
        url: "https://www.engadget.com/amc-theaters-accept-ethereum-litecoin-bitcoin-cash-132642183.html",
        urlToImage: "https://blogger.googleusercontent.com/img/a/AVvXsEhiFZua2TKlWOHoZ5qipQ8zBVpSMbXNdxOFJmwNkddvji4GqJRO4SonCCmwV_IBrxtHCb2UlJ850RuZPY75s54QZkedzrYthaQqoo4tuOD3zUbMhTGxJ2T-rFtSu8I1vRJY9RtH8dWw7_5XtGfoeUvJuAWZU-U9XLsHKTKffBSWD6G9su34rjkO0sYD-w=w1200-h630-p-k-no-nu")
}
