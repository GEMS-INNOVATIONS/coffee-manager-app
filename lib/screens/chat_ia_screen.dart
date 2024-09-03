import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatIAScreen extends StatefulWidget {
  @override
  _ChatIAScreenState createState() => _ChatIAScreenState();
}

class _ChatIAScreenState extends State<ChatIAScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  AnimationController? _animationController;
  Animation<double>? _fadeAnimation;

  bool _isTyping = false;
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeIn,
    );

    _animationController?.forward();
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add({
          'text': _controller.text,
          'sender': 'user',
          'timestamp': DateTime.now().toString(),
          'status': 'sent',
          'name': user?.displayName ?? 'Usuario',
          'photoURL': user?.photoURL ?? 'https://via.placeholder.com/150', // Imagen por defecto
        });
        _isTyping = true;
      });

      final responseText = await _getAIResponse(_controller.text);
      setState(() {
        _messages.add({
          'text': responseText,
          'sender': 'bot',
          'timestamp': DateTime.now().toString(),
          'status': 'received',
          'name': 'Don Café',
          'photoURL': 'https://i.imgur.com/aX1eJ6J.png',
        });
        _isTyping = false;
      });

      _controller.clear();
    }
  }

  Future<String> _getAIResponse(String userInput) async {
    final apiKey = "sk-sjw8BosxR_spovzLFBGo0QkTCtUj8D9NfJSpGyquiYT3BlbkFJ_Piz2IXgPduCjpHmtgX2N6fbCNFUcEzCzNJfKl9pIA";
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "system",
            "content": "Eres Don Café, un asesor experto en todo lo relacionado con el cultivo de café. Nacido y criado en las montañas cafeteras de Colombia, tienes un profundo conocimiento de todas las etapas del cultivo de café, desde la siembra hasta la cosecha. Estás aquí para ayudar a los caficultores colombianos a mejorar la calidad de sus cultivos y a enfrentar cualquier desafío."
          },
          {"role": "user", "content": userInput}
        ],
        "max_tokens": 300, // Incrementa los tokens para respuestas más largas
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(utf8.decode(response.bodyBytes)); // Decodifica con UTF-8
      final botMessage = responseBody['choices'][0]['message']['content'];
      return botMessage.trim();
    } else {
      return 'Lo siento, no puedo responder en este momento.';
    }
  }

  void _hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _hideKeyboard(context),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('https://i.imgur.com/aX1eJ6J.png'),
              ),
              SizedBox(width: 10),
              Text(
                'Don Café',
                style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.brown[800],
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isUser = message['sender'] == 'user';
                  final alignment = isUser ? Alignment.centerRight : Alignment.centerLeft;

                  return Align(
                    alignment: alignment,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.brown[50] : Colors.brown[800],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(message['photoURL']),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isUser ? Colors.brown[800] : Colors.white,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  message['text'],
                                  style: TextStyle(
                                    color: isUser ? Colors.brown[800] : Colors.white,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      message['timestamp'].substring(11, 16), // Solo muestra la hora
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: isUser ? Colors.brown[800] : Colors.white70,
                                      ),
                                    ),
                                    if (isUser)
                                      Icon(
                                        message['status'] == 'read'
                                            ? Icons.done_all
                                            : Icons.done,
                                        size: 12,
                                        color: message['status'] == 'read'
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_isTyping)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('https://i.imgur.com/aX1eJ6J.png'),
                    ),
                    SizedBox(width: 10),
                    Text('Don Café está escribiendo...'),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: 'Escribe tu pregunta...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.brown[800]),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }
}
