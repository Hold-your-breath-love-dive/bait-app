//
//  Mocks.swift
//  Bait
//
//  Created by 이민규 on 2023/07/12.
//

import Foundation
import Vision

extension VNClassificationObservation: ClassificationObservation {}

struct MockVNClassificationObservation: ClassificationObservation {
    var confidence: VNConfidence
    var identifier: String
}

protocol ClassificationObservation {
    var confidence: VNConfidence { get }
    var identifier: String { get }
}
