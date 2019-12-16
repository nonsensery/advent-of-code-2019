import XCTest
@testable import SpaceStoichiometry

private let fuel = "FUEL"
private let ore = "ORE"

final class SpaceStoichiometryTests: XCTestCase {
    func testSilly() {
        let reactions = parse(
            """
            10 ORE => 10 A
            1 ORE => 1 B
            7 A, 1 B => 1 C
            7 A, 1 C => 1 D
            7 A, 1 D => 1 E
            7 A, 1 E => 1 FUEL
            """
        )

        let result = completeReaction(producing: 1, fuel, startingWith: [fuel: 1], using: reactions)

        XCTAssertEqual(result?.inputs, [fuel: 1])
        XCTAssertEqual(result?.outputs, [fuel: 1])
    }

    func testExample1() {
        let reactions = parse(
            """
            10 ORE => 10 A
            1 ORE => 1 B
            7 A, 1 B => 1 C
            7 A, 1 C => 1 D
            7 A, 1 D => 1 E
            7 A, 1 E => 1 FUEL
            """
        )

        let result = completeReaction(producing: 1, fuel, startingWith: [ore: .max], using: reactions)

        XCTAssertEqual(result?.inputs, [ore: 31])
        XCTAssertEqual(result?.outputs, ["A": 2, fuel: 1])
    }

    func testExample2() {
        let reactions = parse(
            """
            9 ORE => 2 A
            8 ORE => 3 B
            7 ORE => 5 C
            3 A, 4 B => 1 AB
            5 B, 7 C => 1 BC
            4 C, 1 A => 1 CA
            2 AB, 3 BC, 4 CA => 1 FUEL
            """
        )

        let result = completeReaction(producing: 1, fuel, startingWith: [ore: .max], using: reactions)

        XCTAssertEqual(result?.inputs, [ore: 165])
        XCTAssertEqual(result?.outputs, ["B": 1, "C": 3, fuel: 1])
    }

    func testExample3() {
        let reactions = parse(
            """
            157 ORE => 5 NZVS
            165 ORE => 6 DCFZ
            44 XJWVT, 5 KHKGT, 1 QDVJ, 29 NZVS, 9 GPVTF, 48 HKGWZ => 1 FUEL
            12 HKGWZ, 1 GPVTF, 8 PSHF => 9 QDVJ
            179 ORE => 7 PSHF
            177 ORE => 5 HKGWZ
            7 DCFZ, 7 PSHF => 2 XJWVT
            165 ORE => 2 GPVTF
            3 DCFZ, 7 NZVS, 5 HKGWZ, 10 PSHF => 8 KHKGT
            """
        )

        let result = completeReaction(producing: 1, fuel, startingWith: [ore: .max], using: reactions)

        XCTAssertEqual(result?.inputs, [ore: 13_312])
        XCTAssertEqual(result?.outputs, ["DCFZ": 5, fuel: 1, "KHKGT": 3, "NZVS": 4, "PSHF": 3, "QDVJ": 8])
    }

    func testExample4() {
        let reactions = parse(
            """
            2 VPVL, 7 FWMGM, 2 CXFTF, 11 MNCFX => 1 STKFG
            17 NVRVD, 3 JNWZP => 8 VPVL
            53 STKFG, 6 MNCFX, 46 VJHF, 81 HVMC, 68 CXFTF, 25 GNMV => 1 FUEL
            22 VJHF, 37 MNCFX => 5 FWMGM
            139 ORE => 4 NVRVD
            144 ORE => 7 JNWZP
            5 MNCFX, 7 RFSQX, 2 FWMGM, 2 VPVL, 19 CXFTF => 3 HVMC
            5 VJHF, 7 MNCFX, 9 VPVL, 37 CXFTF => 6 GNMV
            145 ORE => 6 MNCFX
            1 NVRVD => 8 CXFTF
            1 VJHF, 6 MNCFX => 4 RFSQX
            176 ORE => 6 VJHF
            """
        )

        let result = completeReaction(producing: 1, fuel, startingWith: [ore: .max], using: reactions)

        XCTAssertEqual(result?.inputs, [ore: 180_697])
        XCTAssertEqual(result?.outputs,
                       [fuel: 1, "RFSQX": 3, "JNWZP": 6, "GNMV": 5, "VPVL": 3, "MNCFX": 2, "NVRVD": 1, "VJHF": 3])
    }

    func testExample5() {
        let reactions = parse(
            """
            171 ORE => 8 CNZTR
            7 ZLQW, 3 BMBT, 9 XCVML, 26 XMNCP, 1 WPTQ, 2 MZWV, 1 RJRHP => 4 PLWSL
            114 ORE => 4 BHXH
            14 VRPVC => 6 BMBT
            6 BHXH, 18 KTJDG, 12 WPTQ, 7 PLWSL, 31 FHTLT, 37 ZDVW => 1 FUEL
            6 WPTQ, 2 BMBT, 8 ZLQW, 18 KTJDG, 1 XMNCP, 6 MZWV, 1 RJRHP => 6 FHTLT
            15 XDBXC, 2 LTCX, 1 VRPVC => 6 ZLQW
            13 WPTQ, 10 LTCX, 3 RJRHP, 14 XMNCP, 2 MZWV, 1 ZLQW => 1 ZDVW
            5 BMBT => 4 WPTQ
            189 ORE => 9 KTJDG
            1 MZWV, 17 XDBXC, 3 XCVML => 2 XMNCP
            12 VRPVC, 27 CNZTR => 2 XDBXC
            15 KTJDG, 12 BHXH => 5 XCVML
            3 BHXH, 2 VRPVC => 7 MZWV
            121 ORE => 7 VRPVC
            7 XCVML => 6 RJRHP
            5 BHXH, 4 VRPVC => 5 LTCX
            """
        )

        let result = completeReaction(producing: 1, fuel, startingWith: [ore: .max], using: reactions)

        XCTAssertEqual(result?.inputs, [ore: 2_210_736])
        XCTAssertEqual(result?.outputs, [
            "ZLQW": 3, "BHXH": 3, "VRPVC": 5, "KTJDG": 3, "BMBT": 1, fuel: 1, "WPTQ": 1, "RJRHP": 1, "MZWV": 4,
            "PLWSL": 1, "FHTLT": 5, "XCVML": 3, "LTCX": 1, "XDBXC": 1
        ])
    }

    func testPart1() {
        let reactions = parse(inputData)
        let result = completeReaction(producing: 1, fuel, startingWith: [ore: .max], using: reactions)

        XCTAssertEqual(result?.inputs, [ore: 532_506])
        XCTAssertEqual(result?.outputs, [
            "SLNKW": 5, "CWCD": 2, "VRVGB": 5, "RLGFX": 4, "BKPZH": 2, "RTLHZ": 4, "FRGJK": 1, "TBVH": 1, "VFLNM": 3,
            "LMCRF": 7, "HTSW": 5, "MQFJF": 4, "BFRTV": 7, "FLZX": 2, "PCRQV": 1, "QPBHG": 2, "SCZQN": 3, "GDVD": 3,
            "LPVGC": 1, "JDSNJ": 4, "RKHMQ": 7, "SGMK": 1, "QDCL": 2, "ZHDSD": 4, "TPZCH": 4, "WTZX": 2, "FZXS": 1,
            "CNQW": 7, "SWKHJ": 2, "QHRG": 2, "WSWBV": 4, "RGKCF": 2, "WZMRW": 1, "RJHCP": 7, fuel: 1, "MQDHX": 2,
            "DLSD": 2, "CZJR": 1, "BQGM": 3
        ])
    }

    func testPart2a() {
        let reactions = parse(inputData)
        let result = completeProduction(of: fuel, from: [ore: 1_000_000_000_000], using: reactions)

        XCTAssertEqual(result, [
            "QHRG": 2232207, "GRDJ": 1, "BRGXB": 2, fuel: 1902654, "QLNHG": 0, "MQFJF": 7511652, "FRGJK": 2,
            "ZHDSD": 4650773, "WSWBV": 7462170, ore: 12937, "WZMRW": 1877913, "MQDHX": 3013596, "LMCRF": 12205233,
            "RJHCP": 5627195, "WTZX": 3706344, "DLSD": 1652840, "PCRQV": 616122, "LPVGC": 1160123, "TBVH": 1828431,
            "RTLHZ": 7288983, "SWKHJ": 3063076, "SCZQN": 5114178, "RLGFX": 1227438, "CZJR": 1, "HTSW": 3748617,
            "RGKCF": 3755097, "FLZX": 3706344, "JDSNJ": 0, "CPGJ": 1, "QDCL": 3508416, "VRVGB": 9389565,
            "SGMK": 1877913, "FZXS": 1778949, "RHSHR": 2, "BKPZH": 3731085, "SLNKW": 8287717, "CWCD": 2914632,
            "BQGM": 5584257, "BFRTV": 13145391, "QPBHG": 0, "CNQW": 13145391, "VFLNM": 5534775, "TPZCH": 7511652,
            "GDVD": 5633739, "RKHMQ": 6561873
        ])
    }

    func testPart2b() {
        let reactions = parse(inputData)
        let result = maxProduction(of: fuel, from: [ore: 1_000_000_000_000], using: reactions)

        XCTAssertEqual(result, 2595245)
    }

    static var allTests = [
        ("testExample1", testExample1),
    ]
}

private func parse(_ string: String) -> [SingleOutputReaction] {
    string
        .split(separator: "\n")
        .map { string in
            let inputsAndOutput = string.split(separator: "=")

            let inputs: [String: Int] = Dictionary(uniqueKeysWithValues:
                inputsAndOutput[0]
                    .split(separator: ",")
                    .map { string in
                        let inputAmountAndElement = string.split(separator: " ")

                        let inputAmount = Int(inputAmountAndElement[0])!
                        let inputElement = String(inputAmountAndElement[1])

                        return (key: inputElement, value: inputAmount)
                    }
            )

            let outputElementAndAmount = inputsAndOutput[1]
                .dropFirst() // dropFirst() removes left over '>' from '=>'
                .split(separator: " ")

            let outputAmount = Int(outputElementAndAmount[0])!
            let outputElement = String(outputElementAndAmount[1])

            return SingleOutputReaction(inputs: inputs, outputElement: outputElement, outputAmount: outputAmount)
        }
}

let inputData =
    """
    4 BFNQL => 9 LMCRF
    2 XGWNS, 7 TCRNC => 5 TPZCH
    4 RKHMQ, 1 QHRG, 5 JDSNJ => 4 XGWNS
    6 HWTBC, 4 XGWNS => 6 CWCD
    1 BKPZH, 2 FLZX => 9 HWFQG
    1 GDVD, 2 HTSW => 8 CNQW
    2 RMDG => 9 RKHMQ
    3 RTLHZ => 3 MSKWT
    1 QLNHG, 1 RJHCP => 3 GRDJ
    10 DLSD, 2 SWKHJ, 15 HTSW => 1 TCRNC
    4 SWKHJ, 24 ZHDSD, 2 DLSD => 3 CPGJ
    1 SWKHJ => 1 THJHK
    129 ORE => 8 KLSMQ
    3 SLNKW, 4 RTLHZ => 4 LPVGC
    1 SLNKW => 5 RLGFX
    2 QHRG, 1 SGMK => 8 RJHCP
    9 RGKCF, 7 QHRG => 6 ZHDSD
    8 XGWNS, 1 CPGJ => 2 QLNHG
    2 MQFJF, 7 TBVH, 7 FZXS => 2 WZMRW
    13 ZHDSD, 11 SLNKW, 18 RJHCP => 2 CZJR
    1 CNQW, 5 GRDJ, 3 GDVD => 4 FLZX
    129 ORE => 4 RHSHR
    2 HWTBC, 2 JDSNJ => 8 QPBHG
    1 BKPZH, 8 SWKHJ => 6 WSWBV
    8 RJHCP, 7 FRGJK => 1 GSDT
    6 QPBHG => 4 BKPZH
    17 PCRQV, 6 BFNQL, 9 GSDT, 10 MQDHX, 1 ZHDSD, 1 GRDJ, 14 BRGXB, 3 RTLHZ => 8 CFGK
    8 RMDG => 6 SGMK
    3 CZJR => 8 RTLHZ
    3 BFRTV => 7 RGKCF
    6 FRGJK, 8 CZJR, 4 GRDJ => 4 BRGXB
    4 VRVGB => 7 PCRQV
    4 TCRNC, 1 TBVH, 2 FZXS, 1 BQGM, 1 THJHK, 19 RLGFX => 2 CRJTJ
    5 RDNJK => 6 SWKHJ
    2 FLVC, 2 SLNKW, 30 HWTBC => 8 DLSD
    6 TBVH, 3 ZHDSD => 5 BQGM
    17 RLGFX => 4 SCZQN
    8 SWKHJ => 6 FZXS
    9 LZHZ => 3 QDCL
    2 ZHDSD => 1 RDNJK
    15 FZXS, 3 TPZCH => 6 MQFJF
    12 RLGFX, 9 QPBHG, 6 HTSW => 1 BFNQL
    150 ORE => 9 BFRTV
    2 BFRTV, 2 KLSMQ => 2 RMDG
    4 VFLNM, 30 RKHMQ, 4 CRJTJ, 24 CFGK, 21 SCZQN, 4 BMGBG, 9 HWFQG, 34 CWCD, 7 LPVGC, 10 QDCL, 2 WSWBV, 2 WTZX => 1 FUEL
    6 RHSHR, 3 RGKCF, 1 QHRG => 6 JDSNJ
    3 MQDHX, 2 XGWNS, 12 GRDJ => 9 LZHZ
    128 ORE => 6 ZBWLC
    9 JDSNJ, 7 RMDG => 8 FLVC
    4 DLSD, 12 CZJR, 3 MSKWT => 4 MQDHX
    2 BXNX, 4 ZBWLC => 3 QHRG
    19 LMCRF, 3 JDSNJ => 2 BMGBG
    1 RJHCP, 26 SGMK => 9 HTSW
    2 QPBHG => 8 VFLNM
    2 RGKCF => 9 SLNKW
    3 LZHZ, 2 GRDJ => 2 TBVH
    100 ORE => 2 BXNX
    4 DLSD, 21 JDSNJ => 8 GDVD
    2 QHRG => 2 HWTBC
    1 LPVGC, 8 XGWNS => 8 FRGJK
    9 FZXS => 7 VRVGB
    7 WZMRW, 1 TBVH, 1 VFLNM, 8 CNQW, 15 LZHZ, 25 PCRQV, 2 BRGXB => 4 WTZX
    """