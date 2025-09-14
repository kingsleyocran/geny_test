import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/business_card.dart';
import '../models/business.dart';
import '../models/service.dart';
import '../providers/business_provider.dart';
import '../providers/service_provider.dart';

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
    _tabController = TabController(length: 2, vsync: this);
    // Initialize data when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BusinessProvider>().initializeData();
      context.read<ServiceProvider>().initializeData();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<BusinessProvider, ServiceProvider>(
      builder: (context, businessProvider, serviceProvider, child) {
        final hasAnyError =
            businessProvider.hasError || serviceProvider.hasError;
        final isAnyLoading =
            businessProvider.isLoading || serviceProvider.isLoading;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  icon: const Icon(Icons.business),
                  text: 'Businesses (${businessProvider.count})',
                ),
                Tab(
                  icon: const Icon(Icons.design_services),
                  text: 'Services (${serviceProvider.count})',
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  businessProvider.refresh();
                  serviceProvider.refresh();
                },
                tooltip: 'Refresh All Data',
              ),
              if (hasAnyError)
                IconButton(
                  icon: const Icon(Icons.warning, color: Colors.red),
                  onPressed: () => _showErrorDialog(
                      context, businessProvider, serviceProvider),
                  tooltip: 'Show Errors',
                ),
            ],
          ),
          body: isAnyLoading &&
                  businessProvider.businesses.isEmpty &&
                  serviceProvider.services.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : TabBarView(
                  controller: _tabController,
                  children: [
                    // Businesses Tab
                    _buildBusinessesTab(businessProvider),
                    // Services Tab
                    _buildServicesTab(serviceProvider),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildBusinessesTab(BusinessProvider provider) {
    if (provider.isLoading && provider.businesses.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error loading businesses',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(provider.error!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => provider.loadBusinesses(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (provider.businesses.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.business, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No businesses found'),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => provider.loadBusinesses(),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: provider.businesses.length,
        itemBuilder: (context, index) {
          final business = provider.businesses[index];
          return BusinessCard<Business>(
            item: business,
            onTap: () => _showDetailsDialog(context, business),
          );
        },
      ),
    );
  }

  Widget _buildServicesTab(ServiceProvider provider) {
    if (provider.isLoading && provider.services.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error loading services',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(provider.error!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => provider.loadServices(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (provider.services.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.design_services, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No services found'),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => provider.loadServices(),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: provider.services.length,
        itemBuilder: (context, index) {
          final service = provider.services[index];
          return BusinessCard<Service>(
            item: service,
            onTap: () => _showDetailsDialog(context, service),
          );
        },
      ),
    );
  }

  void _showErrorDialog(BuildContext context, BusinessProvider businessProvider,
      ServiceProvider serviceProvider) {
    final errors = <String>[];

    if (businessProvider.hasError) {
      errors.add('Business Error: ${businessProvider.error}');
    }
    if (serviceProvider.hasError) {
      errors.add('Service Error: ${serviceProvider.error}');
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Errors'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: errors
                .map((error) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(error),
                    ))
                .toList(),
          ),
          actions: [
            TextButton(
              child: const Text('Clear Errors'),
              onPressed: () {
                businessProvider.clearError();
                serviceProvider.clearError();
                Navigator.of(context).pop();
              },
            ),
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
}
