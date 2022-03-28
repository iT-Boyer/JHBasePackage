#!/usr/bin/env python3
# coding=UTF-8

"""
批量编译组件中的静态库，并转为 xcframework
注意：若源文件有增减，必须重新拖入工程文件 JHBase.xcodeproj 中
"""

import os, sys, json, shutil
from platform import python_version

# 待编译的target，，为空时，编译所有 target；编译完成的xcframework会自动复制至XCFrameworks文件夹下
# ["Alamofire","Algorithms","Charts","ESPullToRefresh","GRDB","IQKeyboardManagerSwift","Kingfisher","Lottie","LottieCore","Moya","SnapKit","SwifterSwift","SwiftyJSON"]
g_targets = []

# 读取项目 targets
def read_targets_list(proj_dir:str):
    targets_json:str = os.popen('cd ' + proj_dir + ' && xcodebuild -list -json').read()
    if targets_json == "":
        return []
    targets_dict = json.loads(targets_json)
    proj_targets_list = targets_dict["project"]["targets"]
    return proj_targets_list

# 编译对应 target
def build_targets(proj_dir:str, targets:list):
    cmd_dir = "cd " + proj_dir
    for target in targets:
        cmd_build = cmd_dir + " && " + "xcodebuild -target " + target + " -scheme " + target
        cmd_build = cmd_build + " -configuration Release -arch arm64 -sdk iphoneos -derivedDataPath xbuild -quiet"
        print("+" * 30 + "执行命令" + "+" * 30)
        print(cmd_build)
        print("-" * 30 + "执行命令" + "-" * 30)
        os.system(cmd_build)

# 清理旧的 xbuild 文件夹
def clean_xbuild_folder(proj_dir:str):
    xbuild_path = os.path.join(proj_dir, "xbuild")
    if os.path.exists(xbuild_path):
        shutil.rmtree(xbuild_path)

# 转为 xcframework
def convert_xcframework(proj_dir:str, targets:list):
    xbuild_path = os.path.join(proj_dir, "xbuild/Build/Products/Release-iphoneos")
    xcframework_path = os.path.join(proj_dir, "XCFrameworks")
    if not os.path.exists(xcframework_path):
        os.makedirs(xcframework_path)
    for target in targets:
        target_src_name = target + ".framework"
        target_src_path = os.path.join(xbuild_path, target_src_name)
        # 判断 framework 是否存在
        if not os.path.exists(target_src_path):
            print("Error：静态库文件不存在 " + target_src_name)
        target_dst_name = target + ".xcframework"
        target_dst_path = os.path.join(xcframework_path, target_dst_name)
        # 移除旧的 xcframework
        if os.path.exists(target_dst_path):
            shutil.rmtree(target_dst_path)
        xcodebuild_cmd = "xcodebuild -create-xcframework -framework " + target_src_path + " -output " + target_dst_path
        os.system(xcodebuild_cmd)
        # 拷贝swiftmodule
        cp_swiftmodule(target, target_src_path, target_dst_path)


# 拷贝swiftmodule文件下文件至 xcframework
def cp_swiftmodule(target_name:str, src_framework:str, xc_framework:str):
    # framework 的 swiftmodule 文件夹
    swiftmodule_path = "Modules/" + target_name + ".swiftmodule"
    src_swiftmodule_path = os.path.join(src_framework, swiftmodule_path)
    # xcframework 的 swiftmodule 文件夹
    dst_arm64_path = "ios-arm64/" + target_name + ".framework/" + swiftmodule_path
    dst_swiftmodule_path = os.path.join(xc_framework, dst_arm64_path)
    # 列出 framework 的 swiftmodule 文件夹文件
    src_swiftmodule_list = os.listdir(src_swiftmodule_path)
    for file_name in src_swiftmodule_list:
        src_file_path = os.path.join(src_swiftmodule_path, file_name)
        if not os.path.isfile(src_file_path):
            continue
        dst_file_path = os.path.join(dst_swiftmodule_path, file_name)
        if os.path.exists(dst_file_path):
            continue
        # 如果目标不存在，拷贝
        shutil.copyfile(src_file_path, dst_file_path)

# main
if __name__ == "__main__":
    print("Python 版本：" + python_version())
    py_dir = os.path.dirname(os.path.abspath(__file__))
    targets_list = g_targets
    if len(targets_list) == 0:
        targets_list = read_targets_list(py_dir)
    if len(targets_list) == 0:
        print("Error：读取Target列表为空")
        sys.exit()
    # 清理旧的编译工程
    clean_xbuild_folder(py_dir)
    # 编译 targets 列表为 framework
    build_targets(py_dir, targets_list)
    # 转为 xcframework
    convert_xcframework(py_dir, targets_list)

