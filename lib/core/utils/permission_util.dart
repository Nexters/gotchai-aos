import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:turing/core/utils/color_style.dart';
import 'package:turing/core/utils/log_util.dart';
import 'package:turing/core/utils/text_style.dart';

class PermissionUtils {
  static Future<bool> checkStoragePermission() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt >= 33) {
          return await Permission.photos.isGranted;
        } else {
          return await Permission.storage.isGranted;
        }
      } else {
        return await Permission.photos.isGranted;
      }
    } catch (e) {
      logger.e("권한 확인 실패: $e");
      return false;
    }
  }

  // Storage 권한 요청
  static Future<bool> requestStoragePermission() async {
    try {
      PermissionStatus permission;

      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt >= 33) {
          permission = await Permission.photos.request();
        } else {
          permission = await Permission.storage.request();
        }
      } else {
        permission = await Permission.photos.request();
      }

      return permission.isGranted;
    } catch (e) {
      logger.e("권한 요청 실패: $e");
      return false;
    }
  }

  // 권한 설정 다이얼로그 표시
  static void showPermissionDialog(
    BuildContext context, {
    String title = "권한 필요",
    String content = "이미지를 저장하려면 저장소 권한이 필요합니다.\n설정에서 권한을 허용해주세요.",
    VoidCallback? onSettingsPressed,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: GotchaiColorStyles.gray800,
        title: Text(
          title,
          style: GotchaiTextStyles.subtitle1.copyWith(color: Colors.white),
        ),
        content: Text(
          content,
          style: GotchaiTextStyles.body3.copyWith(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              "취소",
              style: TextStyle(color: GotchaiColorStyles.gray400),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (onSettingsPressed != null) {
                onSettingsPressed();
              } else {
                openAppSettings();
              }
            },
            child: Text(
              "설정",
              style: TextStyle(color: GotchaiColorStyles.primary400),
            ),
          ),
        ],
      ),
    );
  }

  static Future<bool> handleStoragePermission(
    BuildContext context, {
    String? customTitle,
    String? customContent,
  }) async {
    try {
      bool hasPermission = await checkStoragePermission();

      if (!hasPermission) {
        hasPermission = await requestStoragePermission();
      }

      if (!hasPermission) {
        if (context.mounted) {
          showPermissionDialog(
            context,
            title: customTitle ?? "권한 필요",
            content:
                customContent ?? "이미지를 저장하려면 저장소 권한이 필요합니다.\n설정에서 권한을 허용해주세요.",
          );
        }
        return false;
      }

      return true;
    } catch (e) {
      logger.e("권한 처리 실패: $e");
      return false;
    }
  }

  static Future<PermissionStatus> getPermissionStatus() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        return await Permission.photos.status;
      } else {
        return await Permission.storage.status;
      }
    } else {
      return await Permission.photos.status;
    }
  }

  static Future<bool> isPermissionPermanentlyDenied() async {
    final status = await getPermissionStatus();
    return status.isPermanentlyDenied;
  }
}
