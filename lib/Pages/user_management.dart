import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:mbt_workorder_approve/Provider/colore_provider.dart';
import 'package:mbt_workorder_approve/Provider/userlogin.dart';
import 'package:mbt_workorder_approve/ServerAndConfig/config.dart';

class UserManagement extends StatefulWidget {
  const UserManagement({super.key});

  @override
  State<UserManagement> createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  ColorNotifire notifire = ColorNotifire();
  final UserLoginProvider loginProvider = UserLoginProvider();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool superUser = false;

  List<dynamic> users = [];
  bool isLoading = false;
  Map<String, dynamic>? currentUser;
  Map<String, dynamic>? editingUser;

  @override
  void initState() {
    super.initState();
    _checkSuperUser();
    _fetchUsers();
  }

  Future<void> _checkSuperUser() async {
    final user = await loginProvider.getUser();
    if (user == null || user['super'] != true) {
      if (mounted) {
        Navigator.pop(context);
        _showMessage('Access denied. Super user privileges required.', isError: true);
      }
    } else {
      if (mounted) {
        setState(() {
          currentUser = user;
        });
      }
    }
  }

  Future<void> _fetchUsers() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    try {
      var dio = Dio();
      var response = await dio.request(
        '${Configuration.apiServer}getUsers',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200 && mounted) {
        setState(() {
          users = response.data ?? [];
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        _showMessage('Error fetching users: $e', isError: true);
      }
    }
  }

  Future<void> _addUser() async {
    if (!_validateForm()) return;

    setState(() {
      isLoading = true;
    });

    try {
      var dio = Dio();
      var response = await dio.request(
        '${Configuration.apiServer}addUser',
        options: Options(
          method: 'POST',
          headers: {'Content-Type': 'application/json'},
        ),
        data: {
          'name': nameController.text.trim(),
          'department': departmentController.text.trim(),
          'username': usernameController.text.trim(),
          'password': passwordController.text.trim(),
          'super': superUser,
          'valid': 1,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _clearForm();
        _fetchUsers();
        _showMessage('User added successfully');
      }
    } catch (e) {
      _showMessage('Error adding user: $e', isError: true);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _updateUser() async {
    if (!_validateForm() || editingUser == null) return;

    setState(() {
      isLoading = true;
    });

    try {
      var dio = Dio();
      var response = await dio.request(
        '${Configuration.apiServer}updateUser/${editingUser!['id']}',
        options: Options(
          method: 'PUT',
          headers: {'Content-Type': 'application/json'},
        ),
        data: {
          'name': nameController.text.trim(),
          'department': departmentController.text.trim(),
          'username': usernameController.text.trim(),
          'password': passwordController.text.trim().isNotEmpty
              ? passwordController.text.trim()
              : editingUser!['password'],
          'super': superUser,
        },
      );

      if (response.statusCode == 200) {
        _clearForm();
        _fetchUsers();
        _showMessage('User updated successfully');
      }
    } catch (e) {
      _showMessage('Error updating user: $e', isError: true);
    } finally {
      setState(() {
        isLoading = false;
        editingUser = null;
      });
    }
  }

  Future<void> _deleteUser(dynamic user) async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: Text('Are you sure you want to delete user: ${user['name']}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    setState(() {
      isLoading = true;
    });

    try {
      var dio = Dio();
      var response = await dio.request(
        '${Configuration.apiServer}deleteUser/${user['id']}',
        options: Options(
          method: 'PUT',
          headers: {'Content-Type': 'application/json'},
        ),
        data: {'valid': 0},
      );

      if (response.statusCode == 200) {
        _fetchUsers();
        _showMessage('User deleted successfully');
      }
    } catch (e) {
      _showMessage('Error deleting user: $e', isError: true);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _editUser(dynamic user) {
    setState(() {
      editingUser = user;
      nameController.text = user['name'] ?? '';
      departmentController.text = user['department'] ?? '';
      usernameController.text = user['username'] ?? '';
      passwordController.text = '';
      superUser = user['super'] == true || user['super'] == 1;
    });
  }

  void _viewUserInfo(dynamic user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.person, color: Colors.blue),
              const SizedBox(width: 10),
              Text('User Information', style: TextStyle(color: notifire.textcolore)),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInfoRow('ID', user['id'].toString()),
                _buildInfoRow('Name', user['name'] ?? 'N/A'),
                _buildInfoRow('Department', user['department'] ?? 'N/A'),
                _buildInfoRow('Username', user['username'] ?? 'N/A'),
                _buildInfoRow('Email', user['email'] ?? 'N/A'),
                _buildInfoRow('Super User', (user['super'] == true || user['super'] == 1) ? 'Yes' : 'No'),
                _buildInfoRow('Active', (user['valid'] == 1 || user['valid'] == true) ? 'Yes' : 'No'),
                if (user['createDatetime'] != null)
                  _buildInfoRow('Created Date', _formatDateTime(user['createDatetime'])),
                if (user['createBy'] != null)
                  _buildInfoRow('Created By', 'User ID: ${user['createBy']}'),
                if (user['modifyDatetime'] != null)
                  _buildInfoRow('Modified Date', _formatDateTime(user['modifyDatetime'])),
                if (user['modifyBy'] != null)
                  _buildInfoRow('Modified By', 'User ID: ${user['modifyBy']}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: notifire.textcolore,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: notifire.textcolore),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(String? dateTimeStr) {
    if (dateTimeStr == null) return 'N/A';
    try {
      final dateTime = DateTime.parse(dateTimeStr);
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateTimeStr;
    }
  }

  bool _validateForm() {
    if (nameController.text.trim().isEmpty) {
      _showMessage('Please enter name', isError: true);
      return false;
    }
    if (departmentController.text.trim().isEmpty) {
      _showMessage('Please enter department', isError: true);
      return false;
    }
    if (usernameController.text.trim().isEmpty) {
      _showMessage('Please enter username', isError: true);
      return false;
    }
    if (editingUser == null && passwordController.text.trim().isEmpty) {
      _showMessage('Please enter password', isError: true);
      return false;
    }
    return true;
  }

  void _clearForm() {
    nameController.clear();
    departmentController.clear();
    usernameController.clear();
    passwordController.clear();
    setState(() {
      superUser = false;
      editingUser = null;
    });
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    departmentController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);

    return Container(
      color: notifire.bgcolore,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Management',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: notifire.textcolore,
              ),
            ),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: notifire.containcolore1,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    editingUser != null ? 'Edit User' : 'Add New User',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: notifire.textcolore,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: nameController,
                          style: TextStyle(color: notifire.textcolore),
                          decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(color: notifire.textcolore),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          controller: departmentController,
                          style: TextStyle(color: notifire.textcolore),
                          decoration: InputDecoration(
                            labelText: 'Department',
                            labelStyle: TextStyle(color: notifire.textcolore),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: usernameController,
                          style: TextStyle(color: notifire.textcolore),
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(color: notifire.textcolore),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          style: TextStyle(color: notifire.textcolore),
                          decoration: InputDecoration(
                            labelText: editingUser != null ? 'Password (leave empty to keep current)' : 'Password',
                            labelStyle: TextStyle(color: notifire.textcolore),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Checkbox(
                        value: superUser,
                        onChanged: (value) {
                          setState(() {
                            superUser = value ?? false;
                          });
                        },
                      ),
                      Text(
                        'Super User',
                        style: TextStyle(color: notifire.textcolore),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : (editingUser != null ? _updateUser : _addUser),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        ),
                        child: Text(
                          editingUser != null ? 'Update User' : 'Add User',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 20),
                      if (editingUser != null)
                        ElevatedButton(
                          onPressed: _clearForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            Text(
              'Users List',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: notifire.textcolore,
              ),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: notifire.containcolore1,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('Name', style: TextStyle(color: notifire.textcolore, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Department', style: TextStyle(color: notifire.textcolore, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Username', style: TextStyle(color: notifire.textcolore, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Super User', style: TextStyle(color: notifire.textcolore, fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Actions', style: TextStyle(color: notifire.textcolore, fontWeight: FontWeight.bold))),
                          ],
                          rows: users.where((user) => user['valid'] == 1 || user['valid'] == true).map((user) {
                            return DataRow(
                              cells: [
                                DataCell(Text(user['name'] ?? '', style: TextStyle(color: notifire.textcolore))),
                                DataCell(Text(user['department'] ?? '', style: TextStyle(color: notifire.textcolore))),
                                DataCell(Text(user['username'] ?? '', style: TextStyle(color: notifire.textcolore))),
                                DataCell(
                                  Icon(
                                    (user['super'] == true || user['super'] == 1) ? Icons.check_circle : Icons.cancel,
                                    color: (user['super'] == true || user['super'] == 1) ? Colors.green : Colors.grey,
                                  ),
                                ),
                                DataCell(
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.info_outline, color: Colors.green),
                                        onPressed: () => _viewUserInfo(user),
                                        tooltip: 'View Info',
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.edit, color: Colors.blue),
                                        onPressed: () => _editUser(user),
                                        tooltip: 'Edit',
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete, color: Colors.red),
                                        onPressed: () => _deleteUser(user),
                                        tooltip: 'Delete',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}