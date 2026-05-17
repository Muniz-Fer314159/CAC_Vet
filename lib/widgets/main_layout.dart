import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import '../services/auth_service.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final String title;
  final String token;

  const MainLayout({
    super.key,
    required this.child,
    this.title = '',
    this.token = '',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: AppTextStyles.heading3.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: child,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirChatIA(context),
        backgroundColor: AppColors.accent,
        elevation: 4,
        tooltip: 'Assistente IA',
        child: const Icon(Icons.smart_toy, color: Colors.white),
      ),
    );
  }

  void _abrirChatIA(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _ChatModal(token: token);
      },
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isBot;

  _ChatMessage({required this.text, required this.isBot});
}

class _ChatModal extends StatefulWidget {
  final String token;

  const _ChatModal({required this.token});

  @override
  State<_ChatModal> createState() => _ChatModalState();
}

class _ChatModalState extends State<_ChatModal> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final AuthService _authService = AuthService();
  final List<_ChatMessage> _messages = [
    _ChatMessage(
      text: 'Olá! Sou seu assistente veterinário. Como posso ajudar hoje?',
      isBot: true,
    ),
  ];
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

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

  Future<void> _enviarMensagem() async {
    final texto = _controller.text.trim();
    if (texto.isEmpty || _isLoading) return;

    _controller.clear();

    setState(() {
      _messages.add(_ChatMessage(text: texto, isBot: false));
      _isLoading = true;
    });
    _scrollToBottom();

    try {
      final response = await _authService.chatIA(
        prompt: texto,
        token: widget.token,
      );

      // Tenta extrair a resposta do JSON retornado pela API
      String resposta;
      if (response.containsKey('response')) {
        resposta = response['response'].toString();
      } else if (response.containsKey('message')) {
        resposta = response['message'].toString();
      } else if (response.containsKey('data')) {
        resposta = response['data'].toString();
      } else if (response.containsKey('text')) {
        resposta = response['text'].toString();
      } else {
        // Fallback: usa o primeiro valor do mapa
        resposta = response.values.first.toString();
      }

      if (!mounted) return;

      setState(() {
        _messages.add(_ChatMessage(text: resposta, isBot: true));
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _messages.add(_ChatMessage(
          text: 'Desculpe, ocorreu um erro ao processar sua mensagem. Tente novamente.',
          isBot: true,
        ));
        _isLoading = false;
      });
    }

    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header do modal
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: AppShapes.buttonRadius,
                  ),
                  child: const Icon(
                    Icons.smart_toy,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Assistente Veterinário',
                        style: AppTextStyles.heading3.copyWith(color: Colors.white),
                      ),
                      Text(
                        'IA especializada em cuidados veterinários',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          // Conteúdo do chat
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _messages.length + (_isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == _messages.length && _isLoading) {
                          return _buildTypingIndicator();
                        }
                        final msg = _messages[index];
                        return _buildMessage(msg.text, isBot: msg.isBot);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => _enviarMensagem(),
                          enabled: !_isLoading,
                          decoration: InputDecoration(
                            hintText: _isLoading
                                ? 'Aguardando resposta...'
                                : 'Digite sua pergunta...',
                            filled: true,
                            fillColor: AppColors.background,
                            border: OutlineInputBorder(
                              borderRadius: AppShapes.inputRadius,
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        decoration: BoxDecoration(
                          gradient: _isLoading ? null : AppColors.primaryGradient,
                          color: _isLoading ? Colors.grey : null,
                          borderRadius: AppShapes.buttonRadius,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: _isLoading ? null : _enviarMensagem,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Digitando...',
              style: AppTextStyles.caption.copyWith(color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildMessage(String message, {bool isBot = false}) {
    return Align(
      alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isBot ? AppColors.primary.withValues(alpha: 0.1) : AppColors.primary,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isBot ? const Radius.circular(4) : const Radius.circular(16),
            bottomRight: isBot ? const Radius.circular(16) : const Radius.circular(4),
          ),
        ),
        child: Text(
          message,
          style: AppTextStyles.body.copyWith(
            color: isBot ? AppColors.textPrimary : Colors.white,
          ),
        ),
      ),
    );
  }
}
