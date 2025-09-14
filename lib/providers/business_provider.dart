import 'package:flutter/material.dart';
import '../models/business.dart';
import '../data/sample_data.dart';

class BusinessProvider extends ChangeNotifier {
  // Private state variables
  List<Business> _businesses = [];

  // Loading state
  bool _isLoading = false;

  // Error state
  String? _error;

  // Getters for accessing state
  List<Business> get businesses => List.unmodifiable(_businesses);
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasError => _error != null;
  int get count => _businesses.length;

  // Initialize data
  Future<void> initializeData() async {
    _setLoading(true);
    _clearError();

    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      _businesses = List.from(SampleData.businesses);
      notifyListeners();
    } catch (e) {
      _setError('Failed to initialize business data: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Load businesses
  Future<void> loadBusinesses() async {
    _setLoading(true);
    _clearError();

    try {
      // Simulate network request
      await Future.delayed(const Duration(milliseconds: 300));

      _businesses = List.from(SampleData.businesses);
      notifyListeners();
    } catch (e) {
      _setError('Failed to load businesses: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Add business
  Future<void> addBusiness(Business business) async {
    _clearError();

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 200));

      // Check for duplicates
      if (_businesses.any((b) => b.bizName == business.bizName)) {
        throw Exception('Business with this name already exists');
      }

      _businesses.add(business);
      notifyListeners();
    } catch (e) {
      _setError('Failed to add business: ${e.toString()}');
      rethrow; // Re-throw to allow UI to handle
    }
  }

  // Update business
  Future<void> updateBusiness(int index, Business updatedBusiness) async {
    _clearError();

    try {
      if (index < 0 || index >= _businesses.length) {
        throw Exception('Invalid business index');
      }

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 200));

      _businesses[index] = updatedBusiness;
      notifyListeners();
    } catch (e) {
      _setError('Failed to update business: ${e.toString()}');
      rethrow;
    }
  }

  // Delete business
  Future<void> deleteBusiness(int index) async {
    _clearError();

    try {
      if (index < 0 || index >= _businesses.length) {
        throw Exception('Invalid business index');
      }

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 200));

      _businesses.removeAt(index);
      notifyListeners();
    } catch (e) {
      _setError('Failed to delete business: ${e.toString()}');
      rethrow;
    }
  }

  // Find business by name
  Business? findBusinessByName(String name) {
    try {
      return _businesses.firstWhere((b) => b.bizName == name);
    } catch (e) {
      return null;
    }
  }

  // Search businesses
  List<Business> searchBusinesses(String query) {
    if (query.isEmpty) return businesses;
    return _businesses.where((business) {
      return business.bizName.toLowerCase().contains(query.toLowerCase()) ||
          business.bssLocation.toLowerCase().contains(query.toLowerCase()) ||
          business.contactNo.contains(query);
    }).toList();
  }

  // Get businesses by location
  List<Business> getBusinessesByLocation(String location) {
    return _businesses
        .where((business) =>
            business.bssLocation.toLowerCase() == location.toLowerCase())
        .toList();
  }

  // Get location counts for statistics
  Map<String, int> getLocationCounts() {
    final Map<String, int> counts = {};
    for (final business in _businesses) {
      counts[business.bssLocation] = (counts[business.bssLocation] ?? 0) + 1;
    }
    return counts;
  }

  // Get all unique locations
  List<String> getUniqueLocations() {
    return _businesses.map((b) => b.bssLocation).toSet().toList()..sort();
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
    await loadBusinesses();
  }
}
