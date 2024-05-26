import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http_parser/http_parser.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:nuritopia2d/app/modules/home/controller/challange_controller.dart';
import 'package:nuritopia2d/app/services/urls.dart';
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:nuritopia2d/utils/Store/HiveStore.dart';
import 'package:video_player/video_player.dart';
import '../../../../../common/widgets/Loader.dart';
import '../../../../../common/widgets/universal_button_widget.dart';
import '../../../../../device_manager/screen_constants.dart';
import '../../../../../utils/TextStyles.dart';
import '../../../../../utils/colors/app_colors.dart';
import '../../../../../utils/localStorage.dart';
import '../../../../../utils/text_utils/app_strings.dart';
import '../../../../routes/routes.dart';
import 'package:http/http.dart' as http;

class VideoViewPage extends StatefulWidget {
  VideoViewPage(
      {Key? key,
        this.path,
        this.category,
        required this.file,
        this.size,
        this.videLength,
        this.videoType,
        this.musicId,
        required this.stageName})
      : super(key: key);
  final String? path;
  final int? category;
  String? size;
  File file;
  int? videLength;
  String stageName;
  int? videoType;
  int? musicId;

  @override
  _VideoViewPageState createState() => _VideoViewPageState();
}

class _VideoViewPageState extends State<VideoViewPage> {
  VideoPlayerController? _controller;
  var localStorage = LocalHiveStorage();
  String? musicId, UserId;
  ChallengeController challengeController = Get.put(ChallengeController());
  bool isLoading = false;
  int selectedCameraIndex = 0;
  double mirror = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path.toString()))
      ..initialize().then((_) {
        _controller!.addListener(() {
          //custom Listner
          setState(() {
            if (!_controller!.value.isPlaying &&
                _controller!.value.isInitialized &&
                (_controller!.value.duration == _controller!.value.position)) {
              //checking the duration and position every time
              //Video Completed//

              setState(() {});
            }
          });
        });
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        AppStrings.ok.tr,
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: CustomColor.primaryBlue),
      ),
      onPressed: () {
        final targetFile = Directory(widget.path.toString());
        if (targetFile.existsSync()) {
          targetFile.deleteSync(recursive: true);
        }

        //_controller!.dispose();
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => HomeScreen()),
        //         (Route<dynamic> route) => false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: CustomColor.primaryBlack,
      title: Text(
        AppStrings.exit_Record.tr,
        style: const TextStyle(color: Colors.white),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  onback(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        AppStrings.ok.tr,
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: CustomColor.white),
      ),
      onPressed: () {
        final targetFile = Directory(widget.path.toString());
        if (targetFile.existsSync()) {
          targetFile.deleteSync(recursive: true);
        }

        //_controller!.dispose();
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: CustomColor.primaryBlue,
      title: Text(
        AppStrings.cancel_Record.tr,
        style: const TextStyle(color: Colors.white),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<bool> onWillPop() async {
    _controller!.dispose();
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(
    //         builder: (context) => StartRecording(
    //               category: widget.category,
    //             )),
    //     (Route<dynamic> route) => false);
    Navigator.pop(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Stack(children: [
          Scaffold(
            backgroundColor: CustomColor.primaryBlue,
            // extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              // actions: [
              //   Align(
              //     alignment: Alignment.center,
              //     child: Padding(
              //       padding: const EdgeInsets.only(right: 10),
              //       child: GestureDetector(
              //         onTap: () {
              //           showAlertDialog(context);
              //         },
              //         child: Text(
              //           AppStrings.exit.tr,
              //           textAlign: TextAlign.left,
              //           style: const TextStyle(
              //               fontWeight: FontWeight.w900,
              //               fontSize: 17,
              //               decoration: TextDecoration.underline,
              //               decorationColor: CustomColor.white,
              //               color: CustomColor.white),
              //         ),
              //       ),
              //     ),
              //   )
              // ],
              leading: IconButton(
                color: CustomColor.white,
                onPressed: () {
                  onback(context);
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      // width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(),
                      child: _controller!.value.isInitialized
                          ? AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: VideoPlayer(_controller!),
                      )
                          : Container(),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: SafeArea(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        //alignment: Alignment.center,
                        color: Colors.transparent,
                        padding:
                        const EdgeInsets.symmetric(vertical: 5, ),
                        child: UniversalButtonWidget(
                          ontap: () async {
                            setState(() {
                              isLoading = true;
                            });

                            print(widget.path);

                            String? url = await upload2();
                            var result = await challengeController.uploadVideo(
                                // url.toString(),
                                // widget.category!.toString(),
                                // widget.size.toString(),
                                // widget.videLength!.toInt(),
                                // widget.stageName
                              widget.musicId,
                              url.toString(),
                              widget.videoType,
                              widget.stageName
                            );

                            setState(() {
                              isLoading = false;
                            });
                            if (result != null) {
                              if (result["status"] == "success") {
                                await GallerySaver.saveVideo(
                                    widget.path.toString());

                                final targetFile =
                                Directory(widget.path.toString());
                                if (targetFile.existsSync()) {
                                  targetFile.deleteSync(recursive: true);
                                }
                                // _controller!.dispose();
                                Navigator.pushNamed(
                                    context, '/VideoSubmitted');
                              } else {
                                Fluttertoast.showToast(
                                    msg: result["error"],
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                    fontSize: 16.0);
                              }
                            }

                            // await get();
                          },
                          borderRadius: BorderRadius.circular(15),
                          trailingIcon: Icon(Icons.arrow_forward,color: CustomColor.white,size: ScreenConstant.smallIconSize,),
                          trailingIconVisible: true,
                          color: CustomColor.primaryBlue,
                          margin: EdgeInsets.symmetric(
                            vertical: ScreenConstant.defaultHeightFifteen,
                            horizontal: ScreenConstant.defaultWidthForty,
                          ),
                          leadingIconvisible: true,
                          title: AppStrings.submit.tr,
                          titleTextStyle: TextStyles.textStyleRegular
                              .apply(color: CustomColor.white),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (_controller!.value.isPlaying) {
                            setState(() {
                              // Wakelock.disable();
                              // You could also use Wakelock.toggle(on: true);
                            });
                            // widget.player!.pause();
                            _controller!.pause();
                          } else {
                            setState(() {
                              //Wakelock.enable();
                              // You could also use Wakelock.toggle(on: true);
                            });
                            // await  widget.player!.play();
                            _controller!.play();
                          }
                        });
                      },
                      child: CircleAvatar(
                        radius: 33,
                        backgroundColor: Colors.black38,
                        child: Icon(
                          _controller!.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: CustomColor.primaryBlue,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
              visible: isLoading,
              child: Loader(
                text: "",
              ))
        ]));
  }

  double videoContainerRatio = 0.5;

  double getScale() {
    double videoRatio = _controller!.value.aspectRatio;

    if (videoRatio < videoContainerRatio) {
      ///for tall videos, we just return the inverse of the controller aspect ratio
      return videoContainerRatio / videoRatio;
    } else {
      ///for wide videos, divide the video AR by the fixed container AR
      ///so that the video does not over scale

      return videoRatio / videoContainerRatio;
    }
  }

  upload2() async {
    String musicId = widget.musicId.toString();
    String id = await HiveStore().getString(Keys.USERID);

    print("file path :" + widget.path!);

    const _accessKeyId = Urls.accessKeyId;
    const _secretKeyId = Urls.secretKeyId;
    const _region = Urls.region;
    const _s3Endpoint = Urls.s3Endpoint;
    const _s3UploadedURL = Urls.s3UploadedURL;
    const _s3BucketName = Urls.s3BucketName;

    final file = File(widget.path!);
    final stream = http.ByteStream(Stream.castFrom(file.openRead()));
    final length = await file.length();

    final uri = Uri.parse(_s3Endpoint);
    print("URI: $uri");
    final req = http.MultipartRequest("POST", uri);
//    final multipartFile = http.MultipartFile.fromPath('file', file, length,
    //  filename: path.basename(file.path));
    final policy = Policy.fromS3PresignedPost(
        'uploaded/' + "Record" + musicId + id + '.mp4',
        _s3BucketName,
        _accessKeyId,
        15,
        length,
        region: _region);
    final key =
    SigV4.calculateSigningKey(_secretKeyId, policy.datetime, _region, 's3');
    final signature = SigV4.calculateSignature(key, policy.encode());

    final mimeTypeData =
    lookupMimeType(widget.path!, headerBytes: [0xFF, 0xD8])!.split('/');

    req.files.add(await http.MultipartFile.fromPath('file', widget.path!,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1])));
    req.fields['key'] = policy.key;
    req.fields['acl'] = 'public-read';
    req.fields['X-Amz-Credential'] = policy.credential;
    req.fields['X-Amz-Algorithm'] = 'AWS4-HMAC-SHA256';
    req.fields['X-Amz-Date'] = policy.datetime;
    req.fields['Policy'] = policy.encode();
    req.fields['X-Amz-Signature'] = signature;
    print("Key: ${policy.key}");
    print("Credential: ${policy.credential}");
    print("X-Amz-Date: ${policy.datetime}");
    print("Policy: ${policy.encode()}");
    print("X-Amz-Signature: $signature");
    try {
      final res = await req.send();
      await for (var value in res.stream.transform(utf8.decoder)) {
        print("Response: $value");
      }

      String url = _s3UploadedURL +
          "Record" +
          musicId +
          id +
          '.mp4';
      return url;
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      print(e.toString());
      return null;
    }
  }
}

class Policy {
  String expiration;
  String region;
  String bucket;
  String key;
  String credential;
  String datetime;
  int maxFileSize;

  Policy(this.key, this.bucket, this.datetime, this.expiration, this.credential,
      this.maxFileSize,
      {this.region = 'eu-west-2'});

  factory Policy.fromS3PresignedPost(
      String key,
      String bucket,
      String accessKeyId,
      int expiryMinutes,
      int maxFileSize, {
        String? region,
      }) {
    final datetime = SigV4.generateDatetime();
    final expiration = (DateTime.now())
        .add(Duration(minutes: expiryMinutes))
        .toUtc()
        .toString()
        .split(' ')
        .join('T');
    final cred =
        '$accessKeyId/${SigV4.buildCredentialScope(datetime, region!, 's3')}';
    final p = Policy(key, bucket, datetime, expiration, cred, maxFileSize,
        region: region.toString());
    return p;
  }

  String encode() {
    final bytes = utf8.encode(toString());
    return base64.encode(bytes);
  }

  @override
  String toString() {
    return '''
{ "expiration": "${this.expiration}",
  "conditions": [
    {"bucket": "${this.bucket}"},
    ["starts-with", "\$key", "${this.key}"],
    {"acl": "public-read"},
    ["content-length-range", 1, ${this.maxFileSize}],
    {"x-amz-credential": "${this.credential}"},
    {"x-amz-algorithm": "AWS4-HMAC-SHA256"},
    {"x-amz-date": "${this.datetime}" }
  ]
}
''';
  }
}
