//
//  PokemoniumTests.swift
//  PokemoniumTests
//
//  Created by Ivailo Kanev on 21/12/21.
//

import XCTest
@testable import Pokemonium

class PokemoniumTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPokemonService() throws {
        let expectation = expectation(description: "Download pokemons")
        PokemonService().fetchPokemons() { model, error in
            XCTAssertNotNil(model, "No data was downloaded.")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }

}
