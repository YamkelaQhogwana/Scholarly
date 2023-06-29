import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminBlogsPage extends StatefulWidget {
  @override
  _AdminBlogsPageState createState() => _AdminBlogsPageState();
}

class _AdminBlogsPageState extends State<AdminBlogsPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

  DocumentSnapshot? _selectedArticle; // Track the selected article for updating

  void _showAddOverlay(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Article'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(
                labelText: 'Author',
              ),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'Content',
              ),
            ),
            TextField(
              controller: _linkController,
              decoration: InputDecoration(
                labelText: 'Link',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the overlay
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newArticle = {
                'title': _titleController.text,
                'author': _authorController.text,
                'content': _contentController.text,
                'link': _linkController.text,
                'date': DateTime.now().toString(),
              };

              FirebaseFirestore.instance
                  .collection('articles')
                  .add(newArticle)
                  .then((_) {
                // Clear the input fields
                _titleController.clear();
                _authorController.clear();
                _contentController.clear();
                _linkController.clear();

                // Close the overlay
                Navigator.pop(context);
              });
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showUpdateOverlay(BuildContext context, DocumentSnapshot article) {
    setState(() {
      // Set the selected article for updating
      _selectedArticle = article;

      // Set the initial values in the text fields
      _titleController.text = article['title'] as String;
      _authorController.text = article['author'] as String;
      _contentController.text = article['content'] as String;
      _linkController.text = article['link'] as String;
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Article'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(
                labelText: 'Author',
              ),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'Content',
              ),
            ),
            TextField(
              controller: _linkController,
              decoration: InputDecoration(
                labelText: 'Link',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Clear the input fields
              _titleController.clear();
              _authorController.clear();
              _contentController.clear();
              _linkController.clear();

              // Close the overlay
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final updatedArticle = {
                'title': _titleController.text,
                'author': _authorController.text,
                'content': _contentController.text,
                'link': _linkController.text,
              };

              _selectedArticle!.reference.update(updatedArticle).then((_) {
                // Clear the input fields
                _titleController.clear();
                _authorController.clear();
                _contentController.clear();
                _linkController.clear();

                // Close the overlay
                Navigator.pop(context);
              });
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, DocumentReference reference) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Article'),
        content: Text('Are you sure you want to delete this article?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the confirmation dialog
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              reference.delete(); // Delete the article
              Navigator.pop(context); // Close the confirmation dialog
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Blogs'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('articles').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final articles = snapshot.data!.docs;
          final articleCount = articles.length;

          return SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: articleCount,
              itemBuilder: (context, index) {
                final article = articles[index].data() as Map<String, dynamic>;
                final author = article['author'] as String;
                final content = article['content'] as String;
                final date = article['date'] as String;
                final link = article['link'] as String;
                final title = article['title'] as String;

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.article),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'By $author - $date',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          content,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          link,
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showUpdateOverlay(context, articles[index]);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _showDeleteConfirmation(
                                context, articles[index].reference);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      // Handle blog item tap here
                      // Open the blog details page or perform an action
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddOverlay(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
