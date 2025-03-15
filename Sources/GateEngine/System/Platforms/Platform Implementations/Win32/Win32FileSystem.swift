/*
 * Copyright © 2025 Dustin Collins (Strega's Gate)
 * All Rights Reserved.
 *
 * http://stregasgate.com
 */
#if canImport(WinSDK) && GATEENGINE_PLATFORM_HAS_FILESYSTEM
import WinSDK
import Foundation

internal enum Win32FileSystem {
    @inline(__always)
    @inlinable
    func urlForFolderID(_ folderID: KNOWNFOLDERID) -> URL {
        var folderID: KNOWNFOLDERID = folderID
        var pwString: PWSTR! = nil
        _ = SHGetKnownFolderPath(&folderID, DWORD(KF_FLAG_DEFAULT.rawValue), nil, &pwString)
        let string: String = String(windowsUTF16: pwString)
        CoTaskMemFree(pwString)
        return URL(fileURLWithPath: string).appendingPathComponent(Game.unsafeShared.info.identifier)
    }
    
    @inline(__always)
    @inlinable
    static func pathForSearchPath(_ searchPath: FileSystemSearchPath, in domain: FileSystemSearchPathDomain = .currentUser) throws -> String {
        switch searchPath {
        case .persistent:
            switch domain {
            case .currentUser:
                return urlForFolderID(FOLDERID_ProgramData).path
            case .shared:
                return urlForFolderID(FOLDERID_LocalAppData).path
            }
        case .cache:
            switch domain {
            case .currentUser:
                return urlForFolderID(FOLDERID_ProgramData).appendingPathComponent("Cache").path
            case .shared:
                return urlForFolderID(FOLDERID_LocalAppData).appendingPathComponent("Cache").path
            }
        case .temporary:
            let length: DWORD = 128
            var buffer: [UInt16] = Array(repeating: 0, count: Int(length))
            _ = GetTempPathW(length, &buffer)
            return String(windowsUTF16: buffer)
        }
    }
}
#endif
