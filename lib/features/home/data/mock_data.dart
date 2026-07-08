// Mock data for Phase 1 frontend development
// Replace with real API calls in Phase 3

import 'package:flutter/material.dart';

enum QualityTier { premium, excellent, good, normal }

class MockModule {
  final String id;
  final String name;
  final String category;
  final String company;
  final String imageUrl;
  final String description;
  final QualityTier qualityTier;

  MockModule({
    required this.id,
    required this.name,
    required this.category,
    required this.company,
    required this.imageUrl,
    required this.description,
    required this.qualityTier,
  });

  static List<MockModule> sampleModules = [
    // PANELS - Multiple tiers
    MockModule(
      id: '1',
      name: 'SolarMax Pro 540W',
      category: 'Panels',
      company: 'SolarTech Industries',
      imageUrl: 'https://placehold.co/300x200/amber/white?text=Solar+Panel',
      description: 'High-efficiency monocrystalline solar panel with 22% efficiency',
      qualityTier: QualityTier.premium,
    ),
    MockModule(
      id: '5',
      name: 'SunPower Elite 400W',
      category: 'Panels',
      company: 'SunPower Corp',
      imageUrl: 'https://placehold.co/300x200/amber/white?text=Panel',
      description: 'Premium bifacial solar panel with 23% efficiency',
      qualityTier: QualityTier.premium,
    ),
    MockModule(
      id: 'p2',
      name: 'EcoPanel Ultra 450W',
      category: 'Panels',
      company: 'GreenEnergy Solutions',
      imageUrl: 'https://placehold.co/300x200/amber/white?text=EcoPanel',
      description: 'Excellent quality PERC panel with 21% efficiency',
      qualityTier: QualityTier.excellent,
    ),
    MockModule(
      id: 'p3',
      name: 'PowerSun Plus 410W',
      category: 'Panels',
      company: 'SolarTech Industries',
      imageUrl: 'https://placehold.co/300x200/yellow/white?text=PowerSun',
      description: 'High-performance panel with good efficiency rating',
      qualityTier: QualityTier.good,
    ),
    MockModule(
      id: 'p4',
      name: 'Basic Solar 320W',
      category: 'Panels',
      company: 'Budget Solar Co',
      imageUrl: 'https://placehold.co/300x200/gray/white?text=Basic',
      description: 'Standard monocrystalline panel for basic needs',
      qualityTier: QualityTier.normal,
    ),

    // MOUNTING STRUCTURES - All tiers
    MockModule(
      id: '2',
      name: 'EcoMount Plus',
      category: 'Mounting',
      company: 'RoofSecure Systems',
      imageUrl: 'https://placehold.co/300x200/emerald/white?text=Mounting',
      description: 'Aluminum mounting structure with 25-year warranty, corrosion-resistant',
      qualityTier: QualityTier.excellent,
    ),
    MockModule(
      id: 'm1',
      name: 'Premium Rail System 450',
      category: 'Mounting',
      company: 'RoofSecure Systems',
      imageUrl: 'https://placehold.co/300x200/emerald/white?text=Premium',
      description: 'Heavy-duty aluminum rails with stainless steel hardware, 30-year warranty',
      qualityTier: QualityTier.premium,
    ),
    MockModule(
      id: 'm2',
      name: 'EcoMount Standard',
      category: 'Mounting',
      company: 'GreenEnergy Solutions',
      imageUrl: 'https://placehold.co/300x200/lime/white?text=EcoMount',
      description: 'Standard aluminum mounting with 20-year warranty',
      qualityTier: QualityTier.good,
    ),
    MockModule(
      id: '6',
      name: 'Basic Mounting Kit',
      category: 'Mounting',
      company: 'Budget Solar Co',
      imageUrl: 'https://placehold.co/300x200/gray/white?text=Basic',
      description: 'Standard rail mounting system with basic hardware',
      qualityTier: QualityTier.normal,
    ),

    // INVERTERS - All tiers
    MockModule(
      id: '3',
      name: 'PowerFlow String Inverter',
      category: 'Inverters',
      company: 'SolarTech Industries',
      imageUrl: 'https://placehold.co/300x200/blue/white?text=Inverter',
      description: 'String inverter with 98% efficiency, smart monitoring',
      qualityTier: QualityTier.good,
    ),
    MockModule(
      id: 'i1',
      name: 'Hybrid Pro 10kW',
      category: 'Inverters',
      company: 'SunPower Corp',
      imageUrl: 'https://placehold.co/300x200/blue/white?text=Hybrid',
      description: 'Premium hybrid inverter with battery compatibility, 99% efficiency',
      qualityTier: QualityTier.premium,
    ),
    MockModule(
      id: 'i2',
      name: 'SmartGrid Inverter X',
      category: 'Inverters',
      company: 'PowerLogic',
      imageUrl: 'https://placehold.co/300x200/cyan/white?text=SmartGrid',
      description: 'Excellent quality string inverter with WiFi monitoring',
      qualityTier: QualityTier.excellent,
    ),
    MockModule(
      id: 'i3',
      name: 'MicroInverter Mini',
      category: 'Inverters',
      company: 'WireWorld',
      imageUrl: 'https://placehold.co/300x200/teal/white?text=Micro',
      description: 'Good quality microinverter for individual panel optimization',
      qualityTier: QualityTier.good,
    ),
    MockModule(
      id: 'i4',
      name: 'Basic Inverter 5kW',
      category: 'Inverters',
      company: 'Budget Solar Co',
      imageUrl: 'https://placehold.co/300x200/gray/white?text=Basic',
      description: 'Standard string inverter for small setups',
      qualityTier: QualityTier.normal,
    ),

    // CABLES - All tiers
    MockModule(
      id: '4',
      name: 'CableMax Pro',
      category: 'Cables',
      company: 'WireWorld',
      imageUrl: 'https://placehold.co/300x200/purple/white?text=Cables',
      description: 'DC solar cables - 10mm², UV resistant, 30-year lifespan',
      qualityTier: QualityTier.excellent,
    ),
    MockModule(
      id: 'c1',
      name: 'Premium Solar Cable 15mm²',
      category: 'Cables',
      company: 'WireWorld',
      imageUrl: 'https://placehold.co/300x200/purple/white?text=Premium',
      description: 'High-grade DC cables with XLPE insulation, fire-resistant',
      qualityTier: QualityTier.premium,
    ),
    MockModule(
      id: 'c2',
      name: 'AC Power Cable 6mm²',
      category: 'Cables',
      company: 'PowerLogic',
      imageUrl: 'https://placehold.co/300x200/violet/white?text=AC+Cable',
      description: 'Good quality AC cable for inverter to grid connection',
      qualityTier: QualityTier.good,
    ),
    MockModule(
      id: 'c3',
      name: 'Basic Cable Kit',
      category: 'Cables',
      company: 'Budget Solar Co',
      imageUrl: 'https://placehold.co/300x200/gray/white?text=Basic',
      description: 'Standard DC cables for small installations',
      qualityTier: QualityTier.normal,
    ),

    // HARDWARE - All tiers
    MockModule(
      id: 'h1',
      name: 'Hardware Pro Kit',
      category: 'Hardware',
      company: 'RoofSecure Systems',
      imageUrl: 'https://placehold.co/300x200/orange/white?text=Hardware',
      description: 'Premium stainless steel nuts, bolts, connectors with 25-year warranty',
      qualityTier: QualityTier.premium,
    ),
    MockModule(
      id: 'h2',
      name: 'EcoHardware Set',
      category: 'Hardware',
      company: 'GreenEnergy Solutions',
      imageUrl: 'https://placehold.co/300x200/amber/white?text=Eco',
      description: 'Excellent quality hardware kit with all essential components',
      qualityTier: QualityTier.excellent,
    ),
    MockModule(
      id: 'h3',
      name: 'Standard Hardware Pack',
      category: 'Hardware',
      company: 'WireWorld',
      imageUrl: 'https://placehold.co/300x200/orange/white?text=Standard',
      description: 'Good quality hardware for standard installations',
      qualityTier: QualityTier.good,
    ),
    MockModule(
      id: 'h4',
      name: 'Basic Hardware Kit',
      category: 'Hardware',
      company: 'Budget Solar Co',
      imageUrl: 'https://placehold.co/300x200/gray/white?text=Basic',
      description: 'Entry-level hardware components',
      qualityTier: QualityTier.normal,
    ),

    // BATTERIES - All tiers
    MockModule(
      id: 'b1',
      name: 'PowerVault Li-ion 10kWh',
      category: 'Batteries',
      company: 'SunPower Corp',
      imageUrl: 'https://placehold.co/300x200/green/white?text=Battery',
      description: 'Premium lithium-ion battery with 10-year warranty',
      qualityTier: QualityTier.premium,
    ),
    MockModule(
      id: 'b2',
      name: 'EcoStore Battery 5kWh',
      category: 'Batteries',
      company: 'GreenEnergy Solutions',
      imageUrl: 'https://placehold.co/300x200/lime/white?text=EcoStore',
      description: 'Excellent quality lithium battery, modular design',
      qualityTier: QualityTier.excellent,
    ),
    MockModule(
      id: 'b3',
      name: 'PowerBank 3kWh',
      category: 'Batteries',
      company: 'PowerLogic',
      imageUrl: 'https://placehold.co/300x200/green/white?text=PowerBank',
      description: 'Good quality battery with standard performance',
      qualityTier: QualityTier.good,
    ),
    MockModule(
      id: 'b4',
      name: 'Basic Battery 2kWh',
      category: 'Batteries',
      company: 'Budget Solar Co',
      imageUrl: 'https://placehold.co/300x200/lightgreen/white?text=Basic',
      description: 'Entry-level lithium battery for basic storage needs',
      qualityTier: QualityTier.normal,
    ),
  ];
}

class MockCompany {
  final String id;
  final String name;
  final String logoUrl;
  final String description;

  MockCompany({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.description,
  });

  static List<MockCompany> sampleCompanies = [
    MockCompany(
      id: '1',
      name: 'SolarTech Industries',
      logoUrl: 'https://placehold.co/100x100/amber/white?text=ST',
      description: 'Leading solar panel manufacturer with 20+ years experience',
    ),
    MockCompany(
      id: '2',
      name: 'RoofSecure Systems',
      logoUrl: 'https://placehold.co/100x100/emerald/white?text=RS',
      description: 'Mounting and structural solutions for residential & commercial',
    ),
    MockCompany(
      id: '3',
      name: 'SunPower Corp',
      logoUrl: 'https://placehold.co/100x100/purple/white?text=SP',
      description: 'Premium solar technology and energy storage',
    ),
    MockCompany(
      id: '4',
      name: 'WireWorld',
      logoUrl: 'https://placehold.co/100x100/blue/white?text=WW',
      description: 'Electrical components and cables',
    ),
    MockCompany(
      id: '5',
      name: 'GreenEnergy Solutions',
      logoUrl: 'https://placehold.co/100x100/green/white?text=GE',
      description: 'Complete solar solutions with excellent price-performance ratio',
    ),
    MockCompany(
      id: '6',
      name: 'PowerLogic',
      logoUrl: 'https://placehold.co/100x100/cyan/white?text=PL',
      description: 'Smart inverters and power management systems',
    ),
    MockCompany(
      id: '7',
      name: 'Budget Solar Co',
      logoUrl: 'https://placehold.co/100x100/gray/white?text=BS',
      description: 'Affordable solar components for every budget',
    ),
  ];
}

class MockOrder {
  final String id;
  final String status;
  final DateTime date;
  final String moduleName;

  MockOrder({
    required this.id,
    required this.status,
    required this.date,
    required this.moduleName,
  });

  static List<MockOrder> sampleOrders = [
    MockOrder(
      id: 'ORD-001',
      status: 'Quotation Received',
      date: DateTime.now().subtract(const Duration(days: 2)),
      moduleName: 'SolarMax Pro Setup',
    ),
    MockOrder(
      id: 'ORD-002',
      status: 'In Progress',
      date: DateTime.now().subtract(const Duration(days: 10)),
      moduleName: 'EcoMount Installation',
    ),
  ];
}

// Bundles for Complete Setup flow
class MockBundle {
  final String id;
  final String name;
  final String description;
  final String company;
  final List<String> moduleIds;
  final String imageUrl;
  final bool isFeatured;

  MockBundle({
    required this.id,
    required this.name,
    required this.description,
    required this.company,
    required this.moduleIds,
    required this.imageUrl,
    this.isFeatured = false,
  });

  static List<MockBundle> sampleBundles = [
    MockBundle(
      id: 'b1',
      name: 'Residential Starter Kit',
      description: 'Complete 3kW solar setup for small homes - includes premium panels, mounting, inverter, cables and hardware',
      company: 'SolarTech Industries',
      moduleIds: ['1', '2', '4', 'h2', 'i2'],
      imageUrl: 'https://placehold.co/300x200/amber/white?text=Residential',
      isFeatured: true,
    ),
    MockBundle(
      id: 'b2',
      name: 'Commercial Pro Package',
      description: 'Complete 50kW commercial solar setup with premium components and 25-year warranty',
      company: 'SunPower Corp',
      moduleIds: ['1', 'm1', 'c1', 'h1', 'i1'],
      imageUrl: 'https://placehold.co/300x200/purple/white?text=Commercial',
      isFeatured: true,
    ),
    MockBundle(
      id: 'b3',
      name: 'Small Business Essential',
      description: 'Complete 10kW setup for small businesses with excellent quality components',
      company: 'RoofSecure Systems',
      moduleIds: ['p2', '2', 'c2', 'h2', 'i2'],
      imageUrl: 'https://placehold.co/300x200/emerald/white?text=Business',
    ),
    MockBundle(
      id: 'b4',
      name: 'Budget Home Setup',
      description: 'Complete 2kW solar setup for budget-conscious homeowners',
      company: 'Budget Solar Co',
      moduleIds: ['p4', '6', 'c3', 'h4', 'i4'],
      imageUrl: 'https://placehold.co/300x200/gray/white?text=Budget',
      isFeatured: false,
    ),
    MockBundle(
      id: 'b5',
      name: 'Farm House Kit',
      description: 'Complete 5kW setup for farmhouses with battery storage option',
      company: 'GreenEnergy Solutions',
      moduleIds: ['p2', 'm2', 'c2', 'h2', 'b2'],
      imageUrl: 'https://placehold.co/300x200/green/white?text=Farm',
      isFeatured: false,
    ),
  ];
}

// Quotations for comparison screen
class MockQuotation {
  final String id;
  final String quoteRequestId;
  final String providerId;
  final String providerName;
  final double price;
  final String terms;
  final String validity;
  final String status; // submitted, viewed, accepted, rejected, expired

  MockQuotation({
    required this.id,
    required this.quoteRequestId,
    required this.providerId,
    required this.providerName,
    required this.price,
    required this.terms,
    required this.validity,
    required this.status,
  });

  static List<MockQuotation> sampleQuotations = [
    MockQuotation(
      id: 'q1',
      quoteRequestId: 'qr1',
      providerId: '1',
      providerName: 'SolarTech Industries',
      price: 245000,
      terms: 'Net 30 payment terms, installation within 3 weeks, 25-year warranty',
      validity: 'Valid for 14 days',
      status: 'submitted',
    ),
    MockQuotation(
      id: 'q2',
      quoteRequestId: 'qr1',
      providerId: '3',
      providerName: 'SunPower Corp',
      price: 268000,
      terms: '50% advance, 50% on completion, installation within 2 weeks',
      validity: 'Valid for 7 days',
      status: 'submitted',
    ),
    MockQuotation(
      id: 'q3',
      quoteRequestId: 'qr2',
      providerId: '5',
      providerName: 'GreenEnergy Solutions',
      price: 185000,
      terms: 'Full payment upfront, quick installation',
      validity: 'Valid for 10 days',
      status: 'submitted',
    ),
    MockQuotation(
      id: 'q4',
      quoteRequestId: 'qr2',
      providerId: '7',
      providerName: 'Budget Solar Co',
      price: 145000,
      terms: '30% booking, 70% before delivery, standard warranty',
      validity: 'Valid for 20 days',
      status: 'viewed',
    ),
    MockQuotation(
      id: 'q5',
      quoteRequestId: 'qr3',
      providerId: '6',
      providerName: 'PowerLogic',
      price: 95000,
      terms: 'Net 15 payment terms for commercial clients',
      validity: 'Valid for 7 days',
      status: 'accepted',
    ),
  ];
}

// Quote Requests
class MockQuoteRequest {
  final String id;
  final String type; // complete_setup, custom_setup, specific_modules
  final DateTime createdAt;
  final String status; // pending, quoted, accepted

  MockQuoteRequest({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.status,
  });

  static List<MockQuoteRequest> sampleQuoteRequests = [
    MockQuoteRequest(
      id: 'qr1',
      type: 'specific_modules',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      status: 'quoted',
    ),
    MockQuoteRequest(
      id: 'qr2',
      type: 'complete_setup',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      status: 'quoted',
    ),
    MockQuoteRequest(
      id: 'qr3',
      type: 'custom_setup',
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
      status: 'accepted',
    ),
    MockQuoteRequest(
      id: 'qr4',
      type: 'specific_modules',
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
      status: 'rejected',
    ),
  ];
}