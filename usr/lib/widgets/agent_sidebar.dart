import 'package:flutter/material.dart';

class AgentSidebar extends StatefulWidget {
  const AgentSidebar({super.key});

  @override
  State<AgentSidebar> createState() => _AgentSidebarState();
}

class _AgentSidebarState extends State<AgentSidebar> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'role': 'system',
      'content': 'Devin initialized. Ready to build.',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
    },
    {
      'role': 'user',
      'content': 'Create a landing page for a coffee shop with a hero section and a menu list.',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 4)),
    },
    {
      'role': 'agent',
      'content': 'I will start by creating the project structure and the main HTML file. Then I will add CSS for the hero section.',
      'steps': [
        {'status': 'completed', 'text': 'Initialize project structure'},
        {'status': 'in_progress', 'text': 'Write index.html with Hero section'},
        {'status': 'pending', 'text': 'Style with CSS'},
        {'status': 'pending', 'text': 'Add coffee menu data'},
      ],
      'timestamp': DateTime.now().subtract(const Duration(minutes: 3)),
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.auto_awesome, size: 14, color: Colors.white),
                ),
                const SizedBox(width: 10),
                Text(
                  'AI Engineer',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'ONLINE',
                    style: TextStyle(fontSize: 10, color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          // Chat History
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessageItem(msg);
              },
            ),
          ),

          // Input Area
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  maxLines: 3,
                  minLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Ask Devin to do something...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.background,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send_rounded),
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          setState(() {
                            _messages.add({
                              'role': 'user',
                              'content': _controller.text,
                              'timestamp': DateTime.now(),
                            });
                            _controller.clear();
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(Map<String, dynamic> msg) {
    final isUser = msg['role'] == 'user';
    final isSystem = msg['role'] == 'system';
    
    if (isSystem) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Center(
          child: Text(
            msg['content'],
            style: TextStyle(color: Colors.grey[500], fontSize: 12),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isUser ? Icons.person : Icons.smart_toy,
                size: 16,
                color: isUser ? Colors.blue : Colors.purple,
              ),
              const SizedBox(width: 8),
              Text(
                isUser ? 'You' : 'Devin',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              const SizedBox(width: 8),
              Text(
                '${msg['timestamp'].hour}:${msg['timestamp'].minute}',
                style: TextStyle(color: Colors.grey[600], fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isUser 
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.1) 
                  : Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).dividerColor.withOpacity(0.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(msg['content']),
                if (msg.containsKey('steps')) ...[
                  const SizedBox(height: 12),
                  const Divider(height: 1),
                  const SizedBox(height: 8),
                  ...((msg['steps'] as List).map((step) => _buildStepItem(step))),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem(Map<String, dynamic> step) {
    IconData icon;
    Color color;
    
    switch (step['status']) {
      case 'completed':
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case 'in_progress':
        icon = Icons.refresh;
        color = Colors.blue;
        break;
      default:
        icon = Icons.circle_outlined;
        color = Colors.grey;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 8),
          Text(
            step['text'],
            style: TextStyle(
              fontSize: 12,
              color: step['status'] == 'pending' ? Colors.grey : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
