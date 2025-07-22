import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unpapered/screens/pdf_chat/chat_page.dart';
import 'package:unpapered/widget/error_box.dart';
import 'package:unpapered/widget/processing.dart';
import 'package:unpapered/utils/api_config.dart';

class FilePickerWidget extends StatefulWidget {
  final Function(File)? onFileSelected;

  const FilePickerWidget({Key? key, this.onFileSelected}) : super(key: key);

  @override
  _FilePickerWidgetState createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget>
    with SingleTickerProviderStateMixin {
  PlatformFile? _platformFile;
  late AnimationController loadingController;

  selectFile() async {
    final file = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (file != null) {
      final platformFile = file.files.first;
      if ((platformFile.size <= 5 * 1024 * 1024)) {
        setState(() {
          _platformFile = platformFile;
        });
        loadingController.forward();
      } else {
        //error
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const ErrorDialogBox('File to Big!',
                  'Please ensure that files selected do not exceed 5MB as per the instructions provided');
            });
        loadingController.reset();
      }
    }
  }

  @override
  void initState() {
    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //! Upload PDF Heading -------------------------------------------------
        const SizedBox(height: 30),
        Center(
          child: Text(
            'Upload PDF',
            style: GoogleFonts.museoModerno(
                color: const Color(0xFF043A50),
                fontSize: 22,
                fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 2),
        // * -------------------------------------------------------------------
        _platformFile != null
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          offset: const Offset(0, 1),
                          blurRadius: 3,
                          spreadRadius: 2,
                        )
                      ]),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.ideographic,
                              children: [
                                Flexible(
                                  flex: 5,
                                  child: Text(
                                    _platformFile!.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${(_platformFile!.size / 1024).ceil()} KB',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 25),
                              ],
                            ),
                            Positioned(
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _platformFile = null;
                                    loadingController.reset();
                                  });
                                },
                                child: Text(
                                  'x',
                                  style: GoogleFonts.nunito(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 5,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: LinearProgressIndicator(
                            value: loadingController.value,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFFF98701)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                  child: Text(
                    'Please select a PDF file, with a maximum size of 5MB',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
        // * -------------------------------------------------------------------
        const SizedBox(height: 10),
        //! Upload PDF Button --------------------------------------------------
        loadingController.isAnimating
            ? const SizedBox.shrink() // Hide button when loading
            : GestureDetector(
                onTap: () async {
                  HapticFeedback.heavyImpact();
                  if (_platformFile != null && _platformFile!.path != null) {
                    // ShowProcess.startProcessing();
                    uploadFileToServer(File(_platformFile!.path!));
                  } else {
                    selectFile();
                  }
                },
                child: Center(
                  child: FittedBox(
                    child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF98701),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 18),
                            child: _platformFile != null
                                ? Text(
                                    'Begin Interaction',
                                    style: GoogleFonts.museoModerno(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  )
                                : Text(
                                    'Browse PDF',
                                    style: GoogleFonts.museoModerno(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                          ),
                        )),
                  ),
                ),
              ),
        // ! -------------------------------------------------------------------
      ],
    );
  }

  //! Function to upload file to FastAPI server --------------------------------
  Future<void> uploadFileToServer(File file) async {
    try {
      ShowProcess.startProcessing();
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConfig.uploadAndProcess),
      );

      request.files.add(await http.MultipartFile.fromPath('pdf', file.path));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('File uploaded successfully');
        setState(() {
          _platformFile = null;
          loadingController.reset();
        });
        ShowProcess.stopProcessing();
        Get.to(() => const ChatPage());
      } else {
        ShowProcess.stopProcessing();
        await showDialog(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialogBox(
                  'Failed to upload file', 'Error: $response.reasonPhrase');
            });
        setState(() {
          _platformFile = null;
          loadingController.reset();
        });
      }
    } catch (e) {
      ShowProcess.stopProcessing();
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialogBox('Failed to upload file', 'Exception: $e');
          });
      setState(() {
        _platformFile = null;
        loadingController.reset();
      });
    }
  }
}
