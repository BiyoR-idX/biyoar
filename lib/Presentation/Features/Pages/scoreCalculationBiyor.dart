import 'dart:convert';
import 'package:biyoar/Core/Customs/customColors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// Chat message model
class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

/// API Response model
class ChatApiResponse {
  final String chatText;
  final Map<String, dynamic>? embeddedJson;
  final Map<String, dynamic>? state;
  final String? nextPrompt;
  final bool valid;
  final String? error;

  ChatApiResponse({
    required this.chatText,
    this.embeddedJson,
    this.state,
    this.nextPrompt,
    required this.valid,
    this.error,
  });

  factory ChatApiResponse.fromJson(Map<String, dynamic> json) {
    return ChatApiResponse(
      chatText: json['chat_text'] ?? '',
      embeddedJson: json['embedded_json'],
      state: json['state'],
      nextPrompt: json['next_prompt'],
      valid: json['valid'] ?? false,
      error: json['error'],
    );
  }
}

class BiyoRScoreCalculationLLM extends StatefulWidget {
  const BiyoRScoreCalculationLLM({super.key});

  @override
  State<BiyoRScoreCalculationLLM> createState() =>
      _BiyoRScoreCalculationLLMState();
}

class _BiyoRScoreCalculationLLMState extends State<BiyoRScoreCalculationLLM> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  final String _sessionId = 'game_${DateTime.now().millisecondsSinceEpoch}';

  bool _isLoading = false;

  // Game state from API response
  Map<String, dynamic>? _gameState;

  @override
  void initState() {
    super.initState();
    // Start the conversation with an initial message
    _sendMessage("Start the game");
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// Scroll to the bottom of the chat
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// Send message to the API
  Future<void> _sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    // Add user message to chat
    setState(() {
      _messages.add(ChatMessage(text: message, isUser: true));
      _isLoading = true;
    });
    _scrollToBottom();

    // Clear input field
    _messageController.clear();

    try {
      // Use trailing slash to avoid 307 redirect
      var url = Uri.parse('http://136.112.79.163:8000/api/v1/chat/');
      final requestBody = jsonEncode({
        'session_id': _sessionId,
        'message': message,
      });

      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      // Handle 307 redirect manually
      if (response.statusCode == 307 || response.statusCode == 308) {
        final redirectUrl = response.headers['location'];
        if (redirectUrl != null) {
          final newUrl = Uri.parse(redirectUrl);
          response = await http.post(
            newUrl,
            headers: {'Content-Type': 'application/json'},
            body: requestBody,
          );
        }
      }

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final apiResponse = ChatApiResponse.fromJson(jsonResponse);

        setState(() {
          // Add bot response to chat
          _messages.add(ChatMessage(text: apiResponse.chatText, isUser: false));

          // Update game state
          if (apiResponse.state != null) {
            _gameState = apiResponse.state;
          }

          _isLoading = false;
        });
      } else {
        setState(() {
          _messages.add(ChatMessage(
            text:
                'Error: Server returned ${response.statusCode}\n${response.body}',
            isUser: false,
          ));
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(
          text: 'Error: Could not connect to server.\n$e',
          isUser: false,
        ));
        _isLoading = false;
      });
    }

    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔹 BACKGROUND IMAGE
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/biyorbgi.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// 🔹 MAIN CONTENT
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔙 APP BAR with back button and game state
                _buildAppBar(),

                /// 🔹 SCROLLABLE CHAT CONTENT
                Expanded(
                  child:
                      _messages.isEmpty ? _buildEmptyState() : _buildChatList(),
                ),

                /// 🔹 INPUT FIELD
                _buildInputField(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build the app bar with back button and optional game state
  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            iconSize: 30,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'BiyoR Score Calculator',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_gameState != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    'Team: ${_gameState!['team'] ?? 'N/A'} | Score: ${_gameState!['total_score'] ?? 0} | Time: ${_gameState!['time_left']?.toStringAsFixed(0) ?? '30'} min',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Restart button
          IconButton(
            onPressed: () {
              setState(() {
                _messages.clear();
                _gameState = null;
              });
              _sendMessage("Restart");
            },
            icon: const Icon(Icons.refresh),
            color: Colors.white,
            iconSize: 28,
          ),
        ],
      ),
    );
  }

  /// Build empty state when no messages
  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        'Starting game...',
        style: TextStyle(color: Colors.white70, fontSize: 16),
      ),
    );
  }

  /// Build the chat list
  Widget _buildChatList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      itemCount: _messages.length + (_isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        // Show loading indicator at the end
        if (index == _messages.length && _isLoading) {
          return _buildLoadingBubble();
        }

        final message = _messages[index];
        return _buildMessageBubble(message);
      },
    );
  }

  /// Build a single message bubble
  Widget _buildMessageBubble(ChatMessage message) {
    final isUser = message.isUser;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: isUser ? 50 : 0,
          right: isUser ? 0 : 50,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isUser
              ? woodBrown.withOpacity(0.85)
              : Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isUser ? const Radius.circular(16) : Radius.zero,
            bottomRight: isUser ? Radius.zero : const Radius.circular(16),
          ),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black87,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  /// Build loading bubble
  Widget _buildLoadingBubble() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 8, right: 50),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(woodBrown),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Thinking...',
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  /// Build the input field
  Widget _buildInputField() {
    return Container(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
        bottom: MediaQuery.of(context).padding.bottom + 10,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _messageController,
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                hintText: "Type your message...",
                hintStyle: TextStyle(color: Colors.grey[600]),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: borderColor, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: borderColor, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: woodBrown, width: 2),
                ),
              ),
              onFieldSubmitted: (value) {
                if (!_isLoading) {
                  _sendMessage(value);
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          // Send button
          Container(
            decoration: BoxDecoration(
              color: woodBrown,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Icon(Icons.send, color: Colors.white),
              onPressed: _isLoading
                  ? null
                  : () => _sendMessage(_messageController.text),
            ),
          ),
        ],
      ),
    );
  }
}
