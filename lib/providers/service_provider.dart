import 'package:flutter/material.dart';
import '../models/service.dart';
import '../data/sample_data.dart';

class ServiceProvider extends ChangeNotifier {
  // Private state variables
  List<Service> _services = [];

  // Loading state
  bool _isLoading = false;

  // Error state
  String? _error;

  // Getters for accessing state
  List<Service> get services => List.unmodifiable(_services);
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasError => _error != null;
  int get count => _services.length;

  // Initialize data
  Future<void> initializeData() async {
    _setLoading(true);
    _clearError();

    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      _services = List.from(SampleData.services);
      notifyListeners();
    } catch (e) {
      _setError('Failed to initialize service data: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Load services
  Future<void> loadServices() async {
    _setLoading(true);
    _clearError();

    try {
      // Simulate network request
      await Future.delayed(const Duration(milliseconds: 300));

      _services = List.from(SampleData.services);
      notifyListeners();
    } catch (e) {
      _setError('Failed to load services: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Add service
  Future<void> addService(Service service) async {
    _clearError();

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 200));

      // Check for duplicates
      if (_services.any((s) =>
          s.serviceName == service.serviceName &&
          s.provider == service.provider)) {
        throw Exception(
            'Service with this name from this provider already exists');
      }

      _services.add(service);
      notifyListeners();
    } catch (e) {
      _setError('Failed to add service: ${e.toString()}');
      rethrow; // Re-throw to allow UI to handle
    }
  }

  // Update service
  Future<void> updateService(int index, Service updatedService) async {
    _clearError();

    try {
      if (index < 0 || index >= _services.length) {
        throw Exception('Invalid service index');
      }

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 200));

      _services[index] = updatedService;
      notifyListeners();
    } catch (e) {
      _setError('Failed to update service: ${e.toString()}');
      rethrow;
    }
  }

  // Delete service
  Future<void> deleteService(int index) async {
    _clearError();

    try {
      if (index < 0 || index >= _services.length) {
        throw Exception('Invalid service index');
      }

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 200));

      _services.removeAt(index);
      notifyListeners();
    } catch (e) {
      _setError('Failed to delete service: ${e.toString()}');
      rethrow;
    }
  }

  // Find service by name and provider
  Service? findServiceByName(String serviceName, String provider) {
    try {
      return _services.firstWhere(
          (s) => s.serviceName == serviceName && s.provider == provider);
    } catch (e) {
      return null;
    }
  }

  // Search services
  List<Service> searchServices(String query) {
    if (query.isEmpty) return services;
    return _services.where((service) {
      return service.serviceName.toLowerCase().contains(query.toLowerCase()) ||
          service.category.toLowerCase().contains(query.toLowerCase()) ||
          service.provider.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  // Get services by category
  List<Service> getServicesByCategory(String category) {
    return _services
        .where((service) =>
            service.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  // Get services by provider
  List<Service> getServicesByProvider(String provider) {
    return _services
        .where((service) =>
            service.provider.toLowerCase() == provider.toLowerCase())
        .toList();
  }

  // Get services by price range
  List<Service> getServicesByPriceRange(double minPrice, double maxPrice) {
    return _services
        .where(
            (service) => service.price >= minPrice && service.price <= maxPrice)
        .toList();
  }

  // Statistics methods
  Map<String, int> getCategoryCounts() {
    final Map<String, int> counts = {};
    for (final service in _services) {
      counts[service.category] = (counts[service.category] ?? 0) + 1;
    }
    return counts;
  }

  Map<String, int> getProviderCounts() {
    final Map<String, int> counts = {};
    for (final service in _services) {
      counts[service.provider] = (counts[service.provider] ?? 0) + 1;
    }
    return counts;
  }

  double getAveragePrice() {
    if (_services.isEmpty) return 0.0;
    final total =
        _services.fold<double>(0.0, (sum, service) => sum + service.price);
    return total / _services.length;
  }

  double getMinPrice() {
    if (_services.isEmpty) return 0.0;
    return _services.map((s) => s.price).reduce((a, b) => a < b ? a : b);
  }

  double getMaxPrice() {
    if (_services.isEmpty) return 0.0;
    return _services.map((s) => s.price).reduce((a, b) => a > b ? a : b);
  }

  // Get all unique categories
  List<String> getUniqueCategories() {
    return _services.map((s) => s.category).toSet().toList()..sort();
  }

  // Get all unique providers
  List<String> getUniqueProviders() {
    return _services.map((s) => s.provider).toSet().toList()..sort();
  }

  // Utility methods for state management
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Refresh data
  Future<void> refresh() async {
    await loadServices();
  }
}
