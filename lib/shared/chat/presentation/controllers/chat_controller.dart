import 'package:get/get.dart';
import '../../data/models/chat_model.dart';

class ChatController extends GetxController {
  final isLoading = false.obs;
  final chats = <ChatModel>[].obs;
  final messages = <MessageModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchChats();
  }

  Future<void> fetchChats() async {
    isLoading.value = true;
    try {
      // ── Demo Data ──────────────────────────────────────────────────────────
      chats.value = [
        ChatModel(
          id: '1',
          name: 'John Doe (Rider)',
          lastMessage: 'I am near your location.',
          time: '10:30 AM',
          image: 'https://i.pravatar.cc/150?u=1',
          unreadCount: 2,
          isOnline: true,
        ),
        ChatModel(
          id: '2',
          name: 'Fresh Mart Support',
          lastMessage: 'Your order has been packed.',
          time: 'Yesterday',
          image: 'https://i.pravatar.cc/150?u=2',
          unreadCount: 0,
          isOnline: false,
        ),
        ChatModel(
          id: '3',
          name: 'Sarah (Driver)',
          lastMessage: 'Thank you for the ride!',
          time: '2 days ago',
          image: 'https://i.pravatar.cc/150?u=3',
          unreadCount: 0,
          isOnline: false,
        ),
      ];
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMessages(String chatId) async {
    isLoading.value = true;
    try {
      // ── Demo Data ──────────────────────────────────────────────────────────
      messages.value = [
        MessageModel(
          id: '1',
          text: 'Hello, where are you?',
          time: DateTime.now().subtract(const Duration(minutes: 10)),
          isMe: true,
        ),
        MessageModel(
          id: '2',
          text: 'I am near the main gate.',
          time: DateTime.now().subtract(const Duration(minutes: 8)),
          isMe: false,
        ),
        MessageModel(
          id: '3',
          text: 'Okay, I am coming out.',
          time: DateTime.now().subtract(const Duration(minutes: 5)),
          isMe: true,
        ),
        MessageModel(
          id: '4',
          text: 'I am waiting here.',
          time: DateTime.now().subtract(const Duration(minutes: 2)),
          isMe: false,
        ),
      ];
    } finally {
      isLoading.value = false;
    }
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    messages.add(
      MessageModel(
        id: DateTime.now().toString(),
        text: text,
        time: DateTime.now(),
        isMe: true,
      ),
    );
  }
}
