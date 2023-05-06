import 'package:educational_system/main.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../Helpers/util.dart';
import '../Post/attachment_list_viewer.dart';
import '../Post/link_attach_pop.dart';
import '../Post/post_view_list.dart';
import '../Services/dropbox.service.dart';
import '../Services/post_service.dart';
import '../Services/section_service.dart';
import 'students.dart';

class CourseDetailPage extends StatefulWidget {
  final String sectionId;
  const CourseDetailPage({required this.sectionId});
  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  bool isLoading = true;
  bool isFileUploading = false;
  var sectionDetails = {};
  var postObject = {};
  var attachments = [];
  List<dynamic> allPost = [];
  PlatformFile? _selectedFile;
  bool isPostEnable = true;
  @override
  void initState() {
    super.initState();
    fetchPostData();
    fetchSectionDetails(widget.sectionId).then((value) => {
          if (value['response'] == true)
            {
              setState(() {
                sectionDetails = value['data'];
              })
            },
          isLoading = false,
        });
  }

  TextEditingController _postController = TextEditingController();

  Future<void> _onPostClick() async {
    postObject = {
      ...postObject,
      "belongsTo": widget.sectionId,
      "postDescription": _postController.text.trim(),
    };
    await addPost(postObject);
    setState(() {
      postObject = {};
      attachments = [];
    });
    _postController.clear();
    fetchPostData();
  }

  _onAttachmentChange() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        isPostEnable = file.name.isEmpty;
        _selectedFile = file;
      });
    }
  }

  void setPostObject(Map<dynamic, dynamic> newPostObject) {
    setState(() {
      postObject = newPostObject;
    });
  }

  Future<void> _uploadFile() async {
    if (_selectedFile == null) {
      // show error message if no file selected
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select a file'),
      ));
      return;
    }
    if (_selectedFile != null) {
      setState(() {
        isFileUploading = true;
      });
      var obj = {...postObject};
      var fileMetaData = {
        "fileFormat": _selectedFile?.extension,
        "fileSize": _selectedFile?.size,
        "name": _selectedFile?.name,
      };
      var path = '/${_selectedFile?.name}';
      await uploadFile(path, _selectedFile?.bytes);
      var result = await createSharedLink(path);
      String url = result['url'];
      String previewType = result['preview_type'];
      url = url.replaceAll("dl=0", "raw=1");
      url = url.replaceAll("www.dropbox.com", "dl.dropboxusercontent.com");
      var type = getFileType(previewType);
      var attachment = {
        ...fileMetaData,
        "url": url,
        "path": path,
        "type": type
      };
      var updatedAttachments = [...attachments, attachment];
      obj = {...obj, "attachments": updatedAttachments};
      setState(() {
        isFileUploading = false;
        postObject = obj;
        attachments = updatedAttachments;
        isPostEnable = true;
        _selectedFile = null;
      });
    } else {}
  }

  Future<void> fetchPostData() async {
    var d = await getAllPost(widget.sectionId);
    if (d["response"] == true) {
      setState(() {
        allPost = d["data"];
      });
    }
  }

  void _viewStudents() {
    if (sectionDetails['students'].length > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              StudentsPage(students: sectionDetails['students']),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No students enrolled'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title:
            Text(sectionDetails.isNotEmpty ? sectionDetails["courseName"] : ""),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.people),
              onPressed: _viewStudents,
            ),
          ),
        ],
        titleSpacing: 8.0,
      ),
      body: isLoading
          ? LoadingPage()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: theme.secondaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(children: [
                        Positioned.fill(
                          bottom: MediaQuery.of(context).size.height * .2,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    NetworkImage(sectionDetails['courseCover']),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          bottom: 10,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  sectionDetails["courseName"],
                                  style: TextStyle(
                                    color: theme.onSecondaryContainer,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${sectionDetails['courseCode']} (${sectionDetails["sectionNumber"]})',
                                  style: TextStyle(
                                    color: theme.onSecondaryContainer,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 4, // Set desired elevation value
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  'Create Post',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                TextField(
                                  controller: _postController,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    hintText: 'Write your post here...',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    isFileUploading
                                        ? Center(
                                            child: SizedBox(
                                              height: 16.0,
                                              width: 16.0,
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          )
                                        : Text(""),
                                    Text(
                                      _selectedFile?.name ?? "",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                      style: ButtonStyle(
                                        backgroundColor: _selectedFile != null
                                            ? !isPostEnable
                                                ? MaterialStateProperty.all<
                                                        Color>(
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .tertiaryContainer)
                                                : MaterialStateProperty.all<
                                                    Color>(Colors.lightGreen)
                                            : null,
                                      ),
                                      onPressed: _uploadFile,
                                      icon: Icon(Icons.upload),
                                      label: Text('Upload File'),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                AttachmentList(attachments: attachments),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: _onAttachmentChange,
                                      icon: Icon(Icons.attach_file),
                                      label: Text('File'),
                                    ),
                                    SizedBox(width: 8.0),
                                    AttachmentPopover(
                                      attachments: attachments,
                                      setPostObject: setPostObject,
                                      postObject: postObject,
                                    ),
                                    SizedBox(width: 8.0),
                                    ElevatedButton(
                                      onPressed: isPostEnable
                                          ? () => _onPostClick()
                                          : null,
                                      child: Text('Post'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Display Posted Content
                  PostViewList(allPost: allPost),
                ],
              ),
            ),
    );
  }
}
