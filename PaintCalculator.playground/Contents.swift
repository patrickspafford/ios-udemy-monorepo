import Foundation

var width: Float = 1.5
var height: Float = 2.3

var bucketsOfPaint: Int {
    get {
        let area = width * height
        let areaCoveredPerBucket: Float = 1.5
        let numberOfBuckets = area / areaCoveredPerBucket
        return Int(ceil(numberOfBuckets))
    }
    set {
        let buckets = newValue
        let areaCoveredByBuckets: Float = Float(buckets) * 1.5
        let side = sqrt(areaCoveredByBuckets)
        print("\(buckets) buckets can cover \(side) square meters(?) of wall.")
    }
}

print(bucketsOfPaint)
bucketsOfPaint = 4
