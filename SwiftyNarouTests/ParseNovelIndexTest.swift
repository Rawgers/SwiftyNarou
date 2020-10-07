//
//  SwiftyNarouTests.swift
//  SwiftyNarouTests
//
//  Created by Roger Luo on 10/2/20.
//

import SwiftSoup
import XCTest
@testable import SwiftyNarou

class SwiftyNarouTests: XCTestCase {
    var narou: Narou!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        narou = Narou()
    }
    
    func testParseSeriesInfo() {
        let html = """
        <p class="series_title">
            <a href="/s5750d/">六面世界の物語</a>
        </p>
        """
        
        let expectedTitle = "六面世界の物語"
        let expectedNcode = "s5750d"
        
        let fragment = selectFragment(html)
        let (title, ncode) = narou.parseSeriesInfo(selection: fragment)
        XCTAssertEqual(title, expectedTitle)
        XCTAssertEqual(ncode, expectedNcode)
    }
    
    func testParseNovelTitle() {
        let html = "<p class=\"novel_title\">無職転生　- 蛇足編 -</p>"
        let expected = "無職転生　- 蛇足編 -"
        
        let fragment = selectFragment(html)
        let title = narou.parseNovelTitle(selection: fragment)
        XCTAssertEqual(title, expected)
    }
    
    func testParseSynopsis() {
        let html = """
        <div id="novel_ex">
            　『無職転生-異世界行ったら本気出す-』の番外編。
            <br/>

            　ビヘイリル王国での戦いに勝利したルーデウス・グレイラット。
            <br/>

            　彼はこの先なにを思い、なにを為すのか……。
            <br/>
            <br/>

            ※本編を読んでいない方への配慮を考えて書いてはおりません。興味あるけど本編を読んでいない、という方は、本編を先に読むことを強くおすすめします。
            <br/>
            <br/>

            本編はこちら：http://ncode.syosetu.com/n9669bk/
        </div>
        """
        
        let expected = """
        『無職転生-異世界行ったら本気出す-』の番外編。
        ビヘイリル王国での戦いに勝利したルーデウス・グレイラット。
        彼はこの先なにを思い、なにを為すのか……。

        ※本編を読んでいない方への配慮を考えて書いてはおりません。興味あるけど本編を読んでいない、という方は、本編を先に読むことを強くおすすめします。

        本編はこちら：http://ncode.syosetu.com/n9669bk/
        """
        
        let fragment = selectFragment(html)
        let synopsis = narou.parseSynopsis(selection: fragment)
        XCTAssertEqual(synopsis, expected)
    }

    func testParseSection() {
        let html = """
        <dl class="novel_sublist2">
            <dd class="subtitle">
                <a href="/n4251cr/1/">１　「ノルンの嫁入り　前編」</a>
            </dd>
            <dt class="long_update">2015/05/19 19:00</dt>
        </dl>
        """
        
        let expected = Section(
            title: "１　「ノルンの嫁入り　前編」",
            ncode: "n4251cr/1",
            uploadTime: "2015/05/19 19:00"
        )
        
        let fragment = selectFragment(html)
        let section = narou.parseSection(selection: fragment)
        XCTAssertEqual(section, expected)
    }
}
