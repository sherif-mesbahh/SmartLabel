# Smart Label System

## 📋 Project Overview
The Smart Label System is an innovative digital price tag solution designed for modern retail environments. This system enables instant price updates across multiple digital displays through a centralized management platform, eliminating the need for manual price tag changes and ensuring price consistency throughout the store.

## 🎯 Project Goals
- Eliminate manual price tag updates
- Ensure real-time price synchronization
- Reduce pricing errors
- Improve operational efficiency
- Enhance customer experience

## 🏗️ System Architecture

### Backend API
The backend serves as the core component of the system, built using modern .NET technologies and following clean architecture principles.

#### Key Components:
- **Domain Layer**: Core business logic and entities
- **Application Layer**: Business rules and use cases
- **Infrastructure Layer**: External services and data access
- **Presentation Layer**: API endpoints and controllers

### Validation & Behaviors
- **Validation Behaviors**:
  - FluentValidation for request validation
  - Cross-cutting validation concerns
  - Custom validation behaviors
  - Business rule validation
  - Input sanitization
  - Validation pipeline integration

### Real-time Communication
- **SignalR Integration**:
  - Real-time price updates to all connected displays
  - Bi-directional communication for display status monitoring
  - Automatic reconnection handling
  - Hub-based architecture for different update types
  - WebSocket fallback for older clients

### Caching Strategy
- **In-Memory Caching**:
  - Distributed caching for price data
  - Cache invalidation on price updates
  - Memory-optimized data structures
  - Cache warming for frequently accessed data
  - Sliding expiration policies

### Background Services
- **Scheduled Tasks**:
  - Price synchronization jobs
  - Sheduled sending notification when banner is added

### Design Patterns
- **Clean Architecture**: Strict separation of concerns
- **CQRS Pattern**: 
  - Commands: Entity Framework Core for data modifications
  - Queries: Dapper for high-performance reads
- **Repository Pattern**: Abstracted data access
- **Unit of Work**: Transaction management
- **Factory Pattern**: Object creation and dependency management
- **Result Pattern**: Standardized API responses
- **Behavior Pattern**: Cross-cutting concerns like validation and logging

## ✨ Features

### Core Functionality
- Real-time price updates across all displays
- Centralized price management
- Product information management
- Display synchronization
- Price history tracking
- Automatic display health monitoring
- Background data synchronization
- Intelligent caching system

### Security
- JWT-based authentication
- Role-based access control (RBAC)
- Secure API endpoints
- Input validation and sanitization
- Request validation pipeline
- Business rule enforcement

### Performance
- Optimized database queries
- Efficient stored procedures
- High-concurrency support
- Scalable architecture
- In-memory caching for fast data access
- Background processing for heavy tasks
- Real-time updates via SignalR

## 🛠️ Technology Stack

### Backend
- ASP.NET Core 9+
- Entity Framework Core
- Dapper
- SQL Server
- JWT Authentication
- SignalR for real-time communication
- IMemoryCache for in-memory caching
- Background Services (IHostedService)
- FluentValidation for request validation
- MediatR for behavior pipeline

### Development Tools
- Visual Studio 2022
- SQL Server Management Studio
- Git for version control

## 📦 Project Structure
```
SmartLabel/
├── src/
│   ├── SmartLabel.Domain/         # Domain entities and interfaces
│   ├── SmartLabel.Application/    # Business logic and use cases
│   ├── SmartLabel.Infrastructure/ # External services and data access
│   └── SmartLabel.Presentation/   # API controllers and endpoints
```

## 🚀 Getting Started

### Prerequisites
- .NET 9 SDK or later
- SQL Server 2019 or later
- Visual Studio 2022 (recommended)

### Installation
1. Clone the repository
```bash
git clone https://github.com/sherif-mesbahh/SmartLabel.git
```

2. Navigate to the project directory
```bash
cd SmartLabel
```

3. Restore dependencies
```bash
dotnet restore
```

4. Update database connection string in `appsettings.json`

5. Run database migrations
```bash
dotnet ef database update
```

6. Start the application
```bash
dotnet run
```

## 📝 API Documentation
API documentation is available at `/swagger` when running the application in development mode.

## 🤝 Contributing
1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📄 License
This project is licensed under the MIT License - see the LICENSE file for details.

## 👥 Team
This project is developed by a 7-member team, each contributing their expertise in different areas of the system.

## 🔄 Version Control
- Main branch: Production-ready code
- Development branch: Latest development changes
- Feature branches: Individual feature development
