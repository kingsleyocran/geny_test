import '../models/business.dart';
import '../models/service.dart';

class SampleData {
  static final List<Business> businesses = [
    const Business(
      bizName: "Chef Ama Private Kitchen",
      bssLocation: "Accra",
      contactNo: "+233 24 888 9999",
    ),
    const Business(
      bizName: "Kwame's Auto Repair",
      bssLocation: "Kumasi",
      contactNo: "+233 20 123 4567",
    ),
    const Business(
      bizName: "Adwoa's Fashion House",
      bssLocation: "Cape Coast",
      contactNo: "+233 26 555 7777",
    ),
    const Business(
      bizName: "Tech Solutions Ghana",
      bssLocation: "Tema",
      contactNo: "+233 23 999 8888",
    ),
  ];

  static final List<Service> services = [
    const Service(
      serviceName: "Private Chef Services",
      category: "Catering",
      provider: "Chef Ama",
      contactNo: "+233 24 888 9999",
      price: 350.0,
    ),
    const Service(
      serviceName: "Mobile App Development",
      category: "Technology",
      provider: "Tech Solutions Ghana",
      contactNo: "+233 23 999 8888",
      price: 2500.0,
    ),
    const Service(
      serviceName: "Custom Tailoring",
      category: "Fashion",
      provider: "Adwoa's Fashion House",
      contactNo: "+233 26 555 7777",
      price: 120.0,
    ),
    const Service(
      serviceName: "Car Maintenance",
      category: "Automotive",
      provider: "Kwame's Auto Repair",
      contactNo: "+233 20 123 4567",
      price: 200.0,
    ),
    const Service(
      serviceName: "Wedding Photography",
      category: "Photography",
      provider: "Lens Masters",
      contactNo: "+233 24 111 2222",
      price: 800.0,
    ),
  ];

  // Sample JSON data for demonstration
  static const Map<String, dynamic> businessJson = {
    "biz_name": "Chef Ama Private Kitchen",
    "bss_location": "Accra",
    "contct_no": "+233 24 888 9999"
  };

  static const Map<String, dynamic> serviceJson = {
    "service_name": "Private Chef Services",
    "category": "Catering",
    "provider": "Chef Ama",
    "contact_no": "+233 24 888 9999",
    "price": 350.0
  };
}
