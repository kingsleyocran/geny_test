import 'package:flutter/material.dart';
import '../widgets/business_card.dart';
import '../data/sample_data.dart';
import '../models/business.dart';
import '../models/service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.business), text: 'Businesses'),
            Tab(icon: Icon(Icons.design_services), text: 'Services'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Businesses Tab
          ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: SampleData.businesses.length,
            itemBuilder: (context, index) {
              final business = SampleData.businesses[index];
              return BusinessCard<Business>(
                item: business,
                onTap: () => _showDetailsDialog(context, business),
              );
            },
          ),

          // Services Tab
          ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: SampleData.services.length,
            itemBuilder: (context, index) {
              final service = SampleData.services[index];
              return BusinessCard<Service>(
                item: service,
                onTap: () => _showDetailsDialog(context, service),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showJsonDemo(context),
        tooltip: 'Show JSON Demo',
        child: const Icon(Icons.code),
      ),
    );
  }

  void _showDetailsDialog(BuildContext context, dynamic item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(item.primaryTitle),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Type: ${item.runtimeType}'),
              const SizedBox(height: 8),
              Text('Info: ${item.secondaryInfo}'),
              const SizedBox(height: 8),
              Text('Contact: ${item.contactInfo}'),
              if (item is Service) ...[
                const SizedBox(height: 8),
                Text('Provider: ${item.provider}'),
                Text('Category: ${item.category}'),
                Text('Price: ${item.formattedPrice}'),
              ],
              if (item is Business) ...[
                const SizedBox(height: 8),
                Text('Business: ${item.bizName}'),
                Text('Location: ${item.bssLocation}'),
              ],
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showJsonDemo(BuildContext context) {
    final businessFromJson = Business.fromJson(SampleData.businessJson);
    final serviceFromJson = Service.fromJson(SampleData.serviceJson);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('JSON Parsing Demo'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Business from JSON:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(businessFromJson.toString()),
                const SizedBox(height: 16),
                const Text('Service from JSON:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(serviceFromJson.toString()),
                const SizedBox(height: 16),
                BusinessCard<Business>(
                  item: businessFromJson,
                  margin: EdgeInsets.zero,
                  elevation: 2,
                ),
                BusinessCard<Service>(
                  item: serviceFromJson,
                  margin: EdgeInsets.zero,
                  elevation: 2,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
