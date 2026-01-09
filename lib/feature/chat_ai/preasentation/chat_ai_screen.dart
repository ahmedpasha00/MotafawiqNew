import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/theme/app_colors.dart';
import '../data/cubit/chat_cubit.dart';
import '../data/repo/chat_repository.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(ChatRepository()),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: AnimateGradient(
          primaryColors: const [Color(0xFF000428), Color(0xFF004e92)],
          secondaryColors: const [Color(0xFF004e92), Color(0xFF00c6ff)],
          child: const _ChatView(),
        ),
      ),
    );
  }
}

class _ChatView extends StatefulWidget {
  const _ChatView();

  @override
  State<_ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<_ChatView> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final FlutterTts _flutterTts = FlutterTts();
  final SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _initAudio();
  }

  void _initAudio() async {
    await _speechToText.initialize();
    await _flutterTts.setLanguage("ar-SA");
  }

  void _speak(String text) async {
    await _flutterTts.speak(text);
  }

  void _startListening() async {
    if (!_isListening) {
      bool available = await _speechToText.initialize(
        onStatus: (status) {
          if (status == 'done' || status == 'notListening') {
            if (_isListening) _handleSend();
          }
        },
      );

      if (available) {
        setState(() => _isListening = true);
        _speechToText.listen(
          onResult: (result) {
            setState(() => _controller.text = result.recognizedWords);
          },
          listenMode: ListenMode.dictation,
          pauseFor: const Duration(seconds: 4),
        );
      }
    } else {
      _handleSend();
    }
  }

  void _stopListening() {
    setState(() => _isListening = false);
    _speechToText.stop();
  }

  void _handleSend() {
    if (_controller.text.trim().isNotEmpty) {
      context.read<ChatCubit>().sendMessage(_controller.text.trim());
      _controller.clear();
    }
    _stopListening();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.2),
        elevation: 0,
        title: Text(
          'المتفوق AI',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete_sweep_outlined,
              color: Colors.white70,
            ),
            onPressed: () {
              context.read<ChatCubit>().clearChat();
              _flutterTts.stop();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) _scrollToBottom();
              },
              builder: (context, state) {
                final messages = context.read<ChatCubit>().allMessages;

                if (messages.isEmpty && state is! ChatLoading) {
                  return _buildEmptyState();
                }

                return ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    top: 40.h,
                    bottom: 20.h,
                  ),
                  // زودنا العدد 1 عشان اللوتي يكون أول عنصر
                  itemCount:
                      messages.length + 1 + (state is ChatLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    // أول عنصر دايماً هو اللوتي (المساعد)
                    if (index == 0) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: Lottie.asset(
                          'assets/lottie/aI_animation.json',
                          width: 120.w,
                          height: 120.h,
                          fit: BoxFit.contain,
                        ),
                      );
                    }

                    // عناصر الرسائل (بنشيل 1 من الإندكس عشان اللوتي خد مكان الصفر)
                    int msgIndex = index - 1;

                    if (state is ChatLoading && msgIndex == messages.length) {
                      return _buildLoadingBubble();
                    }

                    if (msgIndex < messages.length) {
                      final msg = messages[msgIndex];
                      return _buildMessageBubble(
                        text: msg.text,
                        isUser: msg.isUser,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                );
              },
            ),
          ),
          _buildSmartInputArea(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lottie/aI_animation.json',
            width: 250.w,
            height: 250.h,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 20.h),
          Text(
            'أهلاً بك! أنا المتفوق AI\nتحدث معي لنبدأ الدراسة 😊',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 20.sp,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble({required String text, required bool isUser}) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!isUser)
            IconButton(
              icon: Icon(
                Icons.volume_up_rounded,
                color: Colors.white60,
                size: 20.sp,
              ),
              onPressed: () => _speak(text),
            ),
          Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(14.w),
            constraints: BoxConstraints(maxWidth: 0.7.sw),
            decoration: BoxDecoration(
              color: isUser
                  ? AppColors.primaryColor
                  : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 15.sp),
            ),
          ),
          if (isUser)
            IconButton(
              icon: Icon(
                Icons.volume_up_rounded,
                color: Colors.white60,
                size: 20.sp,
              ),
              onPressed: () => _speak(text),
            ),
        ],
      ),
    );
  }

  Widget _buildSmartInputArea() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 15.h,
            bottom: 35.h,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.25),
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: _startListening,
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: _isListening
                        ? Colors.redAccent
                        : Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isListening ? Icons.stop : Icons.mic,
                    color: Colors.white,
                    size: 22.sp,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: _isListening
                        ? 'أنا أسمعك الآن...'
                        : 'اكتب أو اسأل بصوتك...',
                    hintStyle: TextStyle(
                      color: Colors.white54,
                      fontSize: 14.sp,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.08),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: _handleSend,
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingBubble() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Shimmer.fromColors(
        baseColor: Colors.white10,
        highlightColor: Colors.white24,
        child: Container(
          width: 100.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
      ),
    );
  }
}
