import 'package:flutter/material.dart';
import '../widgets/agent_sidebar.dart';
import '../widgets/workspace_area.dart';

class IdeHomeScreen extends StatefulWidget {
  const IdeHomeScreen({super.key});

  @override
  State<IdeHomeScreen> createState() => _IdeHomeScreenState();
}

class _IdeHomeScreenState extends State<IdeHomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Use LayoutBuilder to handle responsive behavior if needed
    return Scaffold(
      body: Row(
        children: [
          // Left Sidebar: Agent Chat & Plan
          const SizedBox(
            width: 400,
            child: AgentSidebar(),
          ),
          
          // Vertical Divider
          Container(
            width: 1,
            color: Theme.of(context).dividerColor,
          ),

          // Right Area: Workspace (Editor, Browser, Terminal)
          const Expanded(
            child: WorkspaceArea(),
          ),
        ],
      ),
    );
  }
}
