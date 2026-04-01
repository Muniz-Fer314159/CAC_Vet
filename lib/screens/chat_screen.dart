import 'package:flutter/material.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/custom_input.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Atendimento",
          style: TextStyle(color: Colors.orange),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: const [
                ChatBubble(
                  text:
                      "Bem vindo a nossa central de atendimento. Como podemos ajudá-lo?",
                  isMe: false,
                  time: "10:10",
                ),
                ChatBubble(
                  text: "Como faço para enviar uma foto com o meu erro?",
                  isMe: true,
                  time: "10:15",
                ),
              ],
            ),
          ), 

          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Expanded(
                  child: CustomInput(
                    hint: "digite sua mensagem...",
                    suffixIcon: Icon(Icons.image, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    shape: const CircleBorder(),
                  ),
                  child: const Text("ok"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
