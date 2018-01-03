//
//  FilesPath.swift
//  SideVCApp
//
//  Created by 陈岩 on 2017/12/29.
//  Copyright © 2017年 陈岩. All rights reserved.
//

import UIKit

class FilesPath: NSObject {

    //1 打印相关的基本信息
    func path() {
        //沙盒主目录路径,包含三个默认文件夹：Documents，Library，temp，.app包
        let temp = NSHomeDirectory()
        print("temp:" + temp)
        
        //Documents目录路径,应将所有的应用程序数据文件写入到这个目录下，用于存储用户数据。该路径可通过配置实现iTunes共享文件。可被iTunes备份
        let docDir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        print("docDir:" + docDir)
        
        //Library的目录路径，有两个子目录，除caches外，也会被iTunes备份
        //Preferences：应用程序的偏好设置文件。不应该直接创建偏好设置文件，应使用NSUserDefaults类来获取和设置应用程序的偏好
        //Caches：存放程序专用的支持文件，保存应用程序再次启动过程中需要的信息。
        let libDir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        print("libDir:" + libDir)
        
        //Caches目录路径
        let cachesDir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        print("cachesDir:" + cachesDir)
        
        //获取tmp目录路径，用于存放临时文件，保存程序启动过程中不需要的信息。不会被iTunes备份
        let tmpDir = NSTemporaryDirectory()
        print("tmpDir:" + tmpDir)
        
        let manager = FileManager.default
        let docDirUrl = manager.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)[0]
        let pathurl = docDirUrl.appendingPathComponent("text.txt")
        //保存文件
        if !manager.fileExists(atPath: cachesDir + "/text.tex") {
            manager.createFile(atPath: cachesDir + "/text.tex", contents: nil, attributes: nil)
        }
        //保存文件夹
        if !manager.fileExists(atPath: docDir + "/text.tex") {
            do {
                try manager.createDirectory(at: pathurl, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("创建失败")
            }
        }
        //读取文件
        let _ = manager.contents(atPath: cachesDir + "/text.tex")
        do {
            let _ = try Data.init(contentsOf: pathurl)
        } catch {}
        
        print("pathurl:", pathurl)
        
        let userName = NSUserName()
        let userPath = NSHomeDirectoryForUser(userName)
        print(docDirUrl, userName, userPath, NSFullUserName())
      
        writeAndRead()
        
        writeToPlist(value: "相见时难别亦难" as AnyObject, key: "dongs")
        let data = ["hahah","相见欢"]
        writeToPlist(value: data as AnyObject, key: "data")
        print(readFromPlist(key: "dong"))
        print(readFromPlist(key: "data"))
        print(readFromPlist(key: "lll"))
    }
    
    //MARK: - 2、沙盒地址：Documents，Library，catch，temp,
    func getDocument() -> String {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    }
    
    func getLibrary() -> String {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    }
    
    func getCache() -> String {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    }
    
    func getTmp() -> String {
        return NSTemporaryDirectory()
    }
    
    //MARK: - 3、文件是否存在
    func isExitFile(path: String) -> Bool {
        if FileManager.default.fileExists(atPath: path) {
            return true
        }
        return false
    }
    
    //MARK: - 4、文件重命名
    func creatNewNameFile(oldPath: String, to: String, newName: String) -> Bool {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: oldPath) {
            print("待重命名文件不存在")
            return false
        }
        if fileManager.fileExists(atPath: to) {
            print("已存在同名文件，是否替换")
            return false
        } else {
            do  {
                try fileManager.moveItem(atPath: oldPath, toPath: to)
            } catch {
                return false
            }
            return true
        }
    }
    
    //MARK: - 5、删除文件
    func deleteFile(path: String) -> Bool {
        if FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch {
                return false
            }
            return true
        }
        return false
    }
    
    //MAKR: - 6、获取缓存大小
    func getSizePath(path: String) -> UInt64 {
        var sizeInBytes: UInt64 = 0
        let fileManager = FileManager.default
        do {
            let fileUrls = try fileManager.contentsOfDirectory(atPath: path)
            for fileUrl in fileUrls {
                let attibutes = try fileManager.attributesOfItem(atPath: fileUrl)
                sizeInBytes += (attibutes[FileAttributeKey.size] as? NSNumber)?.uint64Value ?? 0
            }
        } catch { }
        
        return sizeInBytes
    }
    
    func getSizePathString(path: String) -> String {
        var sizeInBytes: UInt64 = 0
        let fileManager = FileManager.default
        do {
            let fileUrls = try fileManager.contentsOfDirectory(atPath: path)
            for fileUrl in fileUrls {
                let attibutes = try fileManager.attributesOfItem(atPath: fileUrl)
                sizeInBytes += (attibutes[FileAttributeKey.size] as? NSNumber)?.uint64Value ?? 0
            }
        } catch { }
        
        let byteCountFormatter = ByteCountFormatter()
        byteCountFormatter.allowedUnits = .useMB
        byteCountFormatter.countStyle = .file
        return byteCountFormatter.string(fromByteCount: Int64(sizeInBytes))
    }
    
    //MARK: - 7、清除缓存
    func clearCache(path: String) {
        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
        queue.async {
            let fileManager = FileManager.default
            do {
                let fileUrls = try fileManager.contentsOfDirectory(atPath: path)
                for fileUrl in fileUrls {
                    try fileManager.removeItem(atPath: fileUrl)
                }
            } catch { }
        }
    }
    
    //MARK: - 8、存储为plist属性列表
    func writeAndRead() {
        writeToFile()
        readFromFile()
    }
    
    //写入文件
    func writeToFile() {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        let filePath = (path as NSString).appendingPathComponent("test.plist")
        print(filePath)
        
        let dataDicRoot = NSMutableDictionary()
        
        //存储为数据类型
        let dataSource = NSMutableArray()
        dataSource.add("hello" as NSString)
        dataSource.add("world")
        //dataSource.write(toFile: filePath, atomically: true)
        
        //存储为字典类型
        let dataDic = NSMutableDictionary()
        dataDic.setValue("人生若只如初见", forKey: "p1")
        dataDic.setValue("何事秋风悲画扇", forKey: "p2")
        //dotaDic.write(toFile: filePath, atomically: true)
        
        //数组和字典做为value值存在 root（字典）目录下，直接写入，会把之前写入的替换掉
        dataDicRoot.setValue(dataSource, forKey: "array")
        dataDicRoot.setValue(dataDic, forKey: "dic")
        dataDicRoot.write(toFile: filePath, atomically: true)
        
    }
    
    //从文件读取
    func readFromFile() {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
        let file = path.appendingPathComponent("test.plist")
        let dataDicRoot = NSDictionary(contentsOfFile: file)
        print(dataDicRoot as Any)
        if let dic = dataDicRoot {
            if let arr = dic.value(forKey: "array") as? NSArray {
                print(arr)
            }
        }
        print(dataDicRoot?.value(forKey: "dic") as Any)
    }
    
    func writeToPlist(value: AnyObject, key: String) {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        let filePath = (path as NSString).appendingPathComponent("plist.plist")
        if let dataDicRoot = NSMutableDictionary(contentsOfFile: filePath) {
            dataDicRoot.setValue(value, forKey: key)
            dataDicRoot.write(toFile: filePath, atomically: true)
        } else {
            let dataDicRoot = NSMutableDictionary()
            dataDicRoot.setValue(value, forKey: key)
            dataDicRoot.write(toFile: filePath, atomically: true)
        }
    }

    func readFromPlist(key: String) -> Any? {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        let filePath = (path as NSString).appendingPathComponent("plist.plist")
        if let dataDicRoot = NSDictionary(contentsOfFile: filePath) {
            if let value = dataDicRoot.value(forKey: key) {
                return value
            }
        }
        return nil
    }
    
    /*
     
     措施名称    描述
     -(NSData *)contentsAtPath:path    从path所代表的文件中读取数据
     -(BOOL)createFileAtPath:path contents:(BOOL)data attributes:attr    将数据写入文件
     -(BOOL)removeFileAtPath:path handler:handler    将path所代表的文件删除
     -(BOOL)movePath:from toPath:to handler:handler    移动或者重命名文件，to所代表的文件不能是已经存在的文件
     -(BOOL)copyPath:from toPath:to handler:handler    复制文件，to所代表的文件不能是已经存在的文件
     -(BOOL)contentsEqualAtPath:path1 andPath:path2    比较path1和path2所代表的文件
     -(BOOL)fileExistsAtPath:path    检查path所代表的文件是否存在
     -(BOOL)isReadableFileAtPath:path    检查path所代表的文件是否存在、是否可读
     -(BOOL)isWritableFileAtPath:path    检查path所代表的文件是否存在、是否可写
     -(NSDictionary *)fileAttributesAtPath:path traverseLink:(BOOL)flag    获取path所代表的文件属性
     -(BOOL)changeFileAttributes:attr atPath:path    改变文件属性
     */
    
    func find() {
        /*
         测试：
         
         NSArray *path1=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);//数据所在缓存的绝对路径
         
         NSArray *path2=NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);//数据所存桌面的绝对路径
         NSArray *path3=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSLocalDomainMask, YES);//数据所在缓存的相对路径
         NSArray *path4=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);//数据所在文件documents的绝对路径
         NSArray *path5=NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);//数据所在文件Library/Documentation的绝对路径
         NSArray *path6=NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);//数据所在文件Library的绝对路径
         NSArray *path7=NSSearchPathForDirectoriesInDomains(NSAllLibrariesDirectory, NSUserDomainMask, YES);//数据所在文件Library的绝对路径
         NSString *destPath = NSHomeDirectory();
         
         
         
         得出的结论：
         NSSearchPathForDirectoriesInDomains（“想要查找的目录”，“想要从哪个路径区域保护区查找”）
         查找的区域：
         typedef NS_OPTIONS(NSUInteger, NSSearchPathDomainMask) {
         NSUserDomainMask = 1,       // 用户的主目录
         NSLocalDomainMask = 2,      // 当前机器的本地目录
         NSNetworkDomainMask = 4,    // 在网络中公开可用的位置
         NSSystemDomainMask = 8,     // 被苹果系统提供的，不可更改的位置 (/System)
         NSAllDomainsMask = 0x0ffff  // 上述所有及未来的位置
         };
         想要查找的目录：
         NSApplicationDirectory = 1,             // 到applications (Applications)目录下
         NSDemoApplicationDirectory,             // 到Applications/Demos目录下
         NSDeveloperApplicationDirectory,        // 到Developer/Applications目录下.
         NSAdminApplicationDirectory,            // 到Applications/Utilities目录下
         NSLibraryDirectory,                     // 到Library目录下
         NSDeveloperDirectory,                   // 到Developer目录下.
         NSUserDirectory,                        // 到用户的主目录下
         NSDocumentationDirectory,               // 到documentation (Documentation)的目录下
         NSDocumentDirectory,                    // 到documents (Documents)目录下
         NSCoreServiceDirectory,                 // CoreServices目录的位置 (System/Library/CoreServices)
         NSAutosavedInformationDirectory NS_ENUM_AVAILABLE(10_6, 4_0) = 11,   // 自动保存的文档位置 (Documents/Autosaved)
         NSDesktopDirectory = 12,                // 本地用户的桌面
         NSCachesDirectory = 13,                 // 本地缓冲区目录(Library/Caches)
         NSApplicationSupportDirectory = 14,     // 本地应用支持文件目录 (plug-ins, etc) (Library/Application Support)
         NSDownloadsDirectory NS_ENUM_AVAILABLE(10_5, 2_0) = 15,              // 本地下载downloads目录
         NSInputMethodsDirectory NS_ENUM_AVAILABLE(10_6, 4_0) = 16,           // 输入方法目录 (Library/Input Methods)
         NSMoviesDirectory NS_ENUM_AVAILABLE(10_6, 4_0) = 17,                 // 电影目录 (~/Movies)
         NSMusicDirectory NS_ENUM_AVAILABLE(10_6, 4_0) = 18,                  // 音乐目录 (~/Music)
         NSPicturesDirectory NS_ENUM_AVAILABLE(10_6, 4_0) = 19,               // 图片目录 (~/Pictures)
         NSPrinterDescriptionDirectory NS_ENUM_AVAILABLE(10_6, 4_0) = 20,     // PPDs目录 (Library/Printers/PPDs)
         NSSharedPublicDirectory NS_ENUM_AVAILABLE(10_6, 4_0) = 21,           // 本地用户分享目录 (~/Public)
         NSPreferencePanesDirectory NS_ENUM_AVAILABLE(10_6, 4_0) = 22,        // PreferencePanes目录的位置使用系统的偏好设置 (Library/PreferencePanes)
         NSApplicationScriptsDirectory NS_ENUM_AVAILABLE(10_8, NA) = 23,      // 本地用户 scripts 文件夹，对于所需的应用(~/Library/Application Scripts/code-signing-id)
         NSItemReplacementDirectory NS_ENUM_AVAILABLE(10_6, 4_0) = 99,        // For use with NSFileManager's URLForDirectory:inDomain:appropriateForURL:create:error:
         NSAllApplicationsDirectory = 100,       // 应用能够发生的所有路径
         NSAllLibrariesDirectory = 101,          //资源可以发生的所有目录
         NSTrashDirectory NS_ENUM_AVAILABLE(10_8, NA) = 102                   // 垃圾存放目录
         };
         NSHomeDirectory（）只能到达用户的主目录
         打印结果： /Users/yinsuke/Library/Application Support/iPhone Simulator/6.0/Applications/FB3B8EAF-63D9-4CFE-878C-2692093CC763
         NSString *tempPath = NSTemporaryDirectory();
         /Users/yinsuke/Library/Application Support/iPhone Simulator/6.0/Applications/FB3B8EAF-63D9-4CFE-878C-2692093CC763/tmp/
         NSString *fullName=NSFullUserName();
         当前用户的一个完整用户名，在需要的路径下可以插入进去。
         NSString *userName=NSUserName();
         返回当前用户的登陆用户名
         NSString * NSHomeDirectoryForUser ( NSString *userName );
         返回指定用户名的用户根目录（home）
         NSString * NSOpenStepRootDirectory (void);
         返回当前用户的系统根目录
         */
    }
    
}
