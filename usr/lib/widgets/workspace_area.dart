import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/nord.dart';

class WorkspaceArea extends StatefulWidget {
  const WorkspaceArea({super.key});

  @override
  State<WorkspaceArea> createState() => _WorkspaceAreaState();
}

class _WorkspaceAreaState extends State<WorkspaceArea> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Workspace Tabs
        Container(
          color: Theme.of(context).colorScheme.surface,
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(
                child: Row(
                  children: [
                    Icon(Icons.code, size: 16),
                    SizedBox(width: 8),
                    Text('Editor'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  children: [
                    Icon(Icons.web, size: 16),
                    SizedBox(width: 8),
                    Text('Preview'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  children: [
                    Icon(Icons.terminal, size: 16),
                    SizedBox(width: 8),
                    Text('Terminal'),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // Tab Content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              CodeEditorView(),
              BrowserPreviewView(),
              TerminalView(),
            ],
          ),
        ),
      ],
    );
  }
}

class CodeEditorView extends StatelessWidget {
  const CodeEditorView({super.key});

  final String code = '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Coffee Shop</title>
    <style>
        body { font-family: sans-serif; margin: 0; padding: 0; background: #f5f5f5; }
        header { background: #3e2723; color: white; padding: 2rem; text-align: center; }
        h1 { margin: 0; font-size: 2.5rem; }
        .container { max-width: 800px; margin: 2rem auto; padding: 0 1rem; }
        .menu-item { background: white; padding: 1rem; margin-bottom: 1rem; border-radius: 8px; display: flex; justify-content: space-between; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .price { font-weight: bold; color: #795548; }
    </style>
</head>
<body>
    <header>
        <h1>Brew Haven</h1>
        <p>Artisan Coffee & Pastries</p>
    </header>
    <div class="container">
        <h2>Our Menu</h2>
        <div class="menu-item">
            <span>Espresso</span>
            <span class="price">\$3.50</span>
        </div>
        <div class="menu-item">
            <span>Cappuccino</span>
            <span class="price">\$4.50</span>
        </div>
        <div class="menu-item">
            <span>Latte</span>
            <span class="price">\$4.75</span>
        </div>
    </div>
</body>
</html>
''';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2E3440),
      child: Column(
        children: [
          // File path breadcrumb
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color(0xFF242933),
            child: const Text(
              'project/index.html',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: HighlightView(
                code,
                language: 'html',
                theme: nordTheme,
                padding: const EdgeInsets.all(16),
                textStyle: const TextStyle(
                  fontFamily: 'JetBrains Mono',
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BrowserPreviewView extends StatelessWidget {
  const BrowserPreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Browser Address Bar
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Row(
              children: [
                const Icon(Icons.refresh, size: 20, color: Colors.grey),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: const Text(
                      'localhost:3000',
                      style: TextStyle(color: Colors.black87, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Mock Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: const Color(0xFF3E2723),
                    padding: const EdgeInsets.all(32),
                    child: const Column(
                      children: [
                        Text(
                          'Brew Haven',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Artisan Coffee & Pastries',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Our Menu',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildMenuItem('Espresso', '\$3.50'),
                        _buildMenuItem('Cappuccino', '\$4.50'),
                        _buildMenuItem('Latte', '\$4.75'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String name, String price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(color: Colors.black87, fontSize: 16)),
          Text(
            price,
            style: const TextStyle(
              color: Color(0xFF795548),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class TerminalView extends StatelessWidget {
  const TerminalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E1E1E),
      padding: const EdgeInsets.all(16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '\$ npm install',
            style: TextStyle(color: Colors.greenAccent, fontFamily: 'JetBrains Mono'),
          ),
          SizedBox(height: 4),
          Text(
            'added 142 packages in 3s',
            style: TextStyle(color: Colors.grey, fontFamily: 'JetBrains Mono'),
          ),
          SizedBox(height: 16),
          Text(
            '\$ npm start',
            style: TextStyle(color: Colors.greenAccent, fontFamily: 'JetBrains Mono'),
          ),
          SizedBox(height: 4),
          Text(
            '> coffee-shop@1.0.0 start',
            style: TextStyle(color: Colors.grey, fontFamily: 'JetBrains Mono'),
          ),
          Text(
            '> http-server .',
            style: TextStyle(color: Colors.grey, fontFamily: 'JetBrains Mono'),
          ),
          SizedBox(height: 8),
          Text(
            'Starting up http-server, serving ./',
            style: TextStyle(color: Colors.white, fontFamily: 'JetBrains Mono'),
          ),
          Text(
            'Available on:',
            style: TextStyle(color: Colors.white, fontFamily: 'JetBrains Mono'),
          ),
          Text(
            '  http://127.0.0.1:3000',
            style: TextStyle(color: Colors.white, fontFamily: 'JetBrains Mono'),
          ),
          Text(
            'Hit CTRL-C to stop the server',
            style: TextStyle(color: Colors.white, fontFamily: 'JetBrains Mono'),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                '\$ ',
                style: TextStyle(color: Colors.greenAccent, fontFamily: 'JetBrains Mono'),
              ),
              SizedBox(width: 8, height: 16, child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey))),
            ],
          ),
        ],
      ),
    );
  }
}
