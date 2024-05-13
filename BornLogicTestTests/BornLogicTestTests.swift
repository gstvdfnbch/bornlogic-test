//
//  BornLogicTestTests.swift
//  BornLogicTestTests
//
//  Created by Gustavo Diefenbach on 13/05/24.
//

import XCTest
@testable import BornLogicTest

final class BornLogicTestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchAllArticles() throws {
        //Call the fetch to make sure if the requisition is correct
        APIService.shared.fetchAllArticles { articles, error in
            // Check for errors response
            XCTAssertNil(error, "Error fetching articles: \(error?.localizedDescription ?? "")")
            
            // Check if articles are received
            XCTAssertNotNil(articles, "No articles received")
            
            // Assert that at least one article is received
            XCTAssertFalse(articles?.isEmpty ?? true, "No articles received")
        }
    }


}
