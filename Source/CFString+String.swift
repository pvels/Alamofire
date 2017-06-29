//
//  CFString+String.swift
//

import CoreFoundation
import Foundation

extension CFString {

    var str: String? {
        let str = CFStringGetCStringPtr(self, CFStringEncoding(kCFStringEncodingUTF8))
        if str != nil {
            return String(cString: str!)
        } else {
            let length = CFStringGetLength(self)
            let buffer = UnsafeMutablePointer<UniChar>.allocate(capacity: length)
            CFStringGetCharacters(self, CFRangeMake(0, length), buffer)

            let str = String._fromCodeUnitSequence(UTF16.self, input: UnsafeBufferPointer(start: buffer, count: length))
            buffer.deinitialize(count: length)
            buffer.deallocate(capacity: length)
            return str
        }
    }

}
