// import 'dart:developer';
//
// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
// import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
// import 'package:rt_10055_2D_configurator_suite/data_services/token_api_client.dart';
// import 'package:rt_10055_2D_configurator_suite/utils/agora_configs.dart'
//     as config;
//
// class VideoCallPage extends StatefulHookConsumerWidget {
//   const VideoCallPage({super.key});
//   static String name = "/VideoCallPage";
//
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _VideoCallPageState();
// }
//
// class _VideoCallPageState extends ConsumerState<VideoCallPage> {
//   late final RtcEngine _engine;
//   bool isJoined = false, switchCamera = true, switchRender = true;
//   List<int> remoteUid = [];
//   bool _isRenderSurfaceView = false;
//   late TextEditingController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController(text: config.channelId);
//     _initEngine();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _engine.destroy();
//   }
//
//   Future<void> _initEngine() async {
//     await Future.delayed(Duration(seconds: 3));
//
//     _engine = await RtcEngine.createWithContext(RtcEngineContext(config.appId));
//
//     _addListeners();
//
//     await _engine.enableVideo();
//     await _engine.startPreview();
//     await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
//     await _engine.setClientRole(ClientRole.Broadcaster);
//   }
//
//   void _addListeners() {
//     _engine.setEventHandler(RtcEngineEventHandler(
//       tokenPrivilegeWillExpire: (token) async {
//         log('tokenPrivilegeWillExpire $token');
//         //TODO: It will change when token server ready
//         if (false) {
//           var tokenNotifier = ref.read(tokenNotifierProvider.notifier);
//           await tokenNotifier.fetchToken(config.uid, config.channelId, 2);
//           if (tokenNotifier.state != null) {
//             await _engine.renewToken(tokenNotifier.state!);
//           }
//         }
//       },
//       warning: (warningCode) {
//         log('warning $warningCode');
//       },
//       error: (errorCode) {
//         log('error $errorCode');
//       },
//       joinChannelSuccess: (channel, uid, elapsed) {
//         log('joinChannelSuccess $channel $uid $elapsed');
//         setState(() {
//           isJoined = true;
//         });
//       },
//       userJoined: (uid, elapsed) {
//         log('userJoined  $uid $elapsed');
//         setState(() {
//           remoteUid.add(uid);
//         });
//       },
//       userOffline: (uid, reason) {
//         log('userOffline  $uid $reason');
//         setState(() {
//           remoteUid.removeWhere((element) => element == uid);
//         });
//       },
//       leaveChannel: (stats) {
//         log('leaveChannel ${stats.toJson()}');
//         setState(() {
//           isJoined = false;
//           remoteUid.clear();
//         });
//       },
//     ));
//   }
//
//   _joinChannel() async {
//     if (defaultTargetPlatform == TargetPlatform.android) {
//       await [Permission.microphone, Permission.camera].request();
//     }
// //TODO: will change when token server ready
//     if (false) {
//       var tokenNotifier = ref.read(tokenNotifierProvider.notifier);
//       if (tokenNotifier.state == null) {
//         await tokenNotifier.fetchToken(config.uid, config.channelId, 2);
//         if (tokenNotifier.state != null) {
//           await _engine.renewToken(tokenNotifier.state!);
//         }
//       }
//     }
//
//     await _engine.joinChannel(config.token, _controller.text, null, config.uid);
//   }
//
//   _leaveChannel() async {
//     await _engine.leaveChannel();
//   }
//
//   _switchCamera() {
//     _engine.switchCamera().then((value) {
//       setState(() {
//         switchCamera = !switchCamera;
//       });
//     }).catchError((err) {
//       log('switchCamera $err');
//     });
//   }
//
//   _switchRender() {
//     setState(() {
//       switchRender = !switchRender;
//       remoteUid = List.of(remoteUid.reversed);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextField(
//                 controller: _controller,
//                 decoration: const InputDecoration(hintText: 'Channel ID'),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: ElevatedButton(
//                       onPressed: isJoined ? _leaveChannel : _joinChannel,
//                       child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
//                     ),
//                   )
//                 ],
//               ),
//               _renderVideo(),
//             ],
//           ),
//           if (defaultTargetPlatform == TargetPlatform.android ||
//               defaultTargetPlatform == TargetPlatform.iOS)
//             Align(
//               alignment: Alignment.bottomRight,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   ElevatedButton(
//                     onPressed: _switchCamera,
//                     child: Text('Camera ${switchCamera ? 'front' : 'rear'}'),
//                   ),
//                 ],
//               ),
//             )
//         ],
//       ),
//     );
//   }
//
//   _renderVideo() {
//     return Expanded(
//       child: Stack(
//         children: [
//           Container(
//             child: (kIsWeb || _isRenderSurfaceView)
//                 ? const rtc_local_view.SurfaceView(
//                     zOrderMediaOverlay: true,
//                     zOrderOnTop: true,
//                   )
//                 : const rtc_local_view.TextureView(),
//           ),
//           Align(
//             alignment: Alignment.topLeft,
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: List.of(remoteUid.map(
//                   (e) => GestureDetector(
//                     onTap: _switchRender,
//                     child: SizedBox(
//                       width: 120,
//                       height: 120,
//                       child: (kIsWeb || _isRenderSurfaceView)
//                           ? rtc_remote_view.SurfaceView(
//                               uid: e,
//                               channelId: _controller.text,
//                             )
//                           : rtc_remote_view.TextureView(
//                               uid: e,
//                               channelId: _controller.text,
//                             ),
//                     ),
//                   ),
//                 )),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
